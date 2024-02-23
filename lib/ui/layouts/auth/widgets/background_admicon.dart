import 'package:admin_dashboard/ui/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BackgroundAdmicon extends StatelessWidget {
  const BackgroundAdmicon({Key? key, required this.sizeImage})
      : super(key: key);
  final double sizeImage;
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
      decoration: buildBoxDecoration(),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 400),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: Center(
              child: ListView(
                shrinkWrap: true,
                children: [
                  Image(
                    image: const AssetImage('admicon.png'),
                    //width: 400,
                    height: sizeImage>300 ? 300 : sizeImage,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Co-Gobierno Estudiantil ISTL',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.montserratAlternates(
                      fontSize: 25,
                      color: AppColor.kWhite,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ));
  }

  BoxDecoration buildBoxDecoration() {
    return const BoxDecoration();
  }
}
