// ignore_for_file: avoid_print

import 'package:admin_dashboard/ui/app_colors.dart';
import 'package:admin_dashboard/ui/layouts/auth/widgets/background_admicon.dart';
import 'package:admin_dashboard/ui/layouts/auth/widgets/custom_title.dart';
import 'package:flutter/material.dart';
import 'package:admin_dashboard/ui/layouts/auth/widgets/links_bar.dart';

class AuthLayout extends StatelessWidget {
  final Widget child;
  const AuthLayout({Key? key, required this.child}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
        body: Scrollbar(
      // isAlwaysShown: true,
      child: ListView(
        physics: const ClampingScrollPhysics(), //Evita que se muevaa la pagina
        children: [
          (size.width > 500)
              ? _DesktopBody(child: child)
              //Mobile
              : _MobileBody(child: child),
          //LinksBar
          const LinksBar()
        ],
      ),
    ));
  }
}

class _MobileBody extends StatelessWidget {
  final Widget child;
  const _MobileBody({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final topSize = size.height * 0.30;
    final bottomSize = size.height - topSize;
    print("this is mobileBody");
    return Container(
      color: AppColor.kPrimary,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            color: AppColor.kPrimary,
            width: double.infinity,
            height: topSize,
            child: BackgroundAdmicon(sizeImage: topSize * 0.5),
          ),
          Container(
            width: double.infinity,
            height: bottomSize,
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(topLeft: Radius.circular(50)),
                color: AppColor.kWhite),
            child: ListView(
              children: [
                const SizedBox(height: 20),
                const CustomTitle(),
                SizedBox(
                  width: double.infinity,
                  height: 420,
                  child: child,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DesktopBody extends StatelessWidget {
  final Widget child;

  const _DesktopBody({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("this is DesktopBody");

    final size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      height: size.height * 0.95,
      color: AppColor.kPrimary,
      child: Row(
        children: [
          // Background
          // Flexible
          //Admicon Background
          Expanded(
            child: BackgroundAdmicon(sizeImage: (size.width * 0.60) * 0.5),
          ),

          //View Container
          //Estatico
          Container(
            width: size.width * 0.40 < 500 ? 400 : size.width * 0.40,
            height: double.infinity,
            color: Colors.white,
            child: Column(
              children: [
                const SizedBox(height: 20),
                const CustomTitle(),
                const SizedBox(height: 50),
                Expanded(child: child),
              ],
            ),
          )
        ],
      ),
    );
  }
}
