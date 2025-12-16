import 'package:aurea_app/src/presentation/screens/help/widgets/help_page_scaffold.dart';
import 'package:aurea_app/src/presentation/screens/help/widgets/photographic_protocol_page_1.dart';
import 'package:aurea_app/src/presentation/screens/help/widgets/photographic_protocol_page_2.dart';
import 'package:aurea_app/src/presentation/screens/help/widgets/photographic_protocol_page_3.dart';
import 'package:aurea_app/src/presentation/screens/help/widgets/photographic_protocol_page_4.dart';
import 'package:aurea_app/src/presentation/screens/help/widgets/photographic_protocol_page_5.dart';
import 'package:aurea_app/src/presentation/screens/help/widgets/photographic_protocol_page_6.dart';
import 'package:aurea_app/src/presentation/screens/help/widgets/photographic_protocol_page_7.dart';
import 'package:aurea_app/src/presentation/screens/help/widgets/photographic_protocol_page_8.dart';
import 'package:aurea_app/src/presentation/screens/help/widgets/photographic_protocol_page_9.dart';
import 'package:aurea_app/src/presentation/screens/help/widgets/photographic_protocol_page_10.dart';
import 'package:flutter/material.dart';

class PhotographicProtocolPage extends StatefulWidget {
  const PhotographicProtocolPage({super.key});

  @override
  State<PhotographicProtocolPage> createState() =>
      _PhotographicProtocolPageState();
}

class _PhotographicProtocolPageState extends State<PhotographicProtocolPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  final colorGradient = const Color.fromARGB(255, 221, 220, 220);

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
    if (_currentPage < 9) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return HelpPageScaffold(
      child: PageView(
        controller: _pageController,
        children: [
          PhotographicProtocolPage1(
            currentPage: _currentPage,
            onPrevious: _goToPreviousPage,
            onNext: _goToNextPage,
            colorGradient: colorGradient,
          ),
          PhotographicProtocolPage2(
            currentPage: _currentPage,
            onPrevious: _goToPreviousPage,
            onNext: _goToNextPage,
            colorGradient: colorGradient,
          ),
          PhotographicProtocolPage3(
            currentPage: _currentPage,
            onPrevious: _goToPreviousPage,
            onNext: _goToNextPage,
            colorGradient: colorGradient,
          ),
          PhotographicProtocolPage4(
            currentPage: _currentPage,
            onPrevious: _goToPreviousPage,
            onNext: _goToNextPage,
            colorGradient: colorGradient,
          ),
          PhotographicProtocolPage5(
            currentPage: _currentPage,
            onPrevious: _goToPreviousPage,
            onNext: _goToNextPage,
            colorGradient: colorGradient,
          ),
          PhotographicProtocolPage6(
            currentPage: _currentPage,
            onPrevious: _goToPreviousPage,
            onNext: _goToNextPage,
            colorGradient: colorGradient,
          ),
          PhotographicProtocolPage7(
            currentPage: _currentPage,
            onPrevious: _goToPreviousPage,
            onNext: _goToNextPage,
            colorGradient: colorGradient,
          ),
          PhotographicProtocolPage8(
            currentPage: _currentPage,
            onPrevious: _goToPreviousPage,
            onNext: _goToNextPage,
            colorGradient: colorGradient,
          ),
          PhotographicProtocolPage9(
            currentPage: _currentPage,
            onPrevious: _goToPreviousPage,
            onNext: _goToNextPage,
            colorGradient: colorGradient,
          ),
          PhotographicProtocolPage10(
            currentPage: _currentPage,
            onPrevious: _goToPreviousPage,
            onNext: _goToNextPage,
            colorGradient: colorGradient,
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
