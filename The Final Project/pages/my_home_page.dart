import 'package:final_project/pages/login_page.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  static const String routeName = '/LoginPage';
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors:[
            Colors.blue,
            Colors.blueGrey,
            Colors.yellow,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          )
        ),
        child: const LoginPage(),
      ),
    );
  }
}
