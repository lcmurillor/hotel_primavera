import 'package:fluro/fluro.dart';
import 'package:hotel_primavera_app/services/services.dart';
import '../layouts/layouts.dart';
import '../view/views.dart';

///Todo el enrutamiento y las direcciones de las diferentes vistas de la aplicación
///se manejan desde esta ventana principal.
class MainHandlers {
  static Handler login = Handler(handlerFunc: (context, parameters) {
    return const LoginLayoutPage(child: LoginView());
  });

  static Handler dashboard = Handler(handlerFunc: (context, parameters) {
    if (FirebaseAuthService.auth.currentUser != null) {
      return const MainLayoutPage(child: DashboardView());
    } else {
      return const LoginLayoutPage(child: LoginView());
    }
  });

  static Handler notFound = Handler(handlerFunc: (context, parameters) {
    return const PageNotFoundView();
  });
}
