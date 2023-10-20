enum NavRoute {
  home('/'),
  booking('/booking'),
  user('/user'),
  login('/login'),
  pageNotFound('/not-found');

  const NavRoute(this.path);

  final String path;
}
