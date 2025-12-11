import 'package:aurea_app/src/logic/cubit/clinic/clinic_cubit.dart';
import 'package:aurea_app/src/presentation/widgets/clinic/clinic_cards_grid.dart';
import 'package:aurea_app/src/presentation/widgets/clinic/clinic_tab_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ClinicCubit()..loadClinics(),
      child: const HomePageView(),
    );
  }
}

class HomePageView extends StatefulWidget {
  const HomePageView({super.key});

  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  int _selectedTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ClinicCubit, ClinicState>(
      builder: (context, clinicState) {
        final List<String> tabs = [];
        
        if (clinicState.toString().startsWith('ClinicState.loaded')) {
          try {
            final loadedState = clinicState as dynamic;
            if (loadedState.clinics != null) {
              final clinics = loadedState.clinics as List;
              tabs.addAll(clinics.map((c) => c.name.toString()));
            }
          } catch (_) {}
        }

        return Column(
          children: [
            ClinicTabBar(
              tabs: tabs,
              selectedIndex: _selectedTabIndex,
              onTabSelected: (index) {
                setState(() {
                  _selectedTabIndex = index;
                });
              },
            ),
            Expanded(
              child: HomePageContent(
                selectedTabIndex: _selectedTabIndex,
                tabs: tabs,
              ),
            ),
          ],
        );
      },
    );
  }
}

class HomePageContent extends StatelessWidget {
  final int selectedTabIndex;
  final List<String> tabs;

  const HomePageContent({
    super.key,
    required this.selectedTabIndex,
    required this.tabs,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ClinicCubit, ClinicState>(
      builder: (context, state) {
        final stateString = state.toString();
        
        if (stateString.startsWith('ClinicState.initial') || 
            stateString.startsWith('ClinicState.loading')) {
          return const Center(child: CircularProgressIndicator());
        }
        
        if (stateString.startsWith('ClinicState.error')) {
          try {
            final errorState = state as dynamic;
            return Center(child: Text('Erro: ${errorState.message ?? "Erro desconhecido"}'));
          } catch (_) {
            return const Center(child: Text('Erro ao carregar dados'));
          }
        }

        if (tabs.isEmpty) {
          return const Center(child: Text('Nenhuma clínica encontrada'));
        }

        final selectedClinicName = selectedTabIndex < tabs.length 
            ? tabs[selectedTabIndex] 
            : '';

        return ClinicCardsGrid(
          itemCount: 3,
          category: selectedClinicName,
        );
      },
    );
  }
}
