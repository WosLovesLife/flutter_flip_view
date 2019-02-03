import 'package:flutter/material.dart';
import 'simple_example.dart';
import 'custom_layout_example.dart';

void main() => runApp(MaterialApp(home: MyApp()));

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flip View'),
      ),
      body: ListView(children: <Widget>[
        ListTile(
          title: Text('Simple Example'),
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
              return SimpleExample();
            }));
          },
        ),
        ListTile(
          title: Text('Custom Layout Example'),
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
              return CustomLayoutExample();
            }));
          },
        )
      ]),
    );
  }
}
