enum NavRoute {
  home('/'),
  booking('/booking'),
  login('/login'),
  pageNotFound('/not-found');

  const NavRoute(this.path);

  final String path;
}
