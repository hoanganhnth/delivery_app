#!/usr/bin/env python3
"""
Script to migrate hardcoded Amber Hearth colors to theme system
Run this from the project root: python3 scripts/migrate_to_theme.py
"""

import os
import re
from pathlib import Path

# Color mappings: hardcoded color -> theme accessor
COLOR_MAPPINGS = {
    # Primary amber
    r'Color\(0xFFF49D25\)': 'context.colors.primary',
    r'Color\(0xFFf49d25\)': 'context.colors.primary',
    r'const Color\(0xFFF49D25\)': 'context.colors.primary',
    r'const Color\(0xFFf49d25\)': 'context.colors.primary',
    
    # Secondary umber  
    r'Color\(0xFF9C7A49\)': 'context.colors.secondary',
    r'Color\(0xFF9c7a49\)': 'context.colors.secondary',
    r'const Color\(0xFF9C7A49\)': 'context.colors.secondary',
    r'const Color\(0xFF9c7a49\)': 'context.colors.secondary',
    
    # Background
    r'Color\(0xFFF8F7F5\)': 'context.colors.background',
    r'const Color\(0xFFF8F7F5\)': 'context.colors.background',
    
    # Surface (white)
    r'Color\(0xFFFFFFFF\)': 'context.colors.surface',
    r'const Color\(0xFFFFFFFF\)': 'context.colors.surface',
    
    # Text colors
    r'Colors\.grey\[900\]': 'context.colors.textPrimary',
    r'Colors\.grey\[800\]': 'context.colors.textPrimary',
    r'Colors\.grey\[600\]': 'context.colors.textSecondary',
}

# Static const patterns to remove
STATIC_CONST_PATTERNS = [
    r'\s*static const Color _primaryColor = Color\(0xFFF49D25\);?\n',
    r'\s*static const Color _backgroundColor = Color\(0xFFF8F7F5\);?\n',
    r'\s*static const Color _secondaryColor = Color\(0xFF9C7A49\);?\n',
    r'\s*static const Color _surfaceColor = Color\(0xFFFFFFFF\);?\n',
]

# Import to add if not present
THEME_IMPORT = "import 'package:delivery_app/core/theme/theme_extensions.dart';\n"

def should_skip_file(file_path):
    """Check if file should be skipped"""
    skip_paths = [
        'core/theme/app_colors.dart',  # Theme definition file
        'generated/',
        'build/',
        '.dart_tool/',
        'test/',
    ]
    return any(skip in str(file_path) for skip in skip_paths)

def add_theme_import(content):
    """Add theme import if not present"""
    if 'theme_extensions.dart' in content:
        return content
    
    # Find where to insert (after package imports, before relative imports)
    lines = content.split('\n')
    insert_idx = 0
    
    for i, line in enumerate(lines):
        if line.startswith('import '):
            insert_idx = i + 1
            if not line.startswith('import \'package:'):
                insert_idx = i
                break
    
    lines.insert(insert_idx, THEME_IMPORT.rstrip())
    return '\n'.join(lines)

def remove_static_consts(content):
    """Remove static const color declarations"""
    for pattern in STATIC_CONST_PATTERNS:
        content = re.sub(pattern, '', content)
    return content

def replace_hardcoded_colors(content):
    """Replace hardcoded colors with theme accessors"""
    
    # First, handle withValues cases
    content = re.sub(
        r'(?:const\s+)?Color\(0xFFF49D25\)\.withValues\(alpha:\s*([\d.]+)\)',
        r'context.colors.primary.withValues(alpha: \1)',
        content
    )
    content = re.sub(
        r'(?:const\s+)?Color\(0xFFf49d25\)\.withValues\(alpha:\s*([\d.]+)\)',
        r'context.colors.primary.withValues(alpha: \1)',
        content
    )
    content = re.sub(
        r'(?:const\s+)?Color\(0xFF9C7A49\)\.withValues\(alpha:\s*([\d.]+)\)',
        r'context.colors.secondary.withValues(alpha: \1)',
        content
    )
    content = re.sub(
        r'(?:const\s+)?Color\(0xFF9c7a49\)\.withValues\(alpha:\s*([\d.]+)\)',
        r'context.colors.secondary.withValues(alpha: \1)',
        content
    )
    content = re.sub(
        r'(?:const\s+)?Color\(0xFFF8F7F5\)\.withValues\(alpha:\s*([\d.]+)\)',
        r'context.colors.background.withValues(alpha: \1)',
        content
    )
    
    # Then handle simple color replacements
    content = re.sub(r'(?:const\s+)?Color\(0xFFF49D25\)', 'context.colors.primary', content)
    content = re.sub(r'(?:const\s+)?Color\(0xFFf49d25\)', 'context.colors.primary', content)
    content = re.sub(r'(?:const\s+)?Color\(0xFF9C7A49\)', 'context.colors.secondary', content)
    content = re.sub(r'(?:const\s+)?Color\(0xFF9c7a49\)', 'context.colors.secondary', content)
    content = re.sub(r'(?:const\s+)?Color\(0xFFF8F7F5\)', 'context.colors.background', content)
    content = re.sub(r'(?:const\s+)?Color\(0xFFFFFFFF\)', 'context.colors.surface', content)
    
    # Replace text color references
    content = re.sub(r'Colors\.grey\[900\]', 'context.colors.textPrimary', content)
    content = re.sub(r'Colors\.grey\[800\]', 'context.colors.textPrimary', content)
    content = re.sub(r'Colors\.grey\[600\]', 'context.colors.textSecondary', content)
    
    # Replace static const references
    content = re.sub(r'\b_primaryColor\b', 'context.colors.primary', content)
    content = re.sub(r'\b_secondaryColor\b', 'context.colors.secondary', content)
    content = re.sub(r'\b_backgroundColor\b', 'context.colors.background', content)
    content = re.sub(r'\b_surfaceColor\b', 'context.colors.surface', content)
    
    return content

def migrate_file(file_path):
    """Migrate a single file"""
    print(f"Migrating: {file_path}")
    
    with open(file_path, 'r', encoding='utf-8') as f:
        content = f.read()
    
    original_content = content
    
    # Apply transformations
    content = add_theme_import(content)
    content = remove_static_consts(content)
    content = replace_hardcoded_colors(content)
    
    # Only write if changed
    if content != original_content:
        with open(file_path, 'w', encoding='utf-8') as f:
            f.write(content)
        print(f"  ✓ Updated")
        return True
    else:
        print(f"  - No changes needed")
        return False

def main():
    """Main migration function"""
    lib_dir = Path('lib')
    dart_files = list(lib_dir.rglob('*.dart'))
    
    print(f"Found {len(dart_files)} Dart files")
    print("Starting migration...\n")
    
    updated_count = 0
    for dart_file in dart_files:
        if should_skip_file(dart_file):
            continue
        
        if migrate_file(dart_file):
            updated_count += 1
    
    print(f"\n✨ Migration complete!")
    print(f"Updated {updated_count} files")

if __name__ == '__main__':
    main()
