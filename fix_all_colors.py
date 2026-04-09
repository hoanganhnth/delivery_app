#!/usr/bin/env python3
"""
Script to fix all context.colors usages
"""
import os
import re
from pathlib import Path

def should_process_file(file_path):
    """Check if file should be processed"""
    if not file_path.endswith('.dart'):
        return False
    if '.git' in file_path or 'build' in file_path:
        return False
    return True

def needs_fixing(content):
    """Check if file needs fixing"""
    return 'context.colors' in content and 'ref.watch(themeColorsProvider)' not in content

def convert_to_consumer_widget(content):
    """Convert StatelessWidget to ConsumerWidget"""
    # Replace extends StatelessWidget
    content = content.replace('extends StatelessWidget', 'extends ConsumerWidget')
    
    # Update build method signature for StatelessWidget->ConsumerWidget
    content = re.sub(
        r'(@override\s+Widget\s+build\(BuildContext\s+context\))',
        r'@override\n  Widget build(BuildContext context, WidgetRef ref)',
        content
    )
    
    return content

def add_imports(content):
    """Add required imports"""
    # Add riverpod import if missing
    if 'flutter_riverpod' not in content:
        first_import_match = re.search(r"^import '", content, re.MULTILINE)
        if first_import_match:
            insert_pos = first_import_match.start()
            content = content[:insert_pos] + "import 'package:flutter_riverpod/flutter_riverpod.dart';\n" + content[insert_pos:]
    
    # Add theme_provider import if context.colors present
    if 'context.colors' in content and 'theme_provider.dart' not in content:
        first_import_match = re.search(r"^import '", content, re.MULTILINE)
        if first_import_match:
            insert_pos = first_import_match.start()
            content = content[:insert_pos] + "import 'package:delivery_app/core/theme/theme_provider.dart';\n" + content[insert_pos:]
    
    return content

def replace_context_colors(content):
    """Replace all context.colors with ref.watch"""
    # Strategy: Replace context.colors step by step
    
    # First, handle the simple case: final colors = context.colors
    content = re.sub(
        r'final\s+colors\s*=\s*context\.colors',
        r'final colors = ref.watch(themeColorsProvider)',
        content
    )
    
    # Then for ConsumerWidget, we need to wrap inline usages in a Consumer widget
    # Or better: create a local variable in build method
    
    # For now, let's just replace direct usages with a Consumer wrapper pattern
    # This is complex, so we'll focus on the "final colors" pattern first
    
    return content

def fix_file(file_path):
    """Fix a single file"""
    with open(file_path, 'r') as f:
        content = f.read()
    
    if not needs_fixing(content):
        return False
    
    original = content
    
    # Add imports
    content = add_imports(content)
    
    # Check if StatelessWidget that needs conversion
    if 'extends StatelessWidget' in content:
        content = convert_to_consumer_widget(content)
    
    # Replace colors
    content = replace_context_colors(content)
    
    if content != original:
        with open(file_path, 'w') as f:
            f.write(content)
        return True
    return False

def main():
    """Main entry point"""
    lib_path = Path('/Users/a/Documents/delivery_app/lib')
    fixed_count = 0
    total_count = 0
    
    for file_path in lib_path.rglob('*.dart'):
        if should_process_file(str(file_path)):
            if needs_fixing(open(file_path).read()):
                total_count += 1
                try:
                    if fix_file(str(file_path)):
                        fixed_count += 1
                        print(f'✅ Fixed: {file_path.relative_to(lib_path.parent)}')
                except Exception as e:
                    print(f'❌ Error: {file_path}: {e}')
    
    print(f'\n📊 Summary: {fixed_count}/{total_count} files fixed')

if __name__ == '__main__':
    main()
