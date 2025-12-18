import 'package:aurea_app/src/presentation/screens/help/widgets/help_page_scaffold.dart';
import 'package:aurea_app/src/presentation/screens/help/config_camera/widgets/semi_professional_camera_settings_page_1.dart';
import 'package:aurea_app/src/presentation/screens/help/config_camera/widgets/semi_professional_camera_settings_page_2.dart';
import 'package:aurea_app/src/presentation/screens/help/config_camera/widgets/semi_professional_camera_settings_page_3.dart';
import 'package:aurea_app/src/presentation/screens/help/config_camera/widgets/semi_professional_camera_settings_page_4.dart';
import 'package:aurea_app/src/presentation/screens/help/config_camera/widgets/semi_professional_camera_settings_page_5.dart';
import 'package:aurea_app/src/presentation/screens/help/config_camera/widgets/semi_professional_camera_settings_page_6.dart';
import 'package:aurea_app/src/presentation/widgets/buttons/navigation_buttons.dart';
import 'package:flutter/material.dart';
import 'dart:ui';

class SemiProfessionalCameraSettingsPage extends StatefulWidget {
  const SemiProfessionalCameraSettingsPage({super.key});

  @override
  State<SemiProfessionalCameraSettingsPage> createState() =>
      _SemiProfessionalCameraSettingsPageState();
}

class _SemiProfessionalCameraSettingsPageState
    extends State<SemiProfessionalCameraSettingsPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  static const int _totalPages = 6;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      final page = _pageController.page?.round() ?? 0;
      if (page != _currentPage) {
        setState(() {
          _currentPage = page;
        });
      }
    });
  }

  void _goToPreviousPage() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _goToNextPage() {
    if (_currentPage < _totalPages - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return HelpPageScaffold(
      title: 'Configurações de câmera semiprofissional',
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
              child: Column(
                children: [
                  Expanded(
                    child: PageView(
                      controller: _pageController,
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
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 0.0,
                      vertical: 40.0,
                    ),
                    child: NavigationButtons(
                      currentPage: _currentPage,
                      totalPages: _totalPages,
                      onPrevious: _goToPreviousPage,
                      onNext: _goToNextPage,
                      colorText: Colors.white,
                      colorIcon: Colors.white,
                      colorBackground: Color(0xffaea79d).withOpacity(0.26),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
