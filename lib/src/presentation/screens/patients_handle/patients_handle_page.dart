import 'package:aurea_app/src/data/models/patient/patient_model.dart';
import 'package:aurea_app/src/logic/cubit/patient_photo/patient_photo_cubit.dart';
import 'package:aurea_app/src/presentation/screens/patients_handle/widgets/empty_patient_photos_view.dart';
import 'package:aurea_app/src/presentation/screens/patients_handle/widgets/error_patient_photos_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PatientsHandlePage extends StatelessWidget {
  final int clinicId;
  final String clinicName;
  final PatientModel patient;
  const PatientsHandlePage({
    super.key,
    required this.clinicId,
    required this.clinicName,
    required this.patient,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PatientPhotoCubit()..loadPhotos(patient.patientId),
      child: PatientsHandleView(patientId: patient.patientId),
    );
  }
}

class PatientsHandleView extends StatefulWidget {
  final int patientId;

  const PatientsHandleView({super.key, required this.patientId});

  @override
  State<PatientsHandleView> createState() => _PatientsHandleViewState();
}

class _PatientsHandleViewState extends State<PatientsHandleView> {
  @override
  Widget build(BuildContext context) {
    final sizeHeight = MediaQuery.sizeOf(context).height;
    final appBarHeight = MediaQuery.of(context).padding.top;
    return Scaffold(
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(50),
                bottomRight: Radius.circular(50),
              ),
            ),
            height: sizeHeight * 0.7,
            child: Stack(
              children: [
                BlocBuilder<PatientPhotoCubit, PatientPhotoState>(
                  builder: (context, state) {
                    if (state is Loading) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (state is Loaded) {
                      if (state.urls.isEmpty) {
                        return const EmptyPatientPhotosView();
                      }
                      return Image.network(state.urls[0]);
                    }
                    if (state is Error) {
                      return ErrorPatientPhotosView(
                        onRetry: () {
                          context.read<PatientPhotoCubit>().loadPhotos(
                            widget.patientId,
                          );
                        },
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
                Padding(
                  padding: EdgeInsets.only(top: appBarHeight, left: 10),
                  child: BackButton(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}




