import 'package:flutter/material.dart';

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
      home: MyHomePage(title: 'Flutter Demo Home Page'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  late String _title;
  MyHomePage({Key? key, required String title}) : super(key: key) {
    setTitle = title;
  }

  set setTitle(String title) {
    _title = title;
  }

  get getTitle {
    return _title;
  }

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

enum ESearch { notSelected, web, books, images }

class _MyHomePageState extends State<MyHomePage> {
  late String searchString;
  late ESearch dropDownValue;
  late String dropDownValueAsString = "";
  bool _isChecked = false;
  late String checkBoxValue = "";
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  //late eSearch searchTypes;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Assignment 2"),
        backgroundColor: const Color.fromARGB(255, 255, 119, 0),
      ),
      body: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 20, 15, 8),
              child: DropdownButtonFormField<ESearch>(
                value: ESearch.notSelected,
                items: const [
                  DropdownMenuItem(
                      value: ESearch.notSelected,
                      child: Text("Select Your Search Type")),
                  DropdownMenuItem(value: ESearch.web, child: Text("Web")),
                  DropdownMenuItem(value: ESearch.books, child: Text("Books")),
                  DropdownMenuItem(value: ESearch.images, child: Text("Images")),
                ],
                validator: (newValue) {
                  newValue = newValue ?? ESearch.notSelected;
                  if (newValue == ESearch.notSelected) {
                    return "You Should Select A Search Type";
                  }
                  return null;
                },
                onChanged: (newValue) {
                  setState(() {
                    if (newValue != ESearch.notSelected) {
                      dropDownValue = newValue!;
                    }
                  });
                },
                onSaved: (newValue) {
                  dropDownValue = newValue!;
                  if (dropDownValue == ESearch.books) {
                    dropDownValueAsString = "Books";
                  } else if (dropDownValue == ESearch.web) {
                    dropDownValueAsString = "Web";
                  } else if (dropDownValue == ESearch.images) {
                    dropDownValueAsString = "Images";
                  }
                },
                
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 20, 15, 8),
              child: TextFormField(
                decoration: const InputDecoration(
                  enabledBorder: OutlineInputBorder(),
                  labelText: "Search",
                  hintText: "What you are searching for ??",
                  prefixIcon: Icon(Icons.search_rounded),
                ),
                validator: (newValue) {
                  if (newValue!.isEmpty || newValue.trim().length < 1) {
                    return "Search Can't Be Done.";
                  }
                  return null;
                },
                onSaved: (newValue) {
                  searchString = newValue!;
                },
              ),
            ),
            Row(
              children: [
                Checkbox(
                  value: _isChecked,
                  onChanged: (newValue) {
                    setState(() {
                      _isChecked = newValue!;
                      if (_isChecked == true) {
                        checkBoxValue = "Search Is Done Using Safe Search";
                      } else if (_isChecked == false) {
                        checkBoxValue =
                            "Search Is Done Without Using Safe Search";
                      }
                    });
                  },
                ),
                const Text("Safe Search"),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  showDialog(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      content: Column(
                        children: [
                          Text("Search Type: $dropDownValueAsString"),
                          Text("Search String: $searchString"),
                          Text(checkBoxValue)
                        ],
                      ),
                    ),
                  );
                  //ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Search Done Successfully"),),);
                } else {
                  _formKey.currentState!.reset();
                }
              },
              child: const Icon(Icons.screen_search_desktop_sharp),
            ),
          ],
        ),
      ),
    );
  }
}
