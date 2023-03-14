import 'package:hotel_primavera_app/providers/providers.dart';
import 'package:hotel_primavera_app/services/services.dart';

import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'routers/router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Flurorouter.configureRoutes();
  runApp(const AppState());
}

class AppState extends StatelessWidget {
  const AppState({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => ClientProvider()),
      ChangeNotifierProvider(create: (_) => NewClientFormProvider()),
      ChangeNotifierProvider(create: (_) => ClientImageProvider())
    ], child: const HotelPrimavera());
  }
}

class HotelPrimavera extends StatelessWidget {
  const HotelPrimavera({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Hotel Primavera',
      initialRoute: '/',
      onGenerateRoute: Flurorouter.router.generator,
      navigatorKey: NavigationService.navigatorKey,
      scaffoldMessengerKey: NotificationsService.messengerKey,
    );
  }
}
