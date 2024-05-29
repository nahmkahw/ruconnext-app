import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:th.ac.ru.uSmart/providers/authenprovider.dart'; // Replace with the actual import path of AuthenProvider

class LoginMain extends StatefulWidget {
  @override
  _LoginMainState createState() => _LoginMainState();
}

class _LoginMainState extends State<LoginMain> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<AuthenProvider>(
        builder: (context, authen, child) {
          return Center(child: Text('Welcome'));
        },
      ),
    );
  }
}
