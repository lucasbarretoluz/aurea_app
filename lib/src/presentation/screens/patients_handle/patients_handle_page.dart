import 'package:aurea_app/src/data/models/patient/patient_model.dart';
import 'package:aurea_app/src/data/models/patient/patient_photo_model.dart';
import 'package:aurea_app/src/data/models/exceptions/exceptions.dart';
import 'package:aurea_app/src/data/repository/patient_repository.dart';
import 'package:aurea_app/src/logic/cubit/clinic/clinic_cubit.dart';
import 'package:aurea_app/src/logic/cubit/patient/patient_cubit.dart';
import 'package:aurea_app/src/logic/cubit/patient_photo/patient_photo_cubit.dart';
import 'package:aurea_app/src/logic/cubit/patient_smile_plans/patient_smile_plans_cubit.dart';
import 'package:aurea_app/src/presentation/screens/patients_add/helpers/patient_photo_upload_helper.dart';
import 'package:aurea_app/src/presentation/screens/patients_add/widgets/photo_viewer.dart';
import 'package:aurea_app/src/presentation/screens/patients_handle/models/photo_view_mode.dart';
import 'package:aurea_app/src/presentation/screens/patients_handle/widgets/empty_patient_photos_view.dart';
import 'package:aurea_app/src/presentation/screens/patients_handle/widgets/error_patient_photos_view.dart';
import 'package:aurea_app/src/presentation/screens/patients_handle/widgets/patient_handle_gallery_header.dart';
import 'package:aurea_app/src/presentation/screens/patients_handle/widgets/patient_handle_bottom_panel.dart';
import 'package:aurea_app/src/presentation/screens/patients_handle/widgets/patient_handle_options_sheet.dart';
import 'package:aurea_app/src/presentation/widgets/toast/custom_toast.dart';
import 'package:aurea_app/src/smile_planning/models/smile_plan.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:toastification/toastification.dart';

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
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create:
              (context) =>
                  PatientPhotoCubit()..loadPhotos(
                    patient.patientId,
                    profilePhotoUrl: patient.profilePhotoUrl,
                  ),
        ),
        BlocProvider(
          create:
              (context) =>
                  PatientSmilePlansCubit()..load(patient.patientId),
        ),
      ],
      child: PatientsHandleView(
        patient: patient,
        clinicId: clinicId,
        clinicName: clinicName,
      ),
    );
  }
}

class PatientsHandleView extends StatefulWidget {
  final PatientModel patient;
  final int clinicId;
  final String clinicName;

  const PatientsHandleView({
    super.key,
    required this.patient,
    required this.clinicId,
    required this.clinicName,
  });

  @override
  State<PatientsHandleView> createState() => _PatientsHandleViewState();
}

class _PatientsHandleViewState extends State<PatientsHandleView> {
  final GlobalKey<PhotoViewerState> _photoViewerKey = GlobalKey();
  final PatientRepository _patientRepository = PatientRepository();
  List<PatientPhotoItem> _cachedPhotos = [];
  int _selectedPhotoIndex = 0;
  PhotoViewMode _viewMode = PhotoViewMode.original;
  bool _isDeletingPatient = false;

  List<String> get _cachedPhotoUrls =>
      _cachedPhotos.map((photo) => photo.url).toList();

  Future<void> _pickAndUploadPhoto() async {
    final imageFile = await PatientPhotoUploadHelper.pickImage(context);
    if (imageFile == null || !mounted) return;

    await context.read<PatientPhotoCubit>().uploadPhoto(
      patientId: widget.patient.patientId,
      imageFile: imageFile,
    );

    if (!mounted) return;
    final state = context.read<PatientPhotoCubit>().state;
    if (state is Error) {
      showToast(
        context: context,
        title: 'Erro ao enviar foto',
        description: state.message,
        type: ToastificationType.error,
      );
    }
  }

  void _onPhotoPageChanged(int index) {
    setState(() {
      _selectedPhotoIndex = index;
      _syncViewModeForSelection();
    });
  }

  void _syncViewModeForSelection() {
    if (_cachedPhotoUrls.isEmpty ||
        _selectedPhotoIndex >= _cachedPhotoUrls.length) {
      _viewMode = PhotoViewMode.original;
      return;
    }

    final plansCubit = context.read<PatientSmilePlansCubit>();
    final url = _cachedPhotoUrls[_selectedPhotoIndex];
    if (!plansCubit.hasPlanForPhoto(url)) {
      _viewMode = PhotoViewMode.original;
    }
  }

  Set<String> _plannedPhotoUrls(List<SmilePlan> plans) {
    return plans
        .where((plan) => plan.photoUrl.isNotEmpty)
        .map((plan) => plan.photoUrl)
        .toSet();
  }

  SmilePlan? _selectedPlan(List<SmilePlan> plans) {
    if (_cachedPhotoUrls.isEmpty ||
        _selectedPhotoIndex >= _cachedPhotoUrls.length) {
      return null;
    }

    final selectedUrl = _cachedPhotoUrls[_selectedPhotoIndex];
    for (final plan in plans) {
      if (plan.photoUrl == selectedUrl) return plan;
    }
    return null;
  }

