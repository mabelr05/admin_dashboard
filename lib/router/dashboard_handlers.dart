import 'package:admin_dashboard/router/router.dart';
import 'package:admin_dashboard/ui/views/categories_view.dart';
import 'package:fluro/fluro.dart';
import 'package:provider/provider.dart';

import 'package:admin_dashboard/providers/auth_provider.dart';
import 'package:admin_dashboard/providers/sidemenu_provider.dart';
import 'package:admin_dashboard/ui/views/dashboard_view.dart';
import 'package:admin_dashboard/ui/views/login_view.dart';
import 'package:admin_dashboard/ui/views/publications_view.dart';


class DashboardHandlers{
   
   static Handler dashboard = Handler(
    handlerFunc:(context, params) {

      final authProvider = Provider.of<AuthProvider>(context!);
      Provider.of<SideMenuProvider>(context, listen: false)
      .setCurrentPageUrl(Flurorouter.dashboardRoute);

      if(authProvider.authStatus == AuthStatus.authenticated)
         return DashboardView();
      else
      return LoginView();
    }
  );


    static Handler publications = Handler(
    handlerFunc:(context, params) {

      final authProvider = Provider.of<AuthProvider>(context!);
      Provider.of<SideMenuProvider>(context, listen: false)
      .setCurrentPageUrl(Flurorouter.publicationsRoute);

      if(authProvider.authStatus == AuthStatus.authenticated)
        return PublicationsView();
      else
        return LoginView();
    }
  );

   static Handler categories = Handler(
    handlerFunc:(context, params) {

      final authProvider = Provider.of<AuthProvider>(context!);
      Provider.of<SideMenuProvider>(context, listen: false)
      .setCurrentPageUrl(Flurorouter.categoriesRoute);

      if(authProvider.authStatus == AuthStatus.authenticated)
        return CategoriesView();
      else
        return LoginView();
    }
  );

}