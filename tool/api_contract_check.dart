import 'dart:convert';
import 'dart:io';

import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/dart/analysis/utilities.dart';

/// Extracts app routes from syntax, without loading Flutter or contacting a server.
/// Unknown path expressions fail closed: extending a client's routing style must
/// extend this extractor rather than silently omit its calls.
class AppHttpCall {
  const AppHttpCall(this.method, this.path, this.file, this.line);
  final String method;
  final String path;
  final String file;
  final int line;

  Map<String, Object> toJson() => {
    'method': method,
    'path': path,
    'file': file,
    'line': line,
  };
}

List<AppHttpCall> discoverAppHttpCalls(Directory root) {
  final files =
      root
          .listSync(recursive: true)
          .whereType<File>()
          .where(
            (file) =>
                file.path.endsWith('.dart') &&
                !file.path.endsWith('.g.dart') &&
                !file.path.endsWith('.freezed.dart'),
          )
          .toList()
        ..sort((a, b) => a.path.compareTo(b.path));
  final constants = parseString(
    content: File(
      '${root.path}/core/constants/api_constants.dart',
    ).readAsStringSync(),
  ).unit;
  final apiClass = constants.declarations
      .whereType<ClassDeclaration>()
      .singleWhere((node) => node.name.lexeme == 'ApiConstants');
  final values = <String, Expression>{};
  for (final field in apiClass.members.whereType<FieldDeclaration>()) {
    for (final variable in field.fields.variables) {
      if (variable.initializer != null) {
        values[variable.name.lexeme] = variable.initializer!;
      }
    }
  }
  for (final method in apiClass.members.whereType<MethodDeclaration>()) {
    if (method.body is ExpressionFunctionBody) {
      values[method.name.lexeme] =
          (method.body as ExpressionFunctionBody).expression;
    }
  }
  final result = <AppHttpCall>[];
  for (final file in files) {
    final parsed = parseString(content: file.readAsStringSync());
    parsed.unit.accept(
      _CallVisitor(file.path, parsed.lineInfo.getLocation, values, result),
    );
  }
  return result;
}

class _CallVisitor extends RecursiveAstVisitor<void> {
  _CallVisitor(this.file, this.location, this.values, this.calls);
  final String file;
  final dynamic Function(int) location;
  final Map<String, Expression> values;
  final List<AppHttpCall> calls;
  static const verbs = {
    'get',
    'post',
    'put',
    'patch',
    'delete',
    'head',
    'options',
  };

  String? resolve(Expression expression, [Set<String> seen = const {}]) {
    if (expression is SimpleStringLiteral) return expression.value;
    if (expression is StringInterpolation) {
      return expression.elements.map((element) {
        if (element is InterpolationString) return element.value;
        return resolve((element as InterpolationExpression).expression, seen) ??
            '{}';
      }).join();
    }
    String? name;
    if (expression is PrefixedIdentifier &&
        expression.prefix.name == 'ApiConstants') {
      name = expression.identifier.name;
    } else if (expression is MethodInvocation &&
        expression.target?.toSource() == 'ApiConstants') {
      name = expression.methodName.name;
    } else if (expression is SimpleIdentifier &&
        values.containsKey(expression.name)) {
      name = expression.name;
    }
    if (name != null && values.containsKey(name) && !seen.contains(name)) {
      return resolve(values[name]!, {...seen, name});
    }
    return null;
  }

  void add(String method, Expression expression, AstNode call) {
    final path = resolve(expression);
    if (path == null) {
      throw StateError(
        'Unresolved HTTP path $file:${location(call.offset).lineNumber}: ${expression.toSource()}',
      );
    }
    if (path.startsWith('http://') || path.startsWith('https://')) return;
    if (!path.startsWith('/')) throw StateError('Invalid HTTP path: $path');
    calls.add(
      AppHttpCall(
        method,
        '/api$path',
        file,
        location(call.offset).lineNumber as int,
      ),
    );
  }

  @override
  void visitAnnotation(Annotation node) {
    if (verbs.contains(node.name.name.toLowerCase())) {
      add(node.name.name, node.arguments!.arguments.single, node);
    }
    super.visitAnnotation(node);
  }

