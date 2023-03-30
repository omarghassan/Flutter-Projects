import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  static const String routeName = '/HomePage';
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onChanged: null,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(15, 20, 15, 20),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 15),
              child: Image(
                image: AssetImage('images/asulibrary.png'),
                width: 250,
                height: 250,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 25),
              child: TextFormField(
                  decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(),
                      labelText: 'User ID',
                      hintText: 'Enter your User ID',
                      //helperText: '*Required',
                      prefixIcon: Icon(Icons.account_circle_outlined)),
                  validator: null),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: TextFormField(
                  decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(),
                    labelText: 'Password',
                    hintText: 'Enter your Password',
                    //helperText: '*Required',
                    prefixIcon: Icon(Icons.password_rounded),
                  ),
                  validator: null),
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Submission done!'),
                    ),
                  );
                } else {
                  _formKey.currentState!.reset();
                }

                Navigator.pushNamed(context, "ListPage");
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.transparent),
                elevation: MaterialStateProperty.all(0),
                textStyle: MaterialStateProperty.all(
                  const TextStyle(
                      fontFamily: "Times New Roman",
                      fontSize: 23,
                      fontWeight: FontWeight.bold),
                ),
                //padding: MaterialStateProperty.all(EdgeInsets.only(left: 30,right: 30)),
              ),
              child: const Text(
                'Login',
                style: TextStyle(
                  color: Color.fromARGB(255, 14, 60, 82),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
