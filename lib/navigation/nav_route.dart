enum NavRoute {
  home('/'),
  cars('/cars'),
  login('/login'),
  pageNotFound('/not-found');

  const NavRoute(this.path);

  final String path;
}
