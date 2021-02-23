import 'package:flutter/material.dart';

import 'package:drop_zone/drop_zone.dart';
import 'dart:html' as html;

void main() {
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
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String dropzoneState = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            DropZone(
              onDragEnter: () {
                print('drag enter');
                setState(() {
                  dropzoneState = 'drag enter';
                });
              },
              onDragExit: () {
                print('drag exit');
                setState(() {
                  dropzoneState = 'drag exit';
                });
              },
              onDrop: (List<html.File> files) {
                print('files dropped');
                print(files);
                setState(() {
                  dropzoneState = 'files dropped $files';
                });
              },
              child: Container(
                decoration: BoxDecoration(border: Border.all()),
                width: 300,
                height: 300,
              ),
            ),
            Text(dropzoneState),
          ],
        ),
      ),
    );
  }
}
