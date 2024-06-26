import 'package:admin_dashboard/router/router.dart';
import 'package:admin_dashboard/ui/views/carreras_view.dart';
import 'package:admin_dashboard/ui/views/gobierno_view.dart';
import 'package:admin_dashboard/ui/views/gastos_view.dart';
import 'package:admin_dashboard/ui/views/cuotas_view.dart';
import 'package:admin_dashboard/ui/views/pagos_view.dart';
import 'package:admin_dashboard/ui/views/post_new_view.dart';
import 'package:admin_dashboard/ui/views/user_view.dart';
import 'package:admin_dashboard/ui/views/users_view.dart';
import 'package:fluro/fluro.dart';
import 'package:provider/provider.dart';

import 'package:admin_dashboard/providers/auth_provider.dart';
import 'package:admin_dashboard/providers/sidemenu_provider.dart';
import 'package:admin_dashboard/ui/views/dashboard_view.dart';
import 'package:admin_dashboard/ui/views/login_view.dart';
import 'package:admin_dashboard/ui/views/posts_view.dart';

class DashboardHandlers {
  static Handler dashboard = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!);
    Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPageUrl(Flurorouter.dashboardRoute);

    if (authProvider.authStatus == AuthStatus.authenticated) {
      return const DashboardView();
    } else {
      return const LoginView();
    }
  });

  static Handler categories = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!);
    Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPageUrl(Flurorouter.categoriesRoute);

    if (authProvider.authStatus == AuthStatus.authenticated) {
      return const CarrerasView();
    } else {
      return const LoginView();
    }
  });

  static Handler publications = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!);
    Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPageUrl(Flurorouter.postsRoute);

    if (authProvider.authStatus == AuthStatus.authenticated) {
      return const PublicationsView();
    } else {
      return const LoginView();
    }
  });

  //users
  static Handler users = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!);
    Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPageUrl(Flurorouter.usersRoute);

    if (authProvider.authStatus == AuthStatus.authenticated) {
      return const UsersView();
    } else {
      return const LoginView();
    }
  });

  //user
  static Handler user = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!);
    Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPageUrl(Flurorouter.userRoute);

    if (authProvider.authStatus == AuthStatus.authenticated) {
      print(params);
      if (params['uid']?.first != null) {
        return UserView(uid: params['uid']!.first);
      } else {
        return const UsersView();
      }
    } else {
      return const LoginView();
    }
  });

  static Handler newPost = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!);
    Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPageUrl(Flurorouter.postsRoute);

    if (authProvider.authStatus == AuthStatus.authenticated) {
      return const PostNewView();
    } else {
      return const LoginView();
    }
  });

  static Handler cuotas = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!);
    Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPageUrl(Flurorouter.cuotasRoute);

    if (authProvider.authStatus == AuthStatus.authenticated) {
      return const CuotasView();
    } else {
      return const LoginView();
    }
  });

  static Handler pagos = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!);
    Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPageUrl(Flurorouter.pagosRoute);

    if (authProvider.authStatus == AuthStatus.authenticated) {
      return const PagosView();
    } else {
      return const LoginView();
    }
  });

  static Handler gobierno = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!);
    Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPageUrl(Flurorouter.gobiernoRoute);

    if (authProvider.authStatus == AuthStatus.authenticated) {
      return const GobiernoView();
    } else {
      return const LoginView();
    }
  });

  static Handler gastos = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!);
    Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPageUrl(Flurorouter.gastosRoute);

    if (authProvider.authStatus == AuthStatus.authenticated) {
      return const GastosView();
    } else {
      return const LoginView();
    }
  });
}
