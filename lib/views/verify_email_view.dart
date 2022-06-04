import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as devtools show log;

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({Key? key}) : super(key: key);

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verify email'),
      ),
      body: Column(
          children: [
            const Text('Please verify your email address'),
            TextButton(
              onPressed: () async {
                final user = FirebaseAuth.instance.currentUser;
                devtools.log(user.toString());
                await user?.sendEmailVerification();
              },
              child: const Text('Send email Verification'),
            )
        ],
      ),
    );
  }
}