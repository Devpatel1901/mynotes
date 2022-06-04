import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as devtools show log;

import 'package:mynotes/constants/routes.dart';
// import 'package:firebase_core/firebase_core.dart';

// import '../firebase_options.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

    @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Column(children: [
                  TextField(
                    enableSuggestions: false,
                    autocorrect: false,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      hintText: 'Enter Your Email',
                    ),
                    controller: _email,
                  ),  
                  TextField(
                    obscureText: true,
                    enableSuggestions: false,
                    autocorrect: false,
                    decoration: const InputDecoration(
                      hintText: 'Enter Your Password',
                    ),
                    controller: _password,
                  ),
                  TextButton(
                    onPressed: () async{
                      final email = _email.text;
                      final password = _password.text;
                      try{
                        await FirebaseAuth.instance.signInWithEmailAndPassword(
                          email: email, 
                          password: password
                        );
                        Navigator.of(context).pushNamedAndRemoveUntil(
                          notesRoute, 
                          (route) => false,
                        );
                      }on FirebaseAuthException catch(e){
                        if(e.code == "user-not-found"){
                          devtools.log("User Not Found");
                        }else if(e.code == 'wrong-password'){
                          devtools.log('Wrong Password');
                        }
                      }
                    },
                    child: const Text('Login')
                  ),
                  TextButton(
                    onPressed: (){
                      Navigator.of(context).pushNamedAndRemoveUntil(
                        registerRoute, 
                        (route) => false,
                      );
                    }, 
                    child: const Text('Not registered yet? Register here!'),
                  )
                ]),
    );
  }


}