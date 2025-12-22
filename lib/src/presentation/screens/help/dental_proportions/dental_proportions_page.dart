import 'package:aurea_app/src/presentation/screens/help/widgets/help_page_scaffold.dart';
import 'package:aurea_app/src/presentation/screens/help/dental_proportions/widgets/dental_proportions_page_1.dart';
import 'package:aurea_app/src/presentation/screens/help/dental_proportions/widgets/dental_proportions_page_2.dart';
import 'package:aurea_app/src/presentation/screens/help/dental_proportions/widgets/dental_proportions_page_3.dart';
import 'package:aurea_app/src/presentation/screens/help/dental_proportions/widgets/dental_proportions_page_4.dart';
import 'package:aurea_app/src/presentation/screens/help/dental_proportions/widgets/dental_proportions_page_5.dart';
import 'package:flutter/material.dart';

class DentalProportionsPage extends StatefulWidget {
  const DentalProportionsPage({super.key});

  @override
  State<DentalProportionsPage> createState() => _DentalProportionsPageState();
}

class _DentalProportionsPageState extends State<DentalProportionsPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  final colorGradient = const Color.fromARGB(255, 221, 220, 220);
  static const int _totalPages = 5;

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
      title: 'Proporções dentárias',
      child: PageView(
        controller: _pageController,
        children: [
          DentalProportionsPage1(
            currentPage: _currentPage,
            totalPages: _totalPages,
            onPrevious: _goToPreviousPage,
            onNext: _goToNextPage,
            colorGradient: colorGradient,
          ),
          DentalProportionsPage2(
            currentPage: _currentPage,
            totalPages: _totalPages,
            onPrevious: _goToPreviousPage,
            onNext: _goToNextPage,
            colorGradient: colorGradient,
          ),
          DentalProportionsPage3(
            currentPage: _currentPage,
            totalPages: _totalPages,
            onPrevious: _goToPreviousPage,
            onNext: _goToNextPage,
            colorGradient: colorGradient,
          ),
          DentalProportionsPage4(
            currentPage: _currentPage,
            totalPages: _totalPages,
            onPrevious: _goToPreviousPage,
            onNext: _goToNextPage,
            colorGradient: colorGradient,
          ),
          DentalProportionsPage5(
            currentPage: _currentPage,
            totalPages: _totalPages,
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

