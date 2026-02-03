import 'dart:io';
import 'package:aurea_app/src/data/models/patient/patient_model.dart';
import 'package:aurea_app/src/logic/cubit/patient_photo/patient_photo_cubit.dart';
import 'package:aurea_app/src/presentation/screens/patients/helpers/patient_photo_upload_helper.dart';
import 'package:aurea_app/src/presentation/widgets/buttons/card_button.dart';
import 'package:aurea_app/src/presentation/screens/patients/widgets/empty_photos_view.dart';
import 'package:aurea_app/src/presentation/screens/patients/widgets/pending_images_grid.dart';
import 'package:aurea_app/src/presentation/screens/patients/widgets/photo_viewer.dart';
import 'package:aurea_app/src/presentation/screens/patients/widgets/photo_content_container.dart';
import 'package:aurea_app/src/presentation/screens/patients/widgets/patient_name_field.dart';
import 'package:aurea_app/src/presentation/screens/patients/widgets/patient_info_header.dart';
import 'package:aurea_app/src/presentation/screens/patients/widgets/photo_content_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class HandlePatientsPage extends StatelessWidget {
  final PatientModel? patient;
  final String? clinicName;
  const HandlePatientsPage({super.key, this.patient, this.clinicName});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final cubit = PatientPhotoCubit();
        if (patient != null && patient!.patientId > 0) {
          cubit.loadPhotos(patient!.patientId);
        }
        return cubit;
      },
      child: HandlePatientsView(patient: patient, clinicName: clinicName),
    );
  }
}

class HandlePatientsView extends StatefulWidget {
  final PatientModel? patient;
  final String? clinicName;
  const HandlePatientsView({super.key, this.patient, this.clinicName});

  @override
  State<HandlePatientsView> createState() => _HandlePatientsViewState();
}

class _HandlePatientsViewState extends State<HandlePatientsView> {
  final List<File> _pendingImages = [];
  int? _coverImageIndex;
  final TextEditingController _nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.patient != null) {
      _nameController.text = widget.patient!.name;
    }
    _nameController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        left: false,
        right: false,
        bottom: false,
        child: Column(
          children: [
            BlocBuilder<PatientPhotoCubit, PatientPhotoState>(
              builder: (context, state) {
                final loadedState = _getLoadedState(state);
                final isUploading = _isUploadingState(state);
                final urls = loadedState?.urls ?? <String>[];
                final hasPhotos = urls.isNotEmpty;
                final hasPendingImages = _pendingImages.isNotEmpty;
                
                Widget photoContent;

                if (widget.patient == null || widget.patient!.patientId == 0) {
                  if (_pendingImages.isEmpty) {
                    photoContent = EmptyPhotosView(
                      onAddPhoto: _pickImage,
                      isUploading: false,
                    );
                  } else {
                    photoContent = PendingImagesGrid(
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
                    );
                  }
                } else if (loadedState != null) {
                  if (urls.isEmpty && _pendingImages.isEmpty) {
                    photoContent = EmptyPhotosView(
                      onAddPhoto: _pickImage,
                      isUploading: false,
                    );
                  } else if (_pendingImages.isNotEmpty) {
                    photoContent = PendingImagesGrid(
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
                    );
                  } else {
                    photoContent = PhotoViewer(
                      photoUrls: urls,
                      onAddPhoto: _pickImage,
                    );
                  }
                } else if (isUploading) {
                  if (_pendingImages.isNotEmpty) {
                    photoContent = PendingImagesGrid(
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
                    );
                  } else {
                    photoContent = const PhotoContentContainer(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                } else {
                  photoContent = const PhotoContentContainer(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }

                return PhotoContentWrapper(
                  photoContent: photoContent,
                  hasPhotos: hasPhotos || hasPendingImages,
                );
              },
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (widget.patient == null || widget.patient!.patientId == 0)
                    PatientNameField(
                      controller: _nameController,
                      clinicName: widget.clinicName,
                    )
                  else
                    PatientInfoHeader(
                      name: widget.patient!.name,
                      clinicName: widget.patient!.clinicName,
                      onNameChanged: (name) {
                       
                      },
                    ),
                  SizedBox(width: double.infinity),
                  const SizedBox(height: 30),
                  if (widget.patient != null && widget.patient!.patientId > 0)
                    CardButton(
                      title: 'Novo ',
                      titleBold: 'Projeto',
                      subtitle: 'Clique para iniciar um novo',
                      description: 'planejamento do sorriso',
                      onPressed:
                          () => context.push(
                            '/handle-patients/new-project-patient',
                            extra: {'patient': widget.patient},
                          ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  dynamic _getLoadedState(PatientPhotoState state) {
    try {
      final stateMap = state as dynamic;
      if (stateMap.urls != null) {
        return stateMap;
      }
    } catch (_) {}
    return null;
  }

  bool _isUploadingState(PatientPhotoState state) {
    try {
      final stateMap = state as dynamic;
      final hasUrls = stateMap.urls != null;
      final hasMessage = stateMap.message != null;
      return !hasUrls && !hasMessage;
    } catch (_) {
      return false;
    }
  }

  Future<void> _pickImage() async {
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

  void _uploadPendingImages() {
    final isNewPatient = widget.patient == null || widget.patient!.patientId == 0;
    final result = PatientPhotoUploadHelper.uploadPendingImages(
      context: context,
      pendingImages: _pendingImages,
      isNewPatient: isNewPatient,
      patientName: isNewPatient ? _nameController.text : null,
      patientId: widget.patient?.patientId,
      photoCubit: context.read<PatientPhotoCubit>(),
    );

    if (result.shouldClearPendingImages()) {
      setState(() {
        _pendingImages.clear();
        _coverImageIndex = null;
      });
    }
  }
}
