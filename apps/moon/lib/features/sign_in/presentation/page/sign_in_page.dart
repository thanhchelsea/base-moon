import 'package:auth/presentation/page/auth_page.dart';
import 'package:flutter/material.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SigInView(
        appName: 'Moon',
        onLoginSuccess: (loginResponse) {
          //TODO: navigate to home page
          print('Thanh cong');
        },
      ),
    );
  }
}
