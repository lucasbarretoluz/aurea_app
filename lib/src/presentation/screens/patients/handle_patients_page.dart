import 'package:flutter/material.dart';

class HandlePatientsPage extends StatelessWidget {
  const HandlePatientsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const HandlePatientsView();
  }
}

class HandlePatientsView extends StatefulWidget {
  const HandlePatientsView({super.key});

  @override
  State<HandlePatientsView> createState() => _HandlePatientsViewState();
}

class _HandlePatientsViewState extends State<HandlePatientsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Gerenciar Pacientes')),
      body: Center(child: Text('Gerenciar Pacientes')),
    );
  }
}
