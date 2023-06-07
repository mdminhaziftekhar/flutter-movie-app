import 'package:bitmascot_assessment/features/auth/login_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/email_model.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => EmailModel(),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}
