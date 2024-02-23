import 'package:admin_dashboard/providers/auth_provider.dart';
import 'package:admin_dashboard/providers/sidemenu_provider.dart';
import 'package:admin_dashboard/router/router.dart';
import 'package:admin_dashboard/services/navigation_service.dart';
import 'package:admin_dashboard/ui/app_colors.dart';
import 'package:admin_dashboard/ui/shared/widgets/logo.dart';
import 'package:admin_dashboard/ui/shared/widgets/menu_item.dart';
import 'package:admin_dashboard/ui/shared/widgets/text_separator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({Key? key}) : super(key: key);

  
  
  void navigateTo( String routeName){
    NavigationService.replaceTo( routeName);
    SideMenuProvider.closeMenu();
  }
  
  @override
  Widget build(BuildContext context) {

    final sideMenuProvider = Provider.of<SideMenuProvider>(context);

    return Container(
      width: 200,
      height: double.infinity,
      decoration: buildBoxDecoration(),
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: [

          const Logo(),

          const SizedBox(height: 50),

          //texto debajo del admin
          const TextSeparator( text: 'main'),

          MenuItem(
            text: 'Usuarios',
            icon: Icons.people_alt_outlined ,
            onPressed: () => navigateTo(Flurorouter.usersRoute),
            isActive: sideMenuProvider.currentPage == Flurorouter.usersRoute,
          ),

          MenuItem(
            text: 'Publicaciones',
            icon: Icons.photo_filter_outlined,
            onPressed: () => navigateTo(Flurorouter.publicationsRoute),
            isActive: sideMenuProvider.currentPage == Flurorouter.publicationsRoute,
            
          ),

          MenuItem(text: 'Cuotas',
          icon: Icons.monetization_on_outlined ,
          onPressed: () => navigateTo(Flurorouter.montosRoute),
          isActive: sideMenuProvider.currentPage == Flurorouter.montosRoute
          ),

           MenuItem(text: 'Pagos',
            icon: Icons.attach_money_outlined,
            onPressed: () => navigateTo(Flurorouter.pagosRoute),
            isActive: sideMenuProvider.currentPage == Flurorouter.pagosRoute,
            ),

            MenuItem(text: 'Ingresos',
            icon: Icons.attach_money_outlined,
            onPressed: () => navigateTo(Flurorouter.ingresosRoute),
            isActive: sideMenuProvider.currentPage == Flurorouter.ingresosRoute,
            ),

          MenuItem(
            text: 'Carreras',
            icon: Icons.category_outlined ,
            onPressed: () => navigateTo(Flurorouter.categoriesRoute),
            isActive: sideMenuProvider.currentPage == Flurorouter.categoriesRoute,
            ),

            const SizedBox(height: 30),

            const TextSeparator( text: 'others'),
            MenuItem(text: 'Co-Gobierno',
            icon: Icons.history_edu_outlined ,
            onPressed: () => navigateTo(Flurorouter.gobiernoRoute),
            isActive: sideMenuProvider.currentPage == Flurorouter.gobiernoRoute,
            ),
            
            MenuItem(
            text: 'Dashboard',
            icon: Icons.compass_calibration_outlined,
            onPressed: () => navigateTo(Flurorouter.dashboardRoute),
             //Para que se mantenga seleccionada la pagina
            isActive: sideMenuProvider.currentPage == Flurorouter.dashboardRoute,
            ),

            MenuItem(
              text: 'Cerrar Sesion',
              icon: Icons.exit_to_app_outlined ,
              onPressed: (){
                Provider.of<AuthProvider>(context, listen: false)
                .logout();

              },),

        ],
      ),
    );
  }

  //Decoracion del menu
  BoxDecoration buildBoxDecoration() =>  BoxDecoration(
  gradient: LinearGradient(
    colors: [
      AppColor.kPrimary,
      const Color.fromARGB(255, 5, 35, 35),

      
      ]
    ),
    boxShadow: const [
        BoxShadow(
        color: Color.fromARGB(255, 181, 215, 244),
        blurRadius: 10
      )
    ]
  );
}