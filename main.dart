import 'package:final_project/pages/add_book.dart';
import 'package:final_project/pages/book_list.dart';
import 'package:final_project/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'Models/book.dart';
import 'pages/login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      
      
      initialRoute: HomePage.routeName,
      routes: {
        HomePage.routeName: (context) => const HomePage(),
        AddBook.routeName:(context) => AddBook(),
        "LoginPage:":(context) => const LoginPage(),
        "ListPage":(context) => BookList(booksToGenerate: Book.generateData(10))
        
      },
      debugShowCheckedModeBanner: false,
    );
  }
}

