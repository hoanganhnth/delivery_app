#!/usr/bin/env python3
"""
Script to migrate all context.colors to ref.watch(themeColorsProvider)
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

def is_stateless_widget(content):
    """Check if widget is StatelessWidget (need to convert to ConsumerWidget)"""
    return 'extends StatelessWidget' in content

def is_stateful_widget(content):
    """Check if widget is StatefulWidget (need to convert to ConsumerStatefulWidget)"""
    return 'extends State<' in content or 'State<' in content

def is_consumer_widget(content):
    """Check if already ConsumerWidget"""
    return 'ConsumerWidget' in content or 'ConsumerState' in content

def is_screen_or_major_widget(file_path):
    """Check if this is a screen or major widget"""
    return '/screens/' in file_path or 'screen.dart' in file_path

def fix_file(file_path):
    """Fix a single file"""
    with open(file_path, 'r') as f:
        content = f.read()
    
    original = content
    
    # Skip if already fixed
    if 'ref.watch(themeColorsProvider)' in content:
        return False
    
    # Skip if no context.colors
    if 'context.colors' not in content:
        return False
    
    # Add import if needed
    if 'import \'package:flutter_riverpod/flutter_riverpod.dart\'' not in content:
        # Find the last import
        imports = re.findall(r'^import \'.*?\';', content, re.MULTILINE)
        if imports:
            last_import = imports[-1]
            content = content.replace(
                last_import,
                last_import + '\nimport \'package:flutter_riverpod/flutter_riverpod.dart\';',
                1
            )
    
    # Add theme_provider import if needed
    if 'themeColorsProvider' in content and 'import \'package:delivery_app/core/theme/theme_provider.dart\'' not in content:
        imports = re.findall(r'^import \'.*?\';', content, re.MULTILINE)
        if imports:
            last_import = imports[-1]
            content = content.replace(
                last_import,
                last_import + '\nimport \'package:delivery_app/core/theme/theme_provider.dart\';',
                1
            )
    
    # Handle StatelessWidget -> ConsumerWidget
    if is_stateless_widget(content) and not is_consumer_widget(content):
        content = content.replace('extends StatelessWidget', 'extends ConsumerWidget')
        # Fix build signature
        content = re.sub(
            r'Widget build\(BuildContext context\)',
            r'Widget build(BuildContext context, WidgetRef ref)',
            content
        )
    
    # Handle State -> ConsumerState
    if is_stateful_widget(content) and not is_consumer_widget(content):
        # This is more complex, skip for now
        pass
    
    # Replace context.colors with ref.watch(themeColorsProvider)
    # But only replace the pattern "final colors = context.colors"
    content = re.sub(
        r'final\s+colors\s*=\s*context\.colors',
        r'final colors = ref.watch(themeColorsProvider)',
        content
    )
    
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
