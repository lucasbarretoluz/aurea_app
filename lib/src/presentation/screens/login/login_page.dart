import 'dart:ui';

import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const LoginPageView();
  }
}

class LoginPageView extends StatelessWidget {
  const LoginPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(),
              Column(
                children: [
                  Text(
                    'aurea',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 50,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 20,
                    ),
                  ),
                  Divider(
                    color: Colors.white,
                    thickness: 0.3,
                    indent: 75,
                    endIndent: 75,
                  ),
                  Text(
                    'design app',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 20,
                      fontWeight: FontWeight.w300,
                      letterSpacing: 8.0,
                    ),
                  ),
                ],
              ),
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Column(
                        children: [
                          TextButton(
                            onPressed: () {},
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
                            onPressed: () {},
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
            ),
          ),
        ],
      ),
    );
  }
}
