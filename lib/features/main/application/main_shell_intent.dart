sealed class MainShellIntent {
  const MainShellIntent();
}

final class MainTabSelected extends MainShellIntent {
  const MainTabSelected(this.index);

  final int index;
}
