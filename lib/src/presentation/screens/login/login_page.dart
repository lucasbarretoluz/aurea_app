import 'dart:ui';

import 'package:aurea_app/src/logic/bloc/auth/auth_bloc.dart';
import 'package:aurea_app/src/presentation/widgets/buttons/loading_button.dart';
import 'package:aurea_app/src/presentation/widgets/form_fields/text_field_with_label.dart';
import 'package:aurea_app/src/presentation/widgets/logo/logo_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const LoginPageView();
  }
}

class LoginPageView extends StatefulWidget {
  const LoginPageView({super.key});

  @override
  State<LoginPageView> createState() => _LoginPageViewState();
}

class _LoginPageViewState extends State<LoginPageView>
    with SingleTickerProviderStateMixin {
  bool _showLoginForm = false;
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  late AnimationController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  void _handleLogin() {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<AuthBloc>().add(
        SignInRequest(
          username: _emailController.text,
          password: _passwordController.text,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is Authenticated) {
          context.go('/home');
        } else if (state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.error), backgroundColor: Colors.red),
          );
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(),
                LogoWidget(),
                SizedBox(),
                SizedBox(),
                Container(
                  color: Colors.red,
                  child: Image.asset(
                    'assets/images/tooth_login.jpg',
                    fit: BoxFit.fitWidth,
                    width: MediaQuery.of(context).size.width,
                  ),
                ),
              ],
            ),
            Positioned(
              bottom: 0,
              left: 40,
              right: 40,
              child: Container(
                height: 500,
                width: 200,
                decoration: BoxDecoration(
                  color: Color(0xffefefef).withOpacity(0.5),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    transitionBuilder:
                        (Widget child, Animation<double> animation) {
                          return SlideTransition(
                            position:
                                Tween<Offset>(
                                  begin: _showLoginForm
                                      ? const Offset(1.0, 0.0)
                                      : const Offset(-1.0, 0.0),
                                  end: Offset.zero,
                                ).animate(
                                  CurvedAnimation(
                                    parent: animation,
                                    curve: Curves.easeInOut,
                                  ),
                                ),
                            child: child,
                          );
                        },
                    child: _showLoginForm
                        ? _buildLoginForm(key: const ValueKey('login'))
                        : _buildMenu(key: const ValueKey('menu')),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenu({Key? key}) {
    return Container(
      key: key,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            children: [
              Column(
                children: [
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _showLoginForm = true;
                      });
                    },
                    child: Text(
                      'Faça login',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w200,
                        fontFamily: 'Montserrat',
                      ),
                    ),
                  ),
                  Divider(
                    color: Colors.white,
                    thickness: 0.3,
                    indent: 75,
                    endIndent: 75,
                  ),
                ],
              ),
              SizedBox(height: 30),
              Column(
                children: [
                  TextButton(
                    onPressed: () => context.push('/sing-up'),
                    child: Text(
                      'Crie sua conta',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w200,
                        fontFamily: 'Montserrat',
                      ),
                    ),
                  ),
                  Divider(
                    color: Colors.white,
                    thickness: 0.3,
                    indent: 75,
                    endIndent: 75,
                  ),
                ],
              ),
            ],
          ),
          SizedBox(),
          SizedBox(),
        ],
      ),
    );
  }

  Widget _buildLoginForm({Key? key}) {
    return Container(
      key: key,
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(24.0, 16.0, 24.0, 0.0),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _showLoginForm = false;
                  });
                },
                child: Container(
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    Icons.arrow_back_ios_new,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 14),
                  TextFieldWithLabel(
                    controller: _emailController,
                    label: 'Email',
                    keyboardType: TextInputType.emailAddress,
                    colorLabel: Colors.white,
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
                    label: 'Senha',
                    obscureText: true,
                    colorLabel: Colors.white,
                    iconColor: Colors.white,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Senha é obrigatória';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 26),
                  BlocBuilder<AuthBloc, AuthState>(
                    builder: (context, state) {
                      final isLoading = state is AuthLoading;
                      return LoadingButton(
                        onPressed: isLoading ? null : _handleLogin,
                        isLoading: isLoading,
                        text: 'Continuar',
                      );
                    },
                  ),
                  SizedBox(height: 25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(
                          Icons.g_mobiledata_rounded,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(width: 10),
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(Icons.apple, color: Colors.white),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
