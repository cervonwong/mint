/*
 * Copyright (C) 2021 Cervon Wong and Lee I-Shiang
 */

import 'dart:typed_data';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mint/main/ui/utils/layout_controller.dart';
import 'package:provider/provider.dart';

import 'main/di/injection_container.dart' as injection_container;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  injection_container.configureDependencies();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LayoutControllerProviderWrapper(),
    );
  }
}

class LayoutControllerProviderWrapper extends StatelessWidget {
  LayoutControllerProviderWrapper({Key? key}) : super(key: key);

  final layoutController = GetIt.instance<LayoutController>();

  @override
  Widget build(BuildContext context) {
    layoutController.updateWidth(MediaQuery.of(context).size.width);

    return ChangeNotifierProvider(
      create: (_) {
        return layoutController;
      },
      child: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  final FirebaseStorage storage = FirebaseStorage.instance;
  Uint8List? imageBytes;
  String? errorMsg;

  _MyHomePageState() {
    storage
        .ref()
        .child('crabthink.png')
        .getData(10000000)
        .then((data) => setState(() {
              imageBytes = data;
            }))
        .catchError((e) => setState(() {
              errorMsg = e.error;
            }));
  }

  @override
  Widget build(BuildContext context) {
    var img = imageBytes != null
        ? Image.memory(
            imageBytes!,
            fit: BoxFit.cover,
          )
        : Text(errorMsg != null ? errorMsg! : 'Loading...');

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '${Provider.of<LayoutController>(context).breakpoint} $_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
            img,
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
