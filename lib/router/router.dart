import 'package:admin_dashboard/router/admin_handlers.dart';
import 'package:admin_dashboard/router/dashboard_handlers.dart';
import 'package:admin_dashboard/router/no_page_found_handlers.dart';
import 'package:fluro/fluro.dart';

class Flurorouter {
  static final FluroRouter router = FluroRouter();

  static String rootRoute = '/';

  //Auth Router
  static String loginRoute = '/auth/login';
  static String registerRoute = '/auth/register';

  //Dashboard
  static String dashboardRoute = '/dashboard';
  static String postsRoute = '/dashboard/publications';
  static String blankRoute = '/dashboard/blank';
  static String categoriesRoute = '/dashboard/categories';
  static String montosRoute = '/dashboard/monto';
  static String gobiernoRoute = '/dashboard/gobierno';
  static String pagosRoute = '/dashboard/pagos';
  static String ingresosRoute = '/dashboard/ingresos';
  static String newPostRoute = '/dashboard/new-post';
  static String usersRoute = '/dashboard/users';
  static String userRoute = '/dashboard/users/:uid';

  static void configureRoutes() {
    //Auth Routes
    router.define(rootRoute,
        handler: AdminHandlers.login, transitionType: TransitionType.none);
    router.define(loginRoute,
        handler: AdminHandlers.login, transitionType: TransitionType.none);
    router.define(registerRoute,
        handler: AdminHandlers.register, transitionType: TransitionType.none);

    //Dashboard
    router.define(dashboardRoute,
        handler: DashboardHandlers.dashboard,
        transitionType: TransitionType.fadeIn);

    router.define(categoriesRoute,
        handler: DashboardHandlers.categories,
        transitionType: TransitionType.fadeIn);
    router.define(montosRoute,
        handler: DashboardHandlers.montos,
        transitionType: TransitionType.fadeIn);
    router.define(gobiernoRoute,
        handler: DashboardHandlers.gobierno,
        transitionType: TransitionType.fadeIn);
    
    router.define(ingresosRoute,
        handler: DashboardHandlers.ingresos,
        transitionType: TransitionType.fadeIn);

    //Publications
    router.define(postsRoute,
        handler: DashboardHandlers.publications,
        transitionType: TransitionType.fadeIn);
    router.define(newPostRoute,
        handler: DashboardHandlers.newPost,
        transitionType: TransitionType.fadeIn);

    //users
    router.define(usersRoute,
        handler: DashboardHandlers.users,
        transitionType: TransitionType.fadeIn);
    router.define(userRoute,
        handler: DashboardHandlers.user, transitionType: TransitionType.fadeIn);

    //01
    router.notFoundHandler = NoPageFoundHandlers.noPageFound;
  }
}
