import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

class MyExample extends StatefulWidget {
  @override
  _MyExampleState createState() => _MyExampleState();
}

class _MyExampleState extends State<MyExample> {
  @override
  void didChangeDependencies() {
    print("didchange");
    super.didChangeDependencies();
  }

  @override
  void initState() {
    const JsonDecoder();
    print("init");
    super.initState();
  }

  @override
  void dispose() {
    print('dispose');
    super.dispose();
  }

  @override
  void didUpdateWidget(MyExample oldWidget) {
    print('update');
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    print('build');
    return  Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.ac_unit),
            onPressed: () {
              exit(0);
            }),
      ),
    );
  }
}
