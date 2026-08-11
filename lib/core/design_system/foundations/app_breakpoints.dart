abstract final class AppBreakpoints {
  static const double compactMax = 599;
  static const double mediumMax = 839;

  static bool isCompact(double width) => width <= compactMax;
  static bool isMedium(double width) =>
      width > compactMax && width <= mediumMax;
  static bool isExpanded(double width) => width > mediumMax;
}
