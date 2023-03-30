import 'package:final_project/pages/book_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../Models/book.dart';

class HomePage extends StatefulWidget {
  static const String routeName = '/HomePage';
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text(
          'Home Page',
          style: TextStyle(
              fontFamily: "Times New Roman",
              fontSize: 21,
              fontWeight: FontWeight.bold),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.blue,
              Colors.blueGrey,
              Colors.yellow,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 28),
                child: Image(
                  image: AssetImage('images/library_logo.png'),
                  fit: BoxFit.fill,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'ASU Library',
                  style: TextStyle(
                      fontFamily: "Times New Roman",
                      fontSize: 40,
                      fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
        ),
      ),
      drawer: Drawer(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.blueGrey,
                Colors.yellow,
              ],
              begin: Alignment.center,
              end: Alignment.bottomCenter,
            ),
          ),
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.blue,
                      Colors.blueGrey,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Image(
                  image: AssetImage("images/asulibrary.png"),
                ),
              ),
              ListTile(
                leading: const Icon(
                  Icons.list,
                  color: Colors.black,
                  size: 35,
                ),
                title: const Text(
                  'List Page',
                  style: TextStyle(
                    fontFamily: "Times New Roman",
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BookList(
                        booksToGenerate: Book.generateData(10),
                      ),
                    ),
                  );
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.exit_to_app_rounded,
                  color: Colors.black,
                  size: 30,
                ),
                title: const Text(
                  'Exit',
                  style: TextStyle(
                      fontFamily: "Times New Roman",
                      fontSize: 21,
                      fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  SystemNavigator.pop();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
