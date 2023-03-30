
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'add.dart';
import 'edit.dart';
import 'home_page.dart';
import 'dart:math';

List<Student> studentsList = [];

 List<Student> gerateRandomData(int count){
      
      for(int i = 1; i <= count; i++)
      {
        int gpaRandom = 35 + Random().nextInt(100 - 35);
        double ageRandom = Random().nextDouble() * max(18,40);
        studentsList.add(
          Student(
            age: ageRandom,
            id: i,
            name: "Student $i", 
            gpa: gpaRandom,
            imageUrl: gpaRandom % 2 == 0 ? 'images/student1.jpg' : 'images/student2.png',
            ),
        );
      }

      return studentsList;
      
    }

class Student{
  int id;
  String name;
  int gpa;
  String imageUrl;
  double age;



  Student(
    {this.id = -1, this.name = "", this.gpa = 35, this.imageUrl = "", this.age=18}
    );

     static Student getDefaultStudent() {
    return Student(id: -1, name: '', gpa: 35,age: 18);
  }
}

class ListPage extends StatefulWidget {
  static const String title ='List Page';
  static const String routeName ='/listpage';
  //final Messenger messenger = Messenger(message: 'Hi :)');

  const ListPage({ Key? key}) : super(key: key);

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {

  @override
  void initState() {
    super.initState();
    gerateRandomData(5);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(ListPage.title),
      ),
      body: ListView.builder(
      itemCount: studentsList.length,
      itemExtent: 90,
      itemBuilder: _listItemBuilder,
         ),
          

          drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget> [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.red,
                image: DecorationImage(
                  image: AssetImage("images/drawerbackground.jpg"),
                     fit: BoxFit.cover)
                ),
              child: Text('Student List', 
              style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
            ListTile(
              title: const Text(HomePage.title),
              onTap: (){
                Navigator.pushNamed(context, HomePage.routeName);
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
      
          floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.add_reaction,color: Colors.white,size: 40,),
            backgroundColor: Colors.black,
            tooltip: 'Add',
            onPressed: (){
              _addStudent(context);
            },
            ),

            
            floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
  
          bottomNavigationBar: BottomAppBar(
            color: Colors.blue,
            child: Container(height: 50.0),
            ),

            
    );
  } 

  Widget _listItemBuilder(BuildContext context, int index) {
    Student student = studentsList[index];
    return Dismissible(
      child: _getStudentCard(context, index),
      key: UniqueKey(),
      onDismissed: (direction) {
        setState(() {
          if (direction == DismissDirection.startToEnd) {
            showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete'),
        content: Column(
          children: [
            const Text("Are you sure you want to delete?"),
            const Text(''),
            Text('Name:\t${student.name}'),
            const Text(''),
            const Text('Image:'),
            Image(
              image: AssetImage(student.imageUrl),
              fit: BoxFit.scaleDown,
            ),
          ],
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              _editStudent(context , student);
            },
            child: const Text('Edit'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context, false);
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              studentsList.remove(student);
              setState(() {
                
              });
            
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('${student.name} is dismissed!'),
              ),
            );
            Navigator.pop(context, true);
            },
            child: const Text('Yes'),
          ),
        ],
      ),
    );

          } 
          
          else if (direction == DismissDirection.endToStart) {
            if (index > 0) {
              studentsList.remove(student);
              studentsList.insert(index - 1, student);
            }
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Dismiss Direction is $direction!'),
              ),
            );
          }
        });
      },
    );
  }

  Widget _getStudentCard(BuildContext context, int index) {
    double newScale = 0;
    return GestureDetector(
      onScaleStart: (details) {
          newScale = 0;
      },
      onScaleUpdate: (details) {
        newScale = details.scale;
      },
      onScaleEnd: (details) {
        setState(() {
          if (newScale > 1) {
            _addNewStudent(studentsList[index]);
          }
        });
      },
      //onLongPress: () => _showDetails(context, student),
      onLongPress: () => _editStudent(context , studentsList[index]),
      child: Container(
        padding: const EdgeInsets.only(left: 15, right: 15,top: 5,bottom: 5),
        alignment: Alignment.centerLeft,
        child: Card(
          shadowColor: Colors.blue,
          elevation: 10,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
            side: BorderSide(color: Theme.of(context).colorScheme.primary),
          ),
          child: Row(
            children: [
              Image(
                image: AssetImage(studentsList[index].imageUrl),
                fit: BoxFit.scaleDown,
              ),
              Column(
                children: [
                  Text(
                    studentsList[index].name,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  Text(
                    'GPA: ${ studentsList[index].gpa}',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Text(
                    'Age: ${ studentsList[index]..age}',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  void _addNewStudent(Student student) {
    int i = studentsList.indexWhere((s) => s.id == student.id);
    if (i > -1) {
      int newGpa = 35 + Random().nextInt(100 - 35);
      double newAge = Random().nextDouble() * max(18, 40);
      int newId = studentsList.length + 1;
      String newUrl = newGpa % 2 == 0 ? "images/student1.jpg"  : "images/student2.png";
      Student s = Student(
        age: newAge,
        id: newId,
        name: 'Student $newId',
        gpa: newGpa,
        imageUrl: newUrl,
      );
      studentsList.insert(i, s);
    }
  }

  Future<void> _editStudent(BuildContext context , Student student) async {
  await Navigator.pushNamed(context, Edit.routeName,arguments: student);
  setState(() {
  });
  }

  Future<void> _addStudent(BuildContext context) async {
  await Navigator.pushNamed(context, Add.routeName);
  setState(() {
  });
  }

}

