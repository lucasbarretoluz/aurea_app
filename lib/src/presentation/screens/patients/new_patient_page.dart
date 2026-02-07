import 'dart:io';
import 'package:aurea_app/src/logic/cubit/patient_photo/patient_photo_cubit.dart';
import 'package:aurea_app/src/presentation/screens/patients/helpers/patient_photo_upload_helper.dart';
import 'package:aurea_app/src/presentation/screens/patients/widgets/empty_photos_view.dart';
import 'package:aurea_app/src/presentation/screens/patients/widgets/patient_info_header.dart';
import 'package:aurea_app/src/presentation/screens/patients/widgets/pending_images_grid.dart';
import 'package:aurea_app/src/presentation/widgets/buttons/loading_button.dart';
import 'package:aurea_app/src/presentation/widgets/toast/custom_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:toastification/toastification.dart';

class NewPatientPage extends StatelessWidget {
  final int clinicId;
  final String clinicName;
  const NewPatientPage({
    super.key,
    required this.clinicId,
    required this.clinicName,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PatientPhotoCubit(),
      child: NewPatientView(clinicId: clinicId, clinicName: clinicName),
    );
  }
}

class NewPatientView extends StatefulWidget {
  final int clinicId;
  final String clinicName;
  const NewPatientView({
    super.key,
    required this.clinicId,
    required this.clinicName,
  });

  @override
  State<NewPatientView> createState() => _NewPatientViewState();
}

class _NewPatientViewState extends State<NewPatientView> {
  final List<File> _pendingImages = [];
  int? _coverImageIndex;
  String _patientName = '';

  Future<void> _pickImage() async {
    if (_pendingImages.length >= 10) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Máximo de 10 fotos permitidas'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    final imageFile = await PatientPhotoUploadHelper.pickImage(context);
    if (imageFile != null) {
      setState(() {
        _pendingImages.add(imageFile);
        if (_coverImageIndex == null && _pendingImages.length == 1) {
          _coverImageIndex = 0;
        }
      });
    }
  }

  Future<void> _cropImage(int index) async {
    if (index < 0 || index >= _pendingImages.length) {
      return;
    }

    final croppedFile = await PatientPhotoUploadHelper.cropImage(
      context,
      _pendingImages[index],
    );
    
    if (croppedFile != null) {
      setState(() {
        _pendingImages[index] = croppedFile;
      });
    }
  }

  Future<void> _createPatient() async {
    if (_patientName.trim().isEmpty) {
      showToast(
        context: context,
        title: 'Nome obrigatório',
        description: 'Por favor, digite o nome do paciente',
        type: ToastificationType.warning,
      );
      return;
    }

    if (_pendingImages.isEmpty) {
      showToast(
        context: context,
        title: 'Foto obrigatória',
        description: 'É necessário pelo menos 1 foto para criar o paciente',
        type: ToastificationType.warning,
      );
      return;
    }

    if (_pendingImages.length > 10) {
      showToast(
        context: context,
        title: 'Muitas fotos',
        description: 'Máximo de 10 fotos permitidas',
        type: ToastificationType.warning,
      );
      return;
    }

    context.read<PatientPhotoCubit>().uploadMultiplePhotos(
      clinicId: widget.clinicId,
      namePatient: _patientName.trim(),
      imageFiles: _pendingImages,
      coverImageIndex: _coverImageIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    final hasPendingImages = _pendingImages.isNotEmpty;
    final colorBackground = const Color(0xFFE8E8E8);
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro de paciente'),
        centerTitle: true,
        backgroundColor: colorBackground,
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              child: IntrinsicHeight(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 610,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: colorBackground,
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(50),
                          bottomRight: Radius.circular(50),
                        ),
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                            child: PatientInfoHeader(
                              clinicName: widget.clinicName,
                              isActiveChangeName: true,
                              onNameChanged: (name) {
                                _patientName = name;
                              },
                            ),
                          ),
                          const SizedBox(height: 5),
                          hasPendingImages
                              ? PendingImagesGrid(
                                images: _pendingImages,
                                coverIndex: _coverImageIndex,
                                onAddPhoto: _pickImage,
                                onImageTap: (index) {
                                  setState(() {
                                    if (_coverImageIndex == index) {
                                      _coverImageIndex = null;
                                    } else {
                                      _coverImageIndex = index;
                                    }
                                  });
                                },
                                onImageRemove: (index) {
                                  setState(() {
                                    _pendingImages.removeAt(index);
                                    if (_coverImageIndex == index) {
                                      _coverImageIndex = null;
                                    } else if (_coverImageIndex != null &&
                                        _coverImageIndex! > index) {
                                      _coverImageIndex = _coverImageIndex! - 1;
                                    }
                                  });
                                },
                                onImageCrop: _cropImage,
                              )
                              : EmptyPhotosView(
                                onAddPhoto: _pickImage,
                                isUploading: false,
                              ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(40, 30, 40, 50),
                      child: BlocConsumer<PatientPhotoCubit, PatientPhotoState>(
                        listener: (context, state) {
                          if (state is Error) {
                            showToast(
                              context: context,
                              title: 'Erro ao criar paciente',
                              description: state.message,
                              type: ToastificationType.error,
                            );
                          } else if (state is Loaded) {
                            showToast(
                              context: context,
                              title: 'Sucesso',
                              description: 'Paciente criado com sucesso',
                              type: ToastificationType.success,
                            );
                            context.pop();
                          }
                        },
                        builder: (context, state) {
                          return LoadingButton(
                            borderRadius: 12,
                            backgroundColor: Colors.black,
                            textColor: Colors.white,
                            text: 'Criar paciente',
                            isLoading: state is Uploading,
                            onPressed: _createPatient,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
