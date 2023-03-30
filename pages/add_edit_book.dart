import 'package:final_project/pages/book_list.dart';
import 'package:flutter/material.dart';

import '../Models/book.dart';

class AddEditBook extends StatefulWidget {
  late String title;
  static String routeName = "/AddEditBook";
  Book? books;
  AddEditBook({Key? key, Book? theBook}) : super(key: key) {
    if (theBook == null) {
      title = "Add Book";
      books = Book.getNew();
    } else {
      title = "Edit Book";
      books = theBook;
    }
  }

  @override
  State<AddEditBook> createState() => _AddEditBookState();
}

class _AddEditBookState extends State<AddEditBook> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  
  
  @override
  Widget build(BuildContext context) {

    late int bookId;
    late String bookTitle;
    late double bookPrice;
    late bool bookBorrowed;
    late BookStatus bookStatus;
    bool isChecked = false;
    //String data = "AddEditPage";

    final args = ModalRoute.of(context)!.settings.arguments as Book?;
    if (args == null) {
      widget.title = 'Add Employee';
      widget.books = Book.getNew();
    } else {
      widget.title = 'Edit Employee';
      widget.books = args;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [

                  TextFormField(
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(15),
                        ),
                      ),
                      labelText: "Book ID",
                      hintText: "Enter Book ID",
                      helperText: "*Required",
                      prefixIcon: Icon(Icons.numbers),
                    ),
                    validator: (newValue) {
                      int? id = int.tryParse(newValue!) ?? 0;
                        if (id < 1001 || id > 5000) {
                          return "Book ID Must Be Between 1001 And 5000";
                        }
                        return null;
                    },
                    onSaved: (newValue) {
                      bookId = int.tryParse(newValue!) ?? 0;
                    },
                  ),

                  TextFormField(
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(15),
                        ),
                      ),
                      labelText: "Title",
                      hintText: "Enter Book Title",
                      helperText: "*Required",
                      prefixIcon: Icon(Icons.book_rounded),
                    ),
                    validator: (newValue) {
                      if (newValue == null ||
                            newValue.isEmpty ||
                            newValue.trim().length < 3) {
                          return "Book Title Is Required";
                        }
                        return null;
                    },
                    onSaved: (newValue) {
                      bookTitle = newValue!;
                    },
                  ),

                  TextFormField(
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(15),
                        ),
                      ),
                      labelText: "Price",
                      hintText: "Enter Book Price",
                      helperText: "*Required",
                      prefixIcon: Icon(Icons.attach_money_rounded),
                    ),
                    validator: (newValue) {
                      double? price = double.tryParse(newValue!) ?? 0;
                        if (price < 5 || price > 100) {
                          return r"Price Must Be Between $5 And $100";
                        }
                        return null;
                    },
                    onSaved: (newValue) {
                      bookPrice = double.tryParse(newValue!) ?? 0;
                    },
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Checkbox(
                        value: isChecked,
                        onChanged: (bool? val) {
                          setState(() => isChecked = val!);
                        },
                      ),
                      const Text('Is Borrowed'),
                    ],
                  ),

                  DropdownButtonFormField<BookStatus>(
                value: BookStatus.notSelected,
                items: const [
                  DropdownMenuItem(value: BookStatus.notSelected, child: Text("Select Book Status")),
                  DropdownMenuItem(value: BookStatus.available, child: Text("Available")),
                  DropdownMenuItem(value: BookStatus.outOfStock, child: Text("Out Of Stock")),
                ],
                validator: (newValue) {
                  newValue = newValue ?? BookStatus.notSelected;
                  if (newValue == BookStatus.notSelected) {
                    return "You Should Select A Search Type";
                  }
                  return null;
                },
                onChanged: (newValue) {
                  setState(() {
                    if (newValue != BookStatus.notSelected) {
                      bookStatus = newValue!;
                    }
                  });
                },
                onSaved: (newValue) {
                  bookStatus = newValue!;
                },
                
              ),

                  // TextFormField(
                  //   decoration: const InputDecoration(
                  //     enabledBorder: OutlineInputBorder(
                  //       borderRadius: BorderRadius.all(
                  //         Radius.circular(15),
                  //       ),
                  //     ),
                  //     labelText: "Is Borrowed",
                  //     hintText: "Is Book Borrowed ??",
                  //     helperText: "*Required",
                  //     prefixIcon: Icon(Icons.question_mark_rounded),
                  //   ),
                  // ),

                  // TextFormField(
                  //   decoration: const InputDecoration(
                  //     enabledBorder: OutlineInputBorder(
                  //       borderRadius: BorderRadius.all(
                  //         Radius.circular(15),
                  //       ),
                  //     ),
                  //     labelText: "Book Status",
                  //     hintText: "Is Book Availble",
                  //     helperText: "*Required",
                  //     prefixIcon: Icon(Icons.question_mark_rounded),
                  //   ),
                  // ),

                  ElevatedButton(
                  onPressed: () {
                    setState(() {
                      if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          Navigator.pop(context, args);
                          //_addNewBook(context);
                        } else {
                          _formKey.currentState!.reset();
                        }
                    });
                  }, 
                  child: const Icon(Icons.save))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  

  // void _addNewBook(BuildContext context) async {
  //   final result = await Navigator.popAndPushNamed(
  //     context,
  //     AddEditBook.routeName,
  //     arguments: Book.getNew(),
  //   );
  //   setState(() {
  //     //Employee employee = result as Employee;
  //     data = "${(result as Book).title} was added successfully";
  //   });
  // }
  
}
