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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 0.75,
        ),
        itemCount: itemCount,
        itemBuilder: (context, index) {
          if (index == itemCount - 1) {
            return const AddCard();
          }
          return ClinicCard(
            title: 'Demonstração',
            subtitle: 'Paciente ativo da pasta',
            category: category,
          );
        },
      ),
    );
  }
}

