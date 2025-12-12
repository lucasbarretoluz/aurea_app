import 'package:aurea_app/src/presentation/widgets/clinic/add_card.dart';
import 'package:aurea_app/src/presentation/widgets/clinic/clinic_card.dart';
import 'package:flutter/material.dart';

class ClinicCardsGrid extends StatelessWidget {
  final int itemCount;
  final String category;

  const ClinicCardsGrid({
    super.key,
    required this.itemCount,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: itemCount,
        itemBuilder: (context, index) {
          if (index == itemCount - 1) {
            return Padding(
              padding: const EdgeInsets.only(right: 16),
              child: AddCard(
                width: 200,
                height: 300,
              ),
            );
          }
          return Padding(
            padding: const EdgeInsets.only(right: 16),
            child: SizedBox(
              width: 200,
              child: ClinicCard(
                title: 'Demonstração',
                subtitle: 'Paciente ativo da pasta',
                category: category,
              ),
            ),
          );
        },
      ),
    );
  }
}

