import 'dart:ui';

import 'package:aurea_app/src/presentation/screens/help/widgets/help_page_scaffold.dart';
import 'package:aurea_app/src/presentation/screens/help/photographic_phone/widgets/photographing_with_cellphone_page_1.dart';
import 'package:aurea_app/src/presentation/screens/help/photographic_phone/widgets/photographing_with_cellphone_page_2.dart';
import 'package:aurea_app/src/presentation/screens/help/photographic_phone/widgets/photographing_with_cellphone_page_3.dart';
import 'package:flutter/material.dart';

class PhotographingWithCellphonePage extends StatefulWidget {
  const PhotographingWithCellphonePage({super.key});

  @override
  State<PhotographingWithCellphonePage> createState() =>
      _PhotographingWithCellphonePageState();
}

class _PhotographingWithCellphonePageState
    extends State<PhotographingWithCellphonePage> {
  @override
  Widget build(BuildContext context) {
    return HelpPageScaffold(
      title: 'Configurações de câmera semiprofissional',
      child: SizedBox.expand(
        child: Stack(
          children: [
            Positioned(
              right: -260,
              top: -70,
              bottom: 0,
              child: Transform.scale(
                scale: 1.2,
                child: Image.asset(
                  'assets/images/phone.jpg',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              height: 600,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
                  child: Container(color: Colors.transparent),
                ),
              ),
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
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(30.0, 30.0, 20.0, 30.0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const PhotographingWithCellphonePage1(),
                        const PhotographingWithCellphonePage2(),
                        const PhotographingWithCellphonePage3(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
