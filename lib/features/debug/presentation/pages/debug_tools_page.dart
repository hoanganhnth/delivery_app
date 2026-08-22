import 'package:delivery_app/core/config/api_endpoint_controller.dart';
import 'package:delivery_app/core/debug/debug_log_store.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final debugLogStoreProvider = Provider<DebugLogStore>((ref) {
  return DebugLogStore.instance;
});

class DebugToolsPage extends ConsumerStatefulWidget {
  const DebugToolsPage({super.key});

  @override
  ConsumerState<DebugToolsPage> createState() => _DebugToolsPageState();
}

class _DebugToolsPageState extends ConsumerState<DebugToolsPage> {
  late final TextEditingController _urlController;
  String? _errorMessage;
  String? _noticeMessage;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _urlController = TextEditingController(
      text: ref.read(apiEndpointControllerProvider).gatewayOrigin,
    );
  }

  @override
  void dispose() {
    _urlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!kDebugMode) {
      return const Scaffold(
        body: Center(child: Text('Debug tools chỉ có trong debug build.')),
      );
    }

    final endpoint = ref.read(apiEndpointControllerProvider);
    final logs = ref.read(debugLogStoreProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Debug tools')),
      body: ListenableBuilder(
        listenable: endpoint,
        builder: (context, _) {
          return ListenableBuilder(
            listenable: logs,
            builder: (context, _) => CustomScrollView(
              slivers: [
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                  sliver: SliverToBoxAdapter(
                    child: _BackendCard(
                      endpoint: endpoint,
                      controller: _urlController,
                      isSaving: _isSaving,
                      errorMessage: _errorMessage,
                      noticeMessage: _noticeMessage,
                      onSave: _saveEndpoint,
                      onReset: _resetEndpoint,
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                  sliver: SliverToBoxAdapter(
                    child: Row(
                      children: [
                        Text(
                          'Log gần đây (${logs.entries.length})',
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(fontWeight: FontWeight.w800),
                        ),
                        const Spacer(),
                        TextButton.icon(
                          onPressed: logs.entries.isEmpty ? null : logs.clear,
                          icon: const Icon(Icons.delete_sweep_outlined),
                          label: const Text('Xóa log'),
                        ),
                      ],
                    ),
                  ),
                ),
                if (logs.entries.isEmpty)
                  const SliverFillRemaining(
                    hasScrollBody: false,
                    child: Center(child: Text('Chưa có log trong phiên này.')),
                  )
                else
                  SliverPadding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 32),
                    sliver: SliverList.builder(
                      itemCount: logs.entries.length,
                      itemBuilder: (context, index) {
                        final entry =
                            logs.entries[logs.entries.length - 1 - index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: _LogCard(entry: entry),
                        );
                      },
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }

  Future<void> _saveEndpoint() async {
    if (_isSaving) return;
    setState(() {
      _isSaving = true;
      _errorMessage = null;
      _noticeMessage = null;
    });
    try {
      final endpoint = ref.read(apiEndpointControllerProvider);
      await endpoint.setGatewayOrigin(_urlController.text);
      _urlController.text = endpoint.gatewayOrigin;
      if (!mounted) return;
      setState(() {
        _noticeMessage = 'Đã đổi backend. Các API call mới dùng URL này.';
      });
    } on FormatException catch (error) {
      if (!mounted) return;
      setState(() => _errorMessage = error.message);
    } catch (_) {
      if (!mounted) return;
      setState(() => _errorMessage = 'Không thể lưu backend URL.');
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  Future<void> _resetEndpoint() async {
    final endpoint = ref.read(apiEndpointControllerProvider);
    await endpoint.reset();
    if (!mounted) return;
    _urlController.text = endpoint.gatewayOrigin;
    setState(() {
      _errorMessage = null;
      _noticeMessage = 'Đã khôi phục backend mặc định.';
    });
  }
}

class _BackendCard extends StatelessWidget {
  const _BackendCard({
    required this.endpoint,
    required this.controller,
    required this.isSaving,
    required this.errorMessage,
    required this.noticeMessage,
    required this.onSave,
    required this.onReset,
  });

  final ApiEndpointController endpoint;
  final TextEditingController controller;
  final bool isSaving;
  final String? errorMessage;
  final String? noticeMessage;
  final VoidCallback onSave;
  final VoidCallback onReset;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Backend Gateway',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 4),
            Text(
              'Origin hiện tại: ${endpoint.gatewayOrigin}',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 12),
            TextField(
              controller: controller,
              keyboardType: TextInputType.url,
              autocorrect: false,
              decoration: const InputDecoration(
                labelText: 'Gateway origin',
                hintText: 'http://10.0.2.2:8079',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: FilledButton.icon(
                    onPressed: isSaving ? null : onSave,
                    icon: isSaving
                        ? const SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Icon(Icons.save_outlined),
                    label: const Text('Lưu URL'),
                  ),
                ),
                const SizedBox(width: 8),
                OutlinedButton(
                  onPressed: isSaving ? null : onReset,
                  child: const Text('Mặc định'),
                ),
              ],
            ),
            if (errorMessage != null) ...[
              const SizedBox(height: 8),
              Text(errorMessage!, style: TextStyle(color: scheme.error)),
            ],
            if (noticeMessage != null) ...[
              const SizedBox(height: 8),
              Text(noticeMessage!, style: TextStyle(color: scheme.primary)),
            ],
          ],
        ),
      ),
    );
  }
}

class _LogCard extends StatelessWidget {
  const _LogCard({required this.entry});

  final DebugLogEntry entry;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final time = entry.timestamp.toLocal().toIso8601String().substring(11, 19);
    final title = entry.kind == DebugLogKind.api
        ? '${entry.method ?? ''} ${entry.url ?? ''}'.trim()
        : entry.message;
    final status = entry.statusCode == null ? '' : ' · ${entry.statusCode}';
    final duration = entry.durationMs == null ? '' : ' · ${entry.durationMs}ms';
    final color = switch (entry.level) {
      DebugLogLevel.debug => colorScheme.primary,
      DebugLogLevel.info => Colors.green,
      DebugLogLevel.warning => Colors.orange,
      DebugLogLevel.error => colorScheme.error,
    };

    return Card(
      child: ExpansionTile(
        leading: Icon(
          entry.kind == DebugLogKind.api
              ? Icons.http_outlined
              : Icons.article_outlined,
          color: color,
        ),
        title: Text(title, maxLines: 2, overflow: TextOverflow.ellipsis),
        subtitle: Text(
          '$time${entry.phase == null ? '' : ' · ${entry.phase!.name}'}$status$duration',
        ),
        childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        children: [
          if (entry.kind == DebugLogKind.app)
            Align(
              alignment: Alignment.centerLeft,
              child: SelectableText(entry.message),
            ),
          if (entry.requestBody != null)
            _PayloadBlock(label: 'Request', value: entry.requestBody!),
          if (entry.responseBody != null)
            _PayloadBlock(label: 'Response', value: entry.responseBody!),
          if (entry.kind == DebugLogKind.api &&
              entry.requestBody == null &&
              entry.responseBody == null)
            const Align(
              alignment: Alignment.centerLeft,
              child: Text('Không có payload.'),
            ),
        ],
      ),
    );
  }
}

class _PayloadBlock extends StatelessWidget {
  const _PayloadBlock({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(top: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: const TextStyle(fontWeight: FontWeight.w700)),
            const SizedBox(height: 4),
            SelectableText(
              value,
              style: const TextStyle(fontFamily: 'monospace', fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
