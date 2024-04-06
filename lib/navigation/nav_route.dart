enum NavRoute {
  home('/'),
  carDetails('/car-details'),
  rent('/rent'),
  bookingsOverview('/bookings-overview'),
  user('/user'),
  login('/login'),
  pageNotFound('/not-found');

  const NavRoute(this.path);

  final String path;
}
