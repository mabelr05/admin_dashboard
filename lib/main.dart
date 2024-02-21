import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:admin_dashboard/api/CafeApi.dart';
import 'package:admin_dashboard/ui/layouts/dashboard/dashboard_layout.dart';
import 'package:admin_dashboard/ui/layouts/splash/splash_layout.dart';
import 'package:admin_dashboard/router/router.dart';
import 'package:admin_dashboard/providers/providers.dart';
import 'package:admin_dashboard/services/notifications_service.dart';
import 'package:admin_dashboard/services/local_storage.dart';
import 'package:admin_dashboard/services/navigation_service.dart';
import 'package:admin_dashboard/ui/layouts/auth/auth_layout.dart';

void main() async {
  await LocalStorage.configurePrefs();
  CafeApi.configureDio();

  Flurorouter.configureRoutes();
  runApp(const AppState());
}

class AppState extends StatelessWidget {
  const AppState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(lazy: false, create: (_) => AuthProvider()),
        ChangeNotifierProvider(lazy: false, create: (_) => SideMenuProvider()),
        ChangeNotifierProvider(create: (_) => CategoriesProvider()),
        ChangeNotifierProvider(create: (_) => UsersProvider()),
        ChangeNotifierProvider(create: (_) => UserFormProvider()),
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Panel | Admicon',
      initialRoute: '/',
      onGenerateRoute: Flurorouter.router.generator,
      navigatorKey: NavigationService.navigatorKey,
      scaffoldMessengerKey: NotificationsService.messengerKey,
      builder: (context, child) {
        final authProvider = Provider.of<AuthProvider>(context);

        if (authProvider.authStatus == AuthStatus.checking) {
          return const SplashLayout();
        }

        if (authProvider.authStatus == AuthStatus.authenticated) {
          return DashboardLayout(
            child: Builder(
              builder: (context) => child!,
            ),
          );
        } else {
          return AuthLayout(
            child: Builder(
              builder: (context) => child!,
            ),
          );
        }
        // print('Token:');
        //print (LocalStorage.prefs.getString('token'));
      },
      theme: ThemeData.light().copyWith(
        scrollbarTheme: const ScrollbarThemeData().copyWith(
          thumbColor: MaterialStateProperty.all(
            const Color.fromARGB(255, 215, 213, 213),
          ),
        ),
      ),
    );
  }
}
