import 'package:fluro/fluro.dart';

import '../layout/main_layout_page.dart';
import '../view/views.dart';

///Todo el enrutamiento y las direcciones de las diferentes vistas de la aplicación
///se manejan desde esta ventana principal.
class MainHandlers {
  static Handler login = Handler(handlerFunc: (context, parameters) {
    return const MainLayoutPage(child: LoginView());
  });

  static Handler dashboard = Handler(handlerFunc: (context, parameters) {
    return const MainLayoutPage(child: DashboardView());
  });

  static Handler notFound = Handler(handlerFunc: (context, parameters) {
    return const MainLayoutPage(child: PageNotFoundView());
  });
}
