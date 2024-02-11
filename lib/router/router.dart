import 'package:admin_dashboard/router/admin_handlers.dart';
import 'package:admin_dashboard/router/dashboard_handlers.dart';
import 'package:admin_dashboard/router/no_page_found_handlers.dart';
import 'package:fluro/fluro.dart';

class Flurorouter{
  static final FluroRouter router = FluroRouter();

  static String rootRoute = '/';

  //Auth Router
  static String loginRoute = '/auth/login';
  static String registerRoute = '/auth/register';

  //Dashboard
  static String dashboardRoute = '/dashboard';
  static String publicationsRoute = '/dashboard/publications';
  static String blankRoute = '/dashboard/blank';
  static String categoriesRoute = '/dashboard/categories';
  static void configureRoutes(){
    //Auth Routes
    router.define(rootRoute, handler: AdminHandlers.login, transitionType: TransitionType.none);
    router.define(loginRoute, handler: AdminHandlers.login, transitionType: TransitionType.none);
    router.define(registerRoute, handler: AdminHandlers.register, transitionType: TransitionType.none);

    //Dashboard
    router.define(dashboardRoute, handler: DashboardHandlers.dashboard, transitionType:TransitionType.fadeIn);
    router.define(publicationsRoute, handler: DashboardHandlers.publications, transitionType:TransitionType.fadeIn);
    router.define(categoriesRoute, handler: DashboardHandlers.categories, transitionType:TransitionType.fadeIn);

    //01
    router.notFoundHandler = NoPageFoundHandlers.noPageFound;
  }
}