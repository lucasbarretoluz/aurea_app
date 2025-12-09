import 'dart:io';

import 'package:aurea_app/src/logic/bloc/auth/auth_bloc.dart';
import 'package:aurea_app/src/presentation/widgets/buttons/loading_button.dart';
import 'package:aurea_app/src/presentation/widgets/form_fields/text_field_with_label.dart';
import 'package:aurea_app/src/presentation/widgets/logo/logo_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class SingUpPage extends StatelessWidget {
  const SingUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingUpPageView();
  }
}

class SingUpPageView extends StatefulWidget {
  const SingUpPageView({super.key});

  @override
  State<SingUpPageView> createState() => _SingUpPageViewState();
}

class _SingUpPageViewState extends State<SingUpPageView>
    with SingleTickerProviderStateMixin {
  late AnimationController _pageController;

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void _handleSignUp() {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<AuthBloc>().add(
        SingUpRequest(
          name: _nameController.text,
          email: _emailController.text,
          password: _passwordController.text,
        ),
      );
    }
  }

  void _handleGoogleSignIn() {
    context.read<AuthBloc>().add(const SingInGoogleRequest());
  }

  void _handleAppleSignIn() {
    context.read<AuthBloc>().add(const SingInAppleRequest());
  }

  @override
  void initState() {
    super.initState();
    _pageController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is Authenticated) {
          context.go('/home');
        } else if (state is AuthSingUpError || state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state is AuthSingUpError ? state.error : (state as AuthError).error,
              ),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                'assets/images/smile_woman.jpg',
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),
            ),
            Positioned(
              left: 0,
              top: 0,
              bottom: 0,
              child: Container(
                color: Colors.black.withValues(alpha: 0.5),
                width: size.width * 0.7,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 40),
                      child: BackButton(color: Colors.white),
                    ),
                    Expanded(
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            LogoWidget(),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 32.0,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 40),
                                  Text(
                                    'Crie sua conta',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 22,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: 'Montserrat',
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  TextFieldWithLabel(
                                    controller: _nameController,
                                    hint: 'Nome Completo',
                                    colorLabel: Colors.white,
                                    iconColor: Colors.white,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Nome é obrigatório';
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(height: 32),
                                  TextFieldWithLabel(
                                    controller: _emailController,
                                    hint: 'Email',
                                    keyboardType: TextInputType.emailAddress,
                                    colorLabel: Colors.white,
                                    iconColor: Colors.white,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Email é obrigatório';
                                      }
                                      if (!value.contains('@')) {
                                        return 'Email inválido';
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(height: 32),
                                  TextFieldWithLabel(
                                    controller: _passwordController,
                                    hint: 'Senha',
                                    obscureText: true,
                                    colorLabel: Colors.white,
                                    iconColor: Colors.white,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Senha é obrigatória';
                                      }
                                      if (value.length < 6) {
                                        return 'Senha deve ter no mínimo 6 caracteres';
                                      }
                                      return null;
                                    },
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                right: 30,
                                left: 30,
                              ),
                              child: BlocBuilder<AuthBloc, AuthState>(
                                builder: (context, state) {
                                  final isLoading = state is AuthLoading;
                                  return LoadingButton(
                                    onPressed: isLoading ? null : _handleSignUp,
                                    isLoading: isLoading,
                                    text: 'Continuar',
                                  );
                                },
                              ),
                            ),
                            SizedBox(),
                            BlocBuilder<AuthBloc, AuthState>(
                              builder: (context, state) {
                                final isLoading = state is AuthLoading;
                                return Column(
                                  children: [
                                    Text(
                                      'Ou faça login com',
                                      style: TextStyle(
                                        color: Colors.white.withOpacity(0.7),
                                        fontSize: 14,
                                        fontFamily: 'Montserrat',
                                      ),
                                    ),
                                    SizedBox(height: 16),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        GestureDetector(
                                          onTap: isLoading ? null : _handleGoogleSignIn,
                                          child: Container(
                                            width: 50,
                                            height: 50,
                                            padding: const EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                              color: Colors.white.withOpacity(0.2),
                                              borderRadius: BorderRadius.circular(10),
                                            ),
                                            child: SvgPicture.asset('assets/icons/google.svg'),
                                          ),
                                        ),
                                        if (Platform.isIOS) ...[
                                          const SizedBox(width: 10),
                                          GestureDetector(
                                            onTap: isLoading ? null : _handleAppleSignIn,
                                            child: Container(
                                              width: 50,
                                              height: 50,
                                              padding: const EdgeInsets.fromLTRB(6, 6, 6, 10),
                                              decoration: BoxDecoration(
                                                color: Colors.white.withOpacity(0.2),
                                                borderRadius: BorderRadius.circular(10),
                                              ),
                                              child: SvgPicture.asset(
                                                'assets/icons/apple.svg',
                                                colorFilter: const ColorFilter.mode(
                                                  Colors.white,
                                                  BlendMode.srcIn,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ],
                                    ),
                                  ],
                                );
                              },
                            ),
                            SizedBox(height: 20),
                            SizedBox(height: 20),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
