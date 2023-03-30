import 'package:flutter/material.dart';
import '../Models/book.dart';

class AddBook extends StatefulWidget {
  late String title;
  static String routeName = '/addItem';
  Book? book;
  AddBook({Key? key}) : super(key: key);
  @override
  State<AddBook> createState() => _AddBookState();
}

enum BookState { available, notAvailable }

class _AddBookState extends State<AddBook> {
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final args = ModalRoute.of(context)!.settings.arguments as Book?;
    return Scaffold(
      appBar: AppBar(title: const Text('Add New Item')),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                children: [
                  TextFormField(
                    initialValue: widget.book!.id.toString(),
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(),
                      labelText: 'Id',
                      helperText: '*',
                      prefixIcon: Icon(Icons.numbers),
                    ),
                    keyboardType: TextInputType.number,
                    validator: (newValue) {
                      int id = int.tryParse(newValue!) ?? 0;
                      if (id <= 0) {
                        return "Id should be > 0";
                      }
                      return null;
                    },
                    onSaved: (newValue) {
                      widget.book!.id = int.tryParse(newValue!) ?? 0;
                    },
                  ),
                  TextFormField(
                    initialValue: widget.book!.title,
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(),
                      labelText: 'Title',
                      helperText: '*',
                      prefixIcon: Icon(Icons.title),
                    ),
                    keyboardType: TextInputType.name,
                    validator: (newValue) {
                      if (newValue!.isEmpty || newValue.trim().length < 3) {
                        return "name should be >= 3 chars";
                      }
                      return null;
                    },
                    onSaved: (newValue) {
                      widget.book!.title = newValue!;
                    },
                  ),
                  TextFormField(
                    initialValue: widget.book!.price.toString(),
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(),
                      labelText: 'Price',
                      helperText: '*',
                      prefixIcon: Icon(Icons.monetization_on),
                    ),
                    keyboardType: TextInputType.number,
                    validator: (newValue) {
                      double salary = double.tryParse(newValue!) ?? 0;
                      if (salary <= 0) {
                        return r"price should be greater than zero";
                      }
                      return null;
                    },
                    onSaved: (newValue) {
                      widget.book!.price = double.tryParse(newValue!) ?? 1;
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
                  DropdownButtonFormField<BookState>(
                    value: BookState.available,
                    items: const <DropdownMenuItem<BookState>>[
                      DropdownMenuItem<BookState>(
                        value: BookState.available,
                        child: Text('Available'),
                      ),
                      DropdownMenuItem<BookState>(
                        value: BookState.notAvailable,
                        child: Text('Not Available'),
                      ),
                    ],
                    onChanged: (BookState? val) {
                      setState(() => val);
                    },
                    onSaved: (BookState? initialValue) {},
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        formKey.currentState!.save();
                        Navigator.pop(context, args);
                      } else {
                        formKey.currentState!.reset();
                      }
                    },
                    child: const Text('Insert'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
