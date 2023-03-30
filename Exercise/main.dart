
import 'package:flutter/material.dart';
void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const MyWidgets(),
      debugShowCheckedModeBanner: false,
    );
  }
}
class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: const [
              MyWidgets(),
              //Dropdownbutton1(),
            ],
          ),
        ),
      ),
    );
  }
}
class MyWidgets extends StatefulWidget {
  const MyWidgets({Key? key}) : super(key: key);
  @override
  State<MyWidgets> createState() => _MyWidgetsState();
}
enum ePizza{Large,Small}
//enum eType{Veggie,Margherita}
class _MyWidgetsState extends State<MyWidgets> {
  double _value = 0;
  MaterialColor _color = Colors.red;
  double price=0;
  ePizza _groupValue=ePizza.Large;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(title:const Text('Question'),),
        body: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Column(children: [
           const Text('.::Pizza Order App::.',style: TextStyle(fontSize: 25,color:Colors.green),),
           Row(
            mainAxisAlignment: MainAxisAlignment.center,
             children: [
                DropdownButton<double>(
              items: const [
                DropdownMenuItem(child: Text('Select Pizza type'), value: 0),
                DropdownMenuItem(child: Text('Veggie Pizza'), value: 1.5),
                DropdownMenuItem(child: Text('Margherita Pizza'), value: 2.5),
              ],
              value: _value,
              onChanged: (newValue) => setState(() {
                    _value = newValue!;
                  },)),
            ],
           ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Radio<ePizza>(
                  value: ePizza.Large,
                  groupValue: _groupValue, 
                  onChanged: (newValue) => onPizzasizeChanged(newValue),
                  ),
                  const Text('Large Pizza'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Radio<ePizza>(
                  value: ePizza.Small, 
                  groupValue: _groupValue,
                  onChanged: (newValue) => onPizzasizeChanged(newValue),
                  ),
                  const Text('Small Pizza'),
              ],
            ),
            Text('Total Price:JD $price ',style: const TextStyle(color: Colors.green,fontSize: 20),),
            Image(image: NetworkImage('https://d2j6dbq0eux0bg.cloudfront.net/images/67176897/2709743939.jpg')),
            //Image(image: NetworkImage('https://stonepizzas.com/wp-content/uploads/2016/10/veg_small.png'))
          ]),
        ),
    );
  }
  onPizzasizeChanged(ePizza? newValue) {
    setState(() {
      _groupValue=newValue!;
      if(newValue==ePizza.Small)
      {
       if(_value==1.5)
       {
        price=1.5+2.5;
       }
       else
       {
        price=1.5+1.5;
       }
      }
      else
      {
        if(_value==2.5)
       {
        price=2.5+2.5;
       }
       else
       {
        price=2.5+1.5;
       }
      }
    });
  }
  onPizzatypeChanged(Object? newValue) {
    setState(() {
      if(newValue==1.5)
      {
        const Image(image: NetworkImage('https://d2j6dbq0eux0bg.cloudfront.net/images/67176897/2709743939.jpg'));
      }
      else
      {
        const Image(image: NetworkImage('https://stonepizzas.com/wp-content/uploads/2016/10/veg_small.png'));
      }
    });
  }
}
