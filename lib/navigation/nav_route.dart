enum NavRoute {
  home('/'),
  book('/book'),
  bookingsOverview('/bookings-overview'),
  user('/user'),
  login('/login'),
  pageNotFound('/not-found');

  const NavRoute(this.path);

  final String path;
}
