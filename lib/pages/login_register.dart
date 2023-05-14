import 'package:assignment/pages/login_page.dart';
import 'package:assignment/pages/registration_page.dart';
import 'package:flutter/material.dart';

class LoginOrRegisterPage extends StatefulWidget {
  final Function()? onTap;
  const LoginOrRegisterPage({super.key, required this.onTap});

  @override
  State<LoginOrRegisterPage> createState() => _LoginOrRegisterPageState();
}

class _LoginOrRegisterPageState extends State<LoginOrRegisterPage> {
  //show login page first
  bool showLoginPage = true;
  //toggle between login and Registration Page
  void togglePage() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return LoginPage(onTap: togglePage);
    } else {
      return RegistrationPage(
        onTap: togglePage,
      );
    }
  }
}
