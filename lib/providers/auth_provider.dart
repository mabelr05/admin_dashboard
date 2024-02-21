import 'package:admin_dashboard/api/CafeApi.dart';
import 'package:admin_dashboard/models/http/auth_response.dart';
import 'package:admin_dashboard/models/usuario.dart';
import 'package:admin_dashboard/router/router.dart';
import 'package:admin_dashboard/services/local_storage.dart';
import 'package:admin_dashboard/services/navigation_service.dart';
import 'package:admin_dashboard/services/notifications_service.dart';
import 'package:flutter/material.dart';

enum AuthStatus { checking, authenticated, notAuthenticated }

class AuthProvider extends ChangeNotifier {
  String? _token;
  AuthStatus authStatus = AuthStatus.checking;
  Usuario? user;

  AuthProvider() {
    isAuthenticated();
  }

  login(String email, String password) {
    final data = {'correo': email, 'password': password};

    CafeApi.post('/auth/login', data).then((json) {
      print(json);
      final authResponse = AuthResponse.fromMap(json);
      user = authResponse.usuario;

      authStatus = AuthStatus.authenticated;
      LocalStorage.prefs.setString('token', authResponse.token);
      NavigationService.replaceTo(Flurorouter.dashboardRoute);

      CafeApi.configureDio();

      notifyListeners();
    }).catchError((e) {
      print('error en: $e');
      NotificationsService.showSnackbarError('Usuario / Password no validos');
    });
  }

  register(String email, String password, String name) {
    final data = {'nombre': name, 'correo': email, 'password': password};

    CafeApi.post("/usuarios", data).then((json) {
      //print('UserData: ' + json);
      final authResponse = AuthResponse.fromMap(json);
      user = authResponse.usuario;

      authStatus = AuthStatus.authenticated;
      LocalStorage.prefs.setString('token', authResponse.token);
      NavigationService.replaceTo(Flurorouter.dashboardRoute);

      CafeApi.configureDio();

      notifyListeners();
    }).catchError((e) {
      print('error en: $e');
      //Mostrar notificacion de error
      NotificationsService.showSnackbarError(
          'Error al crear usuario intentalo nuevamente 😊');
    });
  }

  Future<bool> isAuthenticated() async {
    final token = LocalStorage.prefs.getString('token');

    if (token == null) {
      authStatus = AuthStatus.notAuthenticated;
      notifyListeners();
      return false;
    }

    //ir al backend y comprobar si el JWT es valido

    try {
      final resp = await CafeApi.httpGet('/auth');
      final authResponse = AuthResponse.fromMap(resp);
      LocalStorage.prefs.setString('token', authResponse.token);

      user = authResponse.usuario;
      authStatus = AuthStatus.authenticated;
      notifyListeners();
      return true;
    } catch (e) {
      print(e);
      authStatus = AuthStatus.notAuthenticated;
      notifyListeners();
      return false;
    }
  }

  logout() {
    LocalStorage.prefs.remove('token');
    authStatus = AuthStatus.notAuthenticated;
    notifyListeners();
  }
}
