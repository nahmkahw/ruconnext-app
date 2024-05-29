// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:auth_buttons/auth_buttons.dart' show GoogleAuthButton;
import '../providers/authenprovider.dart';
import 'package:provider/provider.dart';

import 'app_theme.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String inputText = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<AuthenProvider>(
        builder: (context, authen, child) {
          if (authen.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [AppTheme.white, AppTheme.nearlyBlack],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter),
            ),
            child: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(15, 30, 15, 15),
                          child: Column(
                            children: [
                              Image.asset('assets/images/logo.png', height: 80),
                              const SizedBox(height: 200),
                              TextField(
                                key: Key("StudentCode"),
                                onChanged: (text) {
                                  setState(() {
                                    inputText = text;
                                  });
                                },
                                decoration: InputDecoration(
                                  labelText:
                                      'Enter Student Code 10-digit Number',
                                ),
                                keyboardType: TextInputType.number,
                                maxLength: 10,
                              ),
                              if (inputText.length == 10)
                                // 5312740208
                                if (inputText == "5424101212" ||
                                    inputText == "5519860049" ||
                                    inputText == "6299999991")
                                  Container(
                                    color: Colors.black,
                                    child: GoogleAuthButton(
                                      key: Key("googleAuthButtonTest"),
                                      onPressed: () {
                                        authen.logintest(context, inputText);
                                      },
                                    ),
                                  )
                                else
                                  GoogleAuthButton(
                                    key: Key("googleAuthButton"),
                                    onPressed: () {
                                      authen.login(context);
                                    },
                                  ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
