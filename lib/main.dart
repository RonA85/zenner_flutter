import 'package:flutter/material.dart';
import 'package:zenner_flutter/di/service_locator.dart';
import 'package:zenner_flutter/ui/dialog/dialog_page.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Zenner App',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: DialogPage(username: "Ron"),
    );
  }
}