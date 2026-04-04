#!/usr/bin/env python3
"""
Script to remove invalid const keywords from widgets using theme colors
"""

import re
from pathlib import Path

def remove_invalid_consts(file_path):
    """Remove const keyword from widgets that use context.colors"""
    with open(file_path, 'r', encoding='utf-8') as f:
        content = f.read()
    
    original_content = content
    
    # Pattern 1: Remove const from Text widgets with context.colors
    content = re.sub(
        r'const\s+(Text\([^)]*context\.colors[^)]*\))',
        r'\1',
        content,
        flags=re.DOTALL
    )
    
    # Pattern 2: Remove const from Icon with context.colors
    content = re.sub(
        r'const\s+(Icon\([^)]*context\.colors[^)]*\))',
        r'\1',
        content,
        flags=re.DOTALL
    )
    
    # Pattern 3: Remove const from Container/Padding/SizedBox with context.colors inside
    content = re.sub(
        r'const\s+((?:Container|Padding|SizedBox|Column|Row|Stack)\([^)]*context\.colors[^)]*\))',
        r'\1',
        content,
        flags=re.DOTALL
    )
    
    # Save if changed
    if content != original_content:
        with open(file_path, 'w', encoding='utf-8') as f:
            f.write(content)
        return True
    return False

def main():
    """Process all Dart files"""
    features_dir = Path('lib/features')
    dart_files = list(features_dir.rglob('*.dart'))
    
    print(f"Processing {len(dart_files)} files...")
    updated = 0
    
    for dart_file in dart_files:
        if remove_invalid_consts(dart_file):
            print(f"Updated: {dart_file}")
            updated += 1
    
    print(f"\n✓ Removed invalid const from {updated} files")

if __name__ == '__main__':
    main()
