import 'package:flutter/material.dart';
import 'package:basic/components/LoginScreen.dart';
import 'LoginScreen.dart';

class MyHome extends StatefulWidget {
  final String wid;
  const MyHome({super.key, required this.wid});

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  String? email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [
        IconButton(
          icon: const Icon(Icons.logout_sharp),
          tooltip: 'Logout',
          onPressed: () {},
        ),
      ]),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Welcome $email'),
            Text("ID ${widget.wid}"),
          ],
        ),
      ),
    );
  }
}
