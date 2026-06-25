import 'package:aurea_app/src/data/models/profile_user/profile_user_model.dart';
import 'package:aurea_app/src/data/repository/profile_user_repository.dart';
import 'package:aurea_app/src/presentation/screens/patients_add/helpers/patient_photo_upload_helper.dart';
import 'package:aurea_app/src/presentation/screens/profile/widgets/profile_header.dart';
import 'package:aurea_app/src/presentation/screens/profile/widgets/profile_info_tile.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const ProfileView();
  }
}

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  late final ProfileUserRepository _profileRepository;
  late Future<ProfileUserModel> _profileFuture;
  bool _isUploadingPhoto = false;

  @override
  void initState() {
    super.initState();
    _profileRepository = GetIt.I<ProfileUserRepository>();
    _profileFuture = _loadProfile();
  }

  Future<ProfileUserModel> _loadProfile() async {
    final localProfile = await _profileRepository.getProfileData();
    try {
      return await _profileRepository.fetchProfileFromApi();
    } catch (_) {
      return localProfile;
    }
  }

  Future<void> _reloadProfile() async {
    setState(() {
      _profileFuture = _loadProfile();
    });
    await _profileFuture;
  }

  Future<void> _pickAndUploadPhoto() async {
    final imageFile = await PatientPhotoUploadHelper.pickAndCropImage(context);
    if (imageFile == null || !mounted) return;

    setState(() {
      _isUploadingPhoto = true;
    });

    try {
      await _profileRepository.uploadProfilePhoto(imageFile: imageFile);
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Foto de perfil atualizada')),
      );
      await _reloadProfile();
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Não foi possível atualizar a foto: $e')),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isUploadingPhoto = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Perfil',
          style: TextStyle(fontFamily: 'Montserrat'),
        ),
        leading: BackButton(onPressed: () => context.pop()),
      ),
      body: FutureBuilder<ProfileUserModel>(
        future: _profileFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting &&
              !_isUploadingPhoto) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error_outline, size: 48),
                    const SizedBox(height: 16),
                    const Text(
                      'Não foi possível carregar o perfil',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Montserrat',
                      ),
                    ),
                    const SizedBox(height: 16),
                    FilledButton(
                      onPressed: _reloadProfile,
                      child: const Text('Tentar novamente'),
                    ),
                  ],
                ),
              ),
            );
          }

          final profile = snapshot.data ?? const ProfileUserModel();

          return RefreshIndicator(
            onRefresh: _reloadProfile,
            child: ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 32),
              children: [
                ProfileHeader(
                  name: profile.nameUser,
                  photoUrl: profile.photo,
                  isPremium: profile.isPremium,
                  isUploadingPhoto: _isUploadingPhoto,
                  onPhotoTap: _pickAndUploadPhoto,
                ),
                const SizedBox(height: 32),
                ProfileInfoTile(
                  icon: Icons.email_outlined,
                  label: 'E-mail',
                  value: profile.email,
                ),
                ProfileInfoTile(
                  icon: Icons.phone_outlined,
                  label: 'Telefone',
                  value: profile.phone,
                ),
                ProfileInfoTile(
                  icon: Icons.workspace_premium_outlined,
                  label: 'Plano',
                  value: profile.isPremium ? 'Premium' : 'Gratuito',
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
