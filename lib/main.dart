// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_application_1/feature/prompt/ui/Creat_prompt_screen.dart';

void main() => runApp( MyApp());

class MyApp extends StatelessWidget {
  ThemeData darkMode = ThemeData(
    appBarTheme:AppBarTheme(backgroundColor: Colors.green),
      brightness: Brightness.dark,
      colorScheme: ColorScheme.dark(
          background: Colors.grey.shade900,
          primary: Colors.grey.shade700,
          secondary: Colors.grey.shade500));

   MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home:  CreatPromptScreen(),
      theme: darkMode,
    );
  }
}
