import 'package:aurea_app/src/presentation/screens/help/widgets/help_page_scaffold.dart';
import 'package:aurea_app/src/presentation/screens/help/reference_lines/widgets/lines_and_references_page_1.dart';
import 'package:aurea_app/src/presentation/screens/help/reference_lines/widgets/lines_and_references_page_2.dart';
import 'package:aurea_app/src/presentation/screens/help/reference_lines/widgets/lines_and_references_page_3.dart';
import 'package:aurea_app/src/presentation/screens/help/reference_lines/widgets/lines_and_references_page_4.dart';
import 'package:aurea_app/src/presentation/screens/help/reference_lines/widgets/lines_and_references_page_5.dart';
import 'package:aurea_app/src/presentation/screens/help/reference_lines/widgets/lines_and_references_page_6.dart';
import 'package:aurea_app/src/presentation/screens/help/reference_lines/widgets/lines_and_references_page_7.dart';
import 'package:aurea_app/src/presentation/screens/help/reference_lines/widgets/lines_and_references_page_8.dart';
import 'package:aurea_app/src/presentation/screens/help/reference_lines/widgets/lines_and_references_page_9.dart';
import 'package:aurea_app/src/presentation/screens/help/reference_lines/widgets/lines_and_references_page_10.dart';
import 'package:flutter/material.dart';

class LinesAndReferencesPage extends StatefulWidget {
  const LinesAndReferencesPage({super.key});

  @override
  State<LinesAndReferencesPage> createState() => _LinesAndReferencesPageState();
}

class _LinesAndReferencesPageState extends State<LinesAndReferencesPage> {
 final PageController _pageController = PageController();
  int _currentPage = 0;
  final colorGradient = const Color.fromARGB(255, 221, 220, 220);
  static const int _totalPages = 10;

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
      title: 'Linhas e referências',
      child: PageView(
        controller: _pageController,
        children: [
          LinesAndReferencesPage1(
            currentPage: _currentPage,
            totalPages: _totalPages,
            onPrevious: _goToPreviousPage,
            onNext: _goToNextPage,
            colorGradient: colorGradient,
          ),
          LinesAndReferencesPage2(
            currentPage: _currentPage,
            totalPages: _totalPages,
            onPrevious: _goToPreviousPage,
            onNext: _goToNextPage,
            colorGradient: colorGradient,
          ),
          LinesAndReferencesPage3(
            currentPage: _currentPage,
            totalPages: _totalPages,
            onPrevious: _goToPreviousPage,
            onNext: _goToNextPage,
            colorGradient: colorGradient,
          ),
          LinesAndReferencesPage4(
            currentPage: _currentPage,
            totalPages: _totalPages,
            onPrevious: _goToPreviousPage,
            onNext: _goToNextPage,
            colorGradient: colorGradient,
          ),
          LinesAndReferencesPage5(
            currentPage: _currentPage,
            totalPages: _totalPages,
            onPrevious: _goToPreviousPage,
            onNext: _goToNextPage,
            colorGradient: colorGradient,
          ),
          LinesAndReferencesPage6(
            currentPage: _currentPage,
            totalPages: _totalPages,
            onPrevious: _goToPreviousPage,
            onNext: _goToNextPage,
            colorGradient: colorGradient,
          ),
          LinesAndReferencesPage7(
            currentPage: _currentPage,
            totalPages: _totalPages,
            onPrevious: _goToPreviousPage,
            onNext: _goToNextPage,
            colorGradient: colorGradient,
          ),
          LinesAndReferencesPage8(
            currentPage: _currentPage,
            totalPages: _totalPages,
            onPrevious: _goToPreviousPage,
            onNext: _goToNextPage,
            colorGradient: colorGradient,
          ),
          LinesAndReferencesPage9(
            currentPage: _currentPage,
            totalPages: _totalPages,
            onPrevious: _goToPreviousPage,
            onNext: _goToNextPage,
            colorGradient: colorGradient,
          ),
          LinesAndReferencesPage10(
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

