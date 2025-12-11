
import 'package:flutter/material.dart';

class SupportPage extends StatelessWidget {
  const SupportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SupportPageView();
  }
}

class SupportPageView extends StatefulWidget {
  const SupportPageView({super.key});

  @override
  State<SupportPageView> createState() => _SupportPageViewState();
}

class _SupportPageViewState extends State<SupportPageView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Suporte'),
      ),
    );
  }
}