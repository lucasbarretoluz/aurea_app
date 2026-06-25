import 'package:aurea_app/src/logic/bloc/auth/auth_bloc.dart';
import 'package:aurea_app/src/logic/cubit/local_auth/local_auth_cubit.dart';
import 'package:aurea_app/src/presentation/screens/settings/widgets/setting_section.dart';
import 'package:aurea_app/src/presentation/screens/settings/widgets/setting_tile.dart';
import 'package:aurea_app/src/presentation/widgets/toast/custom_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth_android/local_auth_android.dart';
import 'package:local_auth_darwin/types/auth_messages_ios.dart';
import 'package:toastification/toastification.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SettingsPageView();
  }
}

class SettingsPageView extends StatefulWidget {
  const SettingsPageView({super.key});

  @override
  State<SettingsPageView> createState() => _SettingsPageViewState();
}

class _SettingsPageViewState extends State<SettingsPageView> {
  final LocalAuthentication _localAuth = LocalAuthentication();
  bool _isDeletingAccount = false;

  void _handleDeleteAccount(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Deletar Conta'),
        content: const Text(
          'Tem certeza que deseja deletar sua conta? Esta ação não pode ser desfeita.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(dialogContext).pop();
              setState(() {
                _isDeletingAccount = true;
              });
              context.read<AuthBloc>().add(const AuthEvent.deleteAccountRequest());
            },
            style: TextButton.styleFrom(
              foregroundColor: Theme.of(context).colorScheme.error,
            ),
            child: const Text('Deletar'),
          ),
        ],
      ),
    );
  }

  void _handleSignOut(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Sair'),
        content: const Text('Tem certeza que deseja sair?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(dialogContext).pop();
              context.read<AuthBloc>().add(const SignOutRequest());
            },
            child: const Text('Sair'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is UnAuth) {
          if (_isDeletingAccount) {
            showToast(
              context: context,
              title: 'Conta deletada com sucesso',
              type: ToastificationType.success,
            );
            _isDeletingAccount = false;
          }
          context.go('/login');
        } else if (state is AuthError && _isDeletingAccount) {
          _isDeletingAccount = false;
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Configurações'),
        ),
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            SettingSection(
              title: 'Segurança',
              children: [
                BlocBuilder<LocalAuthCubit, LocalAuthState>(
                  builder: (context, state) {
                    final isEnabled = state is LocalAuthEnabled;
                    return SettingTile(
                      icon: Icons.fingerprint,
                      title: 'Autenticação Local',
                      subtitle: isEnabled ? 'Ativada' : 'Desativada',
                      trailing: Switch(
                        value: isEnabled,
                        onChanged: (value) async {
                          if (value) {
                            try {
                              final didAuthenticate =
                                  await _localAuth.authenticate(
                                localizedReason:
                                    'Autentique-se para ativar a proteção',
                                options: const AuthenticationOptions(
                                  useErrorDialogs: false,
                                ),
                                authMessages: const <AuthMessages>[
                                  AndroidAuthMessages(
                                    signInTitle: 'Autenticação necessária',
                                    cancelButton: 'Cancelar',
                                    biometricHint: "",
                                  ),
                                  IOSAuthMessages(cancelButton: 'Cancelar'),
                                ],
                              );
                              if (didAuthenticate && context.mounted) {
                                context
                                    .read<LocalAuthCubit>()
                                    .enableBiometricAuth();
                              }
                            } catch (e) {
                              if (context.mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Biometria não configurada'),
                                  ),
                                );
                              }
                            }
                          } else {
                            context
                                .read<LocalAuthCubit>()
                                .disableBiometricAuth();
                          }
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 24),
            SettingSection(
              title: 'Consultórios',
              children: [
                SettingTile(
                  icon: Icons.local_hospital_outlined,
                  title: 'Gerenciar consultórios',
                  subtitle: 'Criar, renomear ou excluir consultórios',
                  onTap: () => context.push('/settings/clinics'),
                ),
              ],
            ),
            const SizedBox(height: 24),
            SettingSection(
              title: 'Conta',
              children: [
                SettingTile(
                  icon: Icons.delete_outline,
                  title: 'Deletar Conta',
                  subtitle: 'Excluir permanentemente sua conta',
                  isDestructive: true,
                  onTap: () => _handleDeleteAccount(context),
                ),
                SettingTile(
                  icon: Icons.logout,
                  title: 'Sair',
                  subtitle: 'Encerrar sua sessão',
                  onTap: () => _handleSignOut(context),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
