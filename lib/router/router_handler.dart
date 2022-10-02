import 'package:fluro/fluro.dart';

import '../layout/main_layout_page.dart';
import '../view/views.dart';

class MainHandlers {
  static Handler home = Handler(handlerFunc: (context, parameters) {
    return const MainLayoutPage(child: LoginView());
  });

  // static Handler experince = Handler(handlerFunc: (context, parameters) {
  //   return const MainLayoutPage(child: ExperienceView());
  // });

  // static Handler contactus = Handler(handlerFunc: (context, parameters) {
  //   return const MainLayoutPage(child: ContactUsView());
  // });

  // static Handler nofound = Handler(handlerFunc: (context, parameters) {
  //   return const MainLayoutPage(child: PageNotFoundView());
  // });
}
