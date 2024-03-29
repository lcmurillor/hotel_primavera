import 'package:fluro/fluro.dart';

import 'router_handler.dart';

class Flurorouter {
  static final FluroRouter router = FluroRouter();

  static String rootRoute = '/';
  static String dashboardRoute = '/dashboard';
  static String changePassword = '/changePassword';

  static void configureRoutes() {
    router.define(rootRoute,
        handler: MainHandlers.login, transitionType: TransitionType.none);
    router.define(dashboardRoute,
        handler: MainHandlers.dashboard, transitionType: TransitionType.none);
    router.define(changePassword,
        handler: MainHandlers.changePassword,
        transitionType: TransitionType.none);

    router.notFoundHandler = MainHandlers.notFound;
  }
}
