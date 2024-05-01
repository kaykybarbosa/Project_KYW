enum AppStatus { authenticated, unauthenticated }

extension AppStatusX on AppStatus {
  bool get isAuthenticated => this == AppStatus.authenticated;
  bool get isUnauthenticated => this == AppStatus.unauthenticated;
}