  @override
  void visitMethodInvocation(MethodInvocation node) {
    final method = node.methodName.name;
    final target = node.target?.toSource() ?? '';
    if (target.toLowerCase().contains('dio') &&
        {
          'request',
          'fetch',
          'download',
          'getUri',
          'postUri',
          'putUri',
          'patchUri',
          'deleteUri',
          'requestUri',
          'downloadUri',
        }.contains(method)) {
      // Auth retry forwards an already inventoried RequestOptions unchanged.
      if (!(file.endsWith(
            '/core/network/dio/interceptors/auth_interceptor.dart',
          ) &&
          method == 'fetch' &&
          node.argumentList.arguments.first.toSource() == 'requestOptions')) {
        throw StateError(
          'Uninventoried Dio call $file:${location(node.offset).lineNumber}: $method',
        );
      }
    }
    if (verbs.contains(method) && target.toLowerCase().contains('dio')) {
      final expression = node.argumentList.arguments.first;
      if (resolve(expression) != null) {
        add(method.toUpperCase(), expression, node);
      } else {
        final enclosing = node.thisOrAncestorOfType<MethodDeclaration>();
        // Resolve first-argument path forwarding, e.g. _getList(path).
        final parameter = enclosing?.parameters?.parameters.first;
        final parameterName = parameter?.name?.lexeme;
        if (expression is SimpleIdentifier &&
            expression.name == parameterName) {
          final forwarded = _ForwardedCalls(enclosing!.name.lexeme);
          node.root.accept(forwarded);
          if (forwarded.nodes.isEmpty) {
            throw StateError('Unresolved HTTP helper: $file');
          }
          for (final caller in forwarded.nodes) {
            add(
              method.toUpperCase(),
              caller.argumentList.arguments.first,
              caller,
            );
          }
        } else if (file.endsWith(
              '/orders/data/services/mapbox_map_service.dart',
            ) &&
            expression.toSource() == 'url') {
          // External Mapbox Directions URL is inventoried separately.
        } else {
          add(method.toUpperCase(), expression, node);
        }
      }
    }
    super.visitMethodInvocation(node);
  }
}

class _ForwardedCalls extends RecursiveAstVisitor<void> {
  _ForwardedCalls(this.name);
  final String name;
  final nodes = <MethodInvocation>[];
  @override
  void visitMethodInvocation(MethodInvocation node) {
    if (node.methodName.name == name) nodes.add(node);
    super.visitMethodInvocation(node);
  }
}

// Gateway regex constraints can themselves contain braces (UUID {36}).
String normalizedRoute(String path) => path
    .split('/')
    .map(
      (segment) =>
          segment.startsWith('{') && segment.endsWith('}') ? '{}' : segment,
    )
    .join('/');

List<String> checkAppHttpCalls(
  List<AppHttpCall> calls,
  Map<String, dynamic> contract,
  Map<String, dynamic> edge,
) {
  final failures = <String>[];
  for (final call in calls) {
    final normalized = normalizedRoute(call.path);
    final exists = (contract['operations'] as List).cast<Map>().any(
      (operation) =>
          (operation['verbs'] as List).contains(call.method) &&
          normalizedRoute(operation['path'] as String) == normalized,
    );
    final exposed = (edge['routes'] as List).cast<Map>().any(
      (route) =>
          (route['methods'] as List).contains(call.method) &&
          (route['paths'] as List).cast<String>().any(
            (path) => normalizedRoute(path) == normalized,
          ),
    );
    if (!exists || !exposed) {
      failures.add(
        '${call.file}:${call.line} ${call.method} ${call.path}: '
        '${!exists ? 'MISSING_IN_BACKEND' : 'NOT_PUBLIC'}',
      );
    }
  }
  return failures;
}

void main() {
  final calls = discoverAppHttpCalls(Directory('lib'));
  stdout.writeln(
    const JsonEncoder.withIndent(
      '  ',
    ).convert(calls.map((c) => c.toJson()).toList()),
  );
  final failures = checkAppHttpCalls(
    calls,
    jsonDecode(File('contracts/backend/http-contract.json').readAsStringSync())
        as Map<String, dynamic>,
    jsonDecode(
          File(
            'contracts/backend/public-edge-manifest.json',
          ).readAsStringSync(),
        )
        as Map<String, dynamic>,
  );
  if (failures.isNotEmpty) {
    stderr.writeln(failures.join('\n'));
    exitCode = 1;
  }
}