  Future<void> _reloadSmilePlans() async {
    await context.read<PatientSmilePlansCubit>().load(widget.patient.patientId);
    if (!mounted) return;
    setState(_syncViewModeForSelection);
  }

  Future<void> _openPatientOptions(List<SmilePlan> plans) async {
    await PatientHandleOptionsSheet.show(
      context: context,
      patient: widget.patient,
      photos: _cachedPhotos,
      selectedPhotoIndex: _selectedPhotoIndex,
      plannedPhotoUrls: _plannedPhotoUrls(plans),
      onDeletePhoto: _deletePhoto,
      onDeletePatient: _deletePatient,
    );
  }

  Future<void> _deletePatient() async {
    if (_isDeletingPatient) return;

    setState(() => _isDeletingPatient = true);
    try {
      await _patientRepository.deletePatient(widget.patient.patientId);
      if (!mounted) return;

      await context.read<PatientSmilePlansCubit>().deleteAllForPatient(
        widget.patient.patientId,
      );

      if (!mounted) return;

      context.read<PatientCubit>().removePatient(widget.patient.patientId);
      context.read<ClinicCubit>().removePatientFromClinic(
        clinicId: widget.clinicId,
        patientId: widget.patient.patientId,
      );

      showToast(
        context: context,
        title: 'Paciente excluído',
        description: 'O paciente e todas as fotos foram removidos.',
        type: ToastificationType.success,
      );

      if (!mounted) return;
      context.pop();
    } on RepositoryException catch (e) {
      if (!mounted) return;
      showToast(
        context: context,
        title: 'Erro ao excluir paciente',
        description: e.message,
        type: ToastificationType.error,
      );
    } catch (e) {
      if (!mounted) return;
      showToast(
        context: context,
        title: 'Erro ao excluir paciente',
        description: e.toString(),
        type: ToastificationType.error,
      );
    } finally {
      if (mounted) {
        setState(() => _isDeletingPatient = false);
      }
    }
  }

  Future<void> _deletePhoto(PatientPhotoItem photo) async {
    final photoCubit = context.read<PatientPhotoCubit>();
    final plansCubit = context.read<PatientSmilePlansCubit>();

    await photoCubit.deletePhoto(
      patientId: widget.patient.patientId,
      photo: photo,
    );

    if (!mounted) return;
    if (photoCubit.state is Error) return;

    await plansCubit.deletePlanForPhoto(widget.patient.patientId, photo.url);

    if (!mounted) return;
    showToast(
      context: context,
      title: 'Foto excluída',
      description: 'A foto foi removida do paciente.',
      type: ToastificationType.success,
    );
  }

  Widget _buildPhotoViewer({
    required double galleryHeight,
    required List<SmilePlan> plans,
    required List<String> photoUrls,
    required SmilePlan? selectedPlan,
    required bool showPlanning,
    required VoidCallback onAddPhoto,
  }) {
    return PhotoViewer(
      key: _photoViewerKey,
      height: galleryHeight,
      photoUrls: photoUrls,
      onAddPhoto: onAddPhoto,
      controlledIndex: _selectedPhotoIndex,
      initialPage: _selectedPhotoIndex,
      onPageChanged: _onPhotoPageChanged,
      showPlanningPreview: showPlanning,
      previewPlan: selectedPlan,
      plannedPhotoUrls: _plannedPhotoUrls(plans),
    );
  }

