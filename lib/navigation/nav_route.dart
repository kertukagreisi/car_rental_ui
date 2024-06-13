enum NavRoute {
  // no auth routes
  home('/'),
  carDetails('/car-details'),

  // user routes
  rent('/rent'),
  bookingsOverview('/bookings-overview'),
  profile('/profile'),

  // admin routes
  adminCars('/admin-cars'),
  adminUsers('/admin-users'),
  adminBookings('/admin-bookings'),

  // other
  login('/login'),
  pageNotFound('/not-found');

  const NavRoute(this.path);

  final String path;
}
