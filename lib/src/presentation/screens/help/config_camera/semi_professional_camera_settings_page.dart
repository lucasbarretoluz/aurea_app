import 'package:aurea_app/src/presentation/screens/help/widgets/help_page_scaffold.dart';
import 'package:aurea_app/src/presentation/screens/help/config_camera/widgets/semi_professional_camera_settings_page_1.dart';
import 'package:aurea_app/src/presentation/screens/help/config_camera/widgets/semi_professional_camera_settings_page_2.dart';
import 'package:aurea_app/src/presentation/screens/help/config_camera/widgets/semi_professional_camera_settings_page_3.dart';
import 'package:aurea_app/src/presentation/screens/help/config_camera/widgets/semi_professional_camera_settings_page_4.dart';
import 'package:aurea_app/src/presentation/screens/help/config_camera/widgets/semi_professional_camera_settings_page_5.dart';
import 'package:aurea_app/src/presentation/screens/help/config_camera/widgets/semi_professional_camera_settings_page_6.dart';
import 'package:flutter/material.dart';
import 'dart:ui';

class SemiProfessionalCameraSettingsPage extends StatelessWidget {
  const SemiProfessionalCameraSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return HelpPageScaffold(
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.asset('assets/images/lens.jpg', fit: BoxFit.cover),
          ),
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
              child: Container(color: Colors.transparent),
            ),
          ),
          Positioned.fill(
            child: Container(color: Colors.black.withOpacity(0.35)),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 600,
              decoration: BoxDecoration(
                color: Color(0xffaea79d).withOpacity(0.26),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: PageView(
                children: [
                  const SemiProfessionalCameraSettingsPage1(),
                  const SemiProfessionalCameraSettingsPage2(),
                  const SemiProfessionalCameraSettingsPage3(),
                  const SemiProfessionalCameraSettingsPage4(),
                  const SemiProfessionalCameraSettingsPage5(),
                  const SemiProfessionalCameraSettingsPage6(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
