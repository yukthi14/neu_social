import 'package:flutter/material.dart';
import 'package:neu_social/screens/signup_screen.dart';

import 'constants/app_theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'neu-social',
      debugShowCheckedModeBanner: false,
      theme: appTheme(),
      home: SignUpScreen(),
    );
  }
}
