import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'list_page.dart';

class HomePage extends StatefulWidget {
  static const String title ='Home Page';
  static const String routeName ='/';

  const HomePage({ Key? key }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(HomePage.title),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top:100.0),
        child: Column(
          children:const [
            Image(image: AssetImage('images/university-icon.jpg'),width: 500),
             Center(
              child: Text(
                'University', 
                style: TextStyle(
                  fontSize: 30, 
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Tahoma',
                  ),
                  )
                  ),
          ],
        ),
      ),
      
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.red,
                image: DecorationImage(
                  image: AssetImage("images/drawerbackground.jpg"),
                     fit: BoxFit.cover),
                     ),
              child: Text('Student List', 
              style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
            ListTile(
              title: const Text(ListPage.title),
              onTap: (){
                Navigator.pushNamed(context, ListPage.routeName);
              },
              ),

              ListTile(
              title: const Text('Exit App'),
              onTap: (){
                SystemNavigator.pop();
              },
              )
          ],
        ),
      ),
    );
  }
}