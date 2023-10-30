import 'package:flutter/material.dart';
import 'package:basic/components/Home.dart';
import 'package:basic/components/LoginScreen.dart';
import 'package:firebase_core/firebase_core.dart'; // Pastikan nama file dan path sudah sesuai

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LoginScreen(), // Mengubah home menjadi MyHome dari Home.dart
    );
  }
}
