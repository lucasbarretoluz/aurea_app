import 'package:flutter/material.dart';

class SingUpPage extends StatelessWidget {
  const SingUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingUpPageView();
  }
}

class SingUpPageView extends StatelessWidget {
  const SingUpPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Sing Up Page'),
      ),
      body: Column(
        children: [
          Text('Sing Up Page'),
        ],
      ),
    );
  }
}