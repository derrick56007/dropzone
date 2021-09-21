import 'package:drop_zone/drop_zone.dart';
import 'package:flutter/material.dart';

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
  String dropzoneState2 = '';

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
              onDrop: (files, offset) {
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
            DropZone(
              onDragEnter: () {
                print('drag enter');
                setState(() {
                  dropzoneState2 = 'drag enter';
                });
              },
              onDragExit: () {
                print('drag exit');
                setState(() {
                  dropzoneState2 = 'drag exit';
                });
              },
              onDrop: (files, offset) {
                print('files dropped');
                print(files);
                setState(() {
                  dropzoneState2 = 'files dropped $files';
                });
              },
              child: Container(
                decoration: BoxDecoration(border: Border.all()),
                width: 300,
                height: 300,
              ),
            ),
            Text(dropzoneState2),
          ],
        ),
      ),
    );
  }
}
