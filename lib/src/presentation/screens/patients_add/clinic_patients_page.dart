import 'package:aurea_app/src/logic/cubit/patient/patient_cubit.dart';
import 'package:aurea_app/src/logic/cubit/patient/patient_state.dart';
import 'package:aurea_app/src/presentation/widgets/clinic/clinic_patient_large_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ClinicPatientsPage extends StatelessWidget {
  final String clinicName;
  final int clinicId;

  const ClinicPatientsPage({
    super.key,
    required this.clinicName,
    required this.clinicId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) =>
              PatientCubit()
                ..loadPatients(page: 1, limit: 5, clinicId: clinicId),
      child: ClinicPatientsView(clinicName: clinicName, clinicId: clinicId),
    );
  }
}

class ClinicPatientsView extends StatefulWidget {
  final String clinicName;
  final int clinicId;
  const ClinicPatientsView({
    super.key,
    required this.clinicName,
    required this.clinicId,
  });

  @override
  State<ClinicPatientsView> createState() => _ClinicPatientsViewState();
}

class _ClinicPatientsViewState extends State<ClinicPatientsView> {
  String _searchQuery = '';
  final ScrollController _scrollController = ScrollController();

  bool _isLoadingMore = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (currentScroll >= maxScroll * 0.8) {
      _handleLoadMore();
    }
  }

  Future<void> _handleLoadMore() async {
    if (_isLoadingMore) return;
    final cubit = context.read<PatientCubit>();
    final state = cubit.state;
    if (state is! Loaded || !state.hasMore) return;
    _isLoadingMore = true;
    await cubit.loadMore();
    _isLoadingMore = false;
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            Text(
              'Pacientes da clínica',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 4),
            Text(widget.clinicName, style: TextStyle(fontSize: 13)),
          ],
        ),
        centerTitle: true,
        backgroundColor: colorScheme.surface,
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
      ),

      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: SharedBar(
              onSearch: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
            ),
          ),
          Expanded(
            child: BlocBuilder<PatientCubit, PatientState>(
              builder: (context, state) {
                if (state is Loading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is Loaded) {
                  final loadedState = state;
                  final patients = _searchQuery.trim().isEmpty
                      ? loadedState.patients
                      : loadedState.patients
                          .where(
                            (p) => p.name
                                .toLowerCase()
                                .contains(_searchQuery.toLowerCase()),
                          )
                          .toList();

                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Expanded(
                          child: GridView.builder(
                            controller: _scrollController,
                            itemCount: patients.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 10,
                              crossAxisSpacing: 10,
                              childAspectRatio: 0.65,
                            ),
                            itemBuilder: (context, index) {
                              final patient = patients[index];
                              return ClinicPatientLargeCard(
                                key: ValueKey('clinic_patient_${patient.patientId}'),
                                patient: patient,
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                } else if (state is Error) {
                  return Center(child: Text(state.message));
                }
                return const Center(
                  child: Text('Erro ao carregar pacientes...'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class SharedBar extends StatefulWidget {
  final ValueChanged<String> onSearch;

  const SharedBar({super.key, required this.onSearch});

  @override
  State<SharedBar> createState() => _SharedBarState();
}

class _SharedBarState extends State<SharedBar> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _controller,
            decoration: InputDecoration(
              hintText: 'Buscar paciente',
              prefixIcon: const Icon(Icons.search),
              filled: true,
              fillColor: colorScheme.surface,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 0,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: colorScheme.outline.withValues(alpha: 0.5),
                  width: 0.8,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: colorScheme.outline.withValues(alpha: 0.3),
                  width: 0.8,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: colorScheme.primary, width: 1),
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),
        SizedBox(
          height: 48,
          child: ElevatedButton.icon(
            onPressed: () {
              widget.onSearch(_controller.text.trim());
            },
            label: const Text('Buscar'),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              backgroundColor: colorScheme.primary,
              foregroundColor: colorScheme.onPrimary,
              elevation: 0,
            ),
          ),
        ),
      ],
    );
  }
}