  Widget _buildGallery({
    required double galleryHeight,
    required List<SmilePlan> plans,
    required PatientPhotoState photoState,
  }) {
    if (photoState is Loading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (photoState is Loaded) {
      if (photoState.photos.isEmpty) {
        return EmptyPatientPhotosView(
          onAddPhoto: _pickAndUploadPhoto,
          isUploading: false,
        );
      }

      final selectedPlan = _selectedPlan(plans);
      final showPlanning =
          _viewMode == PhotoViewMode.planning && selectedPlan != null;

      return _buildPhotoViewer(
        galleryHeight: galleryHeight,
        plans: plans,
        photoUrls: photoState.photos.map((photo) => photo.url).toList(),
        selectedPlan: selectedPlan,
        showPlanning: showPlanning,
        onAddPhoto: _pickAndUploadPhoto,
      );
    }
    if (photoState is Uploading && _cachedPhotoUrls.isEmpty) {
      return EmptyPatientPhotosView(
        onAddPhoto: () {},
        isUploading: true,
      );
    }
    if ((photoState is Uploading || photoState is Deleting) &&
        _cachedPhotoUrls.isNotEmpty) {
      final selectedPlan = _selectedPlan(plans);
      final showPlanning =
          _viewMode == PhotoViewMode.planning && selectedPlan != null;

      return Stack(
        children: [
          _buildPhotoViewer(
            galleryHeight: galleryHeight,
            plans: plans,
            photoUrls: _cachedPhotoUrls,
            selectedPlan: selectedPlan,
            showPlanning: showPlanning,
            onAddPhoto: photoState is Uploading ? () {} : _pickAndUploadPhoto,
          ),
          Container(
            color: Colors.black26,
            child: const Center(
              child: CircularProgressIndicator(color: Colors.white),
            ),
          ),
        ],
      );
    }
    if (photoState is Deleting && _cachedPhotoUrls.isEmpty) {
      return EmptyPatientPhotosView(
        onAddPhoto: _pickAndUploadPhoto,
        isUploading: true,
      );
    }
    if (photoState is Uploading || photoState is Deleting) {
      return const Center(child: CircularProgressIndicator());
    }
    if (photoState is Error) {
      return ErrorPatientPhotosView(
        onRetry: () {
          context.read<PatientPhotoCubit>().loadPhotos(
            widget.patient.patientId,
            profilePhotoUrl: widget.patient.profilePhotoUrl,
          );
        },
      );
    }
    return const SizedBox.shrink();
  }

  @override
  Widget build(BuildContext context) {
    final sizeHeight = MediaQuery.sizeOf(context).height;
    final appBarHeight = MediaQuery.of(context).padding.top;
    final galleryHeight = sizeHeight * 0.48;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        top: false,
        child: Column(
          children: [
            SizedBox(
              height: galleryHeight + appBarHeight,
              child: BlocBuilder<PatientSmilePlansCubit, PatientSmilePlansState>(
                builder: (context, plansState) {
                  final plans =
                      plansState is PatientSmilePlansLoaded
                          ? plansState.plans
                          : const <SmilePlan>[];

                  return BlocBuilder<PatientPhotoCubit, PatientPhotoState>(
                    builder: (context, photoState) {
                      return Stack(
                        clipBehavior: Clip.hardEdge,
                        children: [
                          Positioned.fill(
                            top: appBarHeight,
                            child: BlocConsumer<
                              PatientPhotoCubit,
                              PatientPhotoState
                            >(
                              listener: (context, state) {
                                if (state is Loaded) {
                                  setState(() {
                                    _cachedPhotos = state.photos;
                                    if (_selectedPhotoIndex >=
                                        state.photos.length) {
                                      _selectedPhotoIndex =
                                          state.photos.isEmpty
                                              ? 0
                                              : state.photos.length - 1;
                                    }
                                    _syncViewModeForSelection();
                                  });
                                }
                                if (state is Error) {
                                  showToast(
                                    context: context,
                                    title: 'Erro',
                                    description: state.message,
                                    type: ToastificationType.error,
                                  );
                                }
                              },
                              builder: (context, galleryPhotoState) {
                                return _buildGallery(
                                  galleryHeight: galleryHeight,
                                  plans: plans,
                                  photoState: galleryPhotoState,
                                );
                              },
                            ),
                          ),
                          Positioned(
                            top: appBarHeight + 8,
                            left: 0,
                            right: 0,
                            child: PatientHandleGalleryHeader(
                              showMenuButton: true,
                              onMenuPressed: () => _openPatientOptions(plans),
                            ),
                          ),
                          if (_isDeletingPatient)
                            Positioned.fill(
                              child: ColoredBox(
                                color: Colors.black.withValues(alpha: 0.2),
                                child: const Center(
                                  child: CircularProgressIndicator(),
                                ),
                              ),
                            ),
                        ],
                      );
                    },
                  );
                },
              ),
            ),
            Expanded(
              child: BlocBuilder<PatientSmilePlansCubit, PatientSmilePlansState>(
                builder: (context, plansState) {
                  final plans =
                      plansState is PatientSmilePlansLoaded
                          ? plansState.plans
                          : const <SmilePlan>[];

                  return BlocBuilder<PatientPhotoCubit, PatientPhotoState>(
                    builder: (context, photoState) {
                      final photoUrls =
                          photoState is Loaded
                              ? photoState.photos.map((photo) => photo.url).toList()
                              : _cachedPhotoUrls;
                      final selectedPlan = _selectedPlan(plans);
                      final selectedPhotoUrl =
                          photoUrls.isEmpty || _selectedPhotoIndex >= photoUrls.length
                              ? ''
                              : photoUrls[_selectedPhotoIndex];

                      return PatientHandleBottomPanel(
                        patient: widget.patient,
                        clinicName: widget.clinicName,
                        clinicId: widget.clinicId,
                        photoUrls: photoUrls,
                        selectedPhotoUrl: selectedPhotoUrl,
                        selectedPlan: selectedPlan,
                        viewMode:
                            selectedPlan == null
                                ? PhotoViewMode.original
                                : _viewMode,
                        isUploading:
                            photoState is Uploading ||
                            photoState is Deleting ||
                            _isDeletingPatient,
                        onViewModeChanged: (mode) {
                          setState(() => _viewMode = mode);
                        },
                        onAddPhoto: _pickAndUploadPhoto,
                        onPlanningFinished: _reloadSmilePlans,
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
