import 'package:flutter/material.dart';
import 'list_page.dart';

class Add extends StatefulWidget {
  final String title;
  static const String routeName ='/add';

  const Add({ Key? key, required this.title }) : super(key: key);

  @override
  State<Add> createState() => _AddState();
}

class _AddState extends State<Add> {
  
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final Student student = Student ();

  @override
  Widget build(BuildContext context) {
    //final Student student =
    //   ModalRoute.of(context)!.settings.arguments as Student;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Center(
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: TextFormField(
                      onChanged: (value) {
                        student.name;
                      },
                      initialValue: student.name,
                      keyboardType: TextInputType.name,
                      decoration: const InputDecoration(
                        labelText: 'Name',
                        helperText: '* Required',
                        enabledBorder: OutlineInputBorder(),
                        prefixIcon: Icon(
                          Icons.account_circle,
                          color: Colors.black,
                          size: 30,),
                      ),
                      validator: (newValue) {
                        if (newValue!.isEmpty || newValue.trim().length < 3) {
                          return 'Name is required, and it should be 3 characters at least!';
                        }
                        return null;
                      },
                      onSaved: (newValue) {
                        student.name = newValue!;
                        //newStudentName(newValue!);// = newValue!;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: TextFormField(
                      onChanged: (value) {
                        student.gpa;
                      },
                      initialValue: student.gpa.toString(),
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'GPA',
                        helperText: '* Required',
                        enabledBorder: OutlineInputBorder(),
                        prefixIcon: Icon(
                          Icons.calculate,
                          color: Colors.black,
                          size: 30,),
                      ),
                      validator: (newValue) {
                        double value = double.tryParse(newValue!)?? 0; 
                        if (value < 35 || value > 100 ) {
                          return 'GPA should be bigger than 35 and less than 100 ';
                        }
                        return null;
                      },
                      onSaved: (newValue) {
                        double value = double.tryParse(newValue!)?? 0;
                        student.gpa = value.toInt();
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: TextFormField(
                      onChanged: (value) {
                        student.age;
                      },
                      initialValue: student.age.toString(),
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Age',
                        helperText: '* Required',
                        enabledBorder: OutlineInputBorder(),
                        prefixIcon: Icon(
                          Icons.date_range,
                          color: Colors.black,
                          size: 30,),
                      ),
                      validator: (newValue) {
                        double value = double.tryParse(newValue!)?? 0; 
                        if (value < 18 || value > 40 ) {
                          return 'Age should be bigger than 18 and less than 40 ';
                        }
                        return null;
                      },
                      onSaved: (newValue) {
                        double value = double.tryParse(newValue!)?? 0;
                        student.age = value.toDouble();
                      },
                    ),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          studentsList.add(student);
                          if(student.gpa % 2 == 0){
                            student.imageUrl= 'images/student1.jpg'; 
                          }
                          else {
                            student.imageUrl = 'images/student2.png'; 
                          }
                          Navigator.pop(context, student);
                        }
                      },
                      child: const Text('Save')
                      
                      ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
/*
  void newStudentName(String newName){
    String newName1;
    newName1 = newName ; 
    


  }

  void _addNewStudent(Student student) {
    int i = widget._students.indexWhere((s) => s.id == student.id);
    if (i > -1) {
      int newGpa = 35 + Random().nextInt(100 - 35);
      int newId = widget._students.length + 1;
      String newUrl = newGpa % 2 == 0 ? "images/student1.jpg"  : "images/student2.png";
      Student s = Student(
        id: newId,
        name: 'Student $newId',
        gpa: newGpa,
        imageUrl: newUrl,
      );
      widget._students.insert(i, s);
    }
  }
  */
}
