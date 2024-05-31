import 'package:flutter/material.dart';

import '../constants/color.dart';
import '../constants/strings.dart';
import 'interest_selection_screen.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _email, _password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(Strings.signupText),
        backgroundColor: AppColor.appbar,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: const InputDecoration(labelText: Strings.emailText),
                validator: (value) {
                  if (value!.isEmpty) {
                    return Strings.enterEmailText;
                  }
                  return null;
                },
                onSaved: (value) => _email = value!,
              ),
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                decoration:
                    const InputDecoration(labelText: Strings.passwordText),
                obscureText: true,
                validator: (value) {
                  if (value!.isEmpty) {
                    return Strings.enterPasswordText;
                  }
                  return null;
                },
                onSaved: (value) => _password = value!,
              ),
              const SizedBox(
                height: 15,
              ),
              ElevatedButton(
                child: const Text(Strings.signupText),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState?.save();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              InterestSelectionScreen(email: _email)),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
