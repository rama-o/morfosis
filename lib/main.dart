import 'package:flutter/material.dart';

void main() {
  runApp( MorfosisApp() );
}

class MorfosisApp extends StatelessWidget {
  const MorfosisApp({super.key});

  static const Color bgColor = Color(0xff364245);
  static const Color actionColor = Color(0xff467f68);
  static const Color dangerColor = Color(0xffff8080);
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: bgColor,

        appBar: AppBar(
          backgroundColor: bgColor,
          title: const Text('Queue'),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.add),
              tooltip: 'Add Files',
              color: actionColor,
              onPressed: (){},
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              tooltip: 'Delete Files',
              color: dangerColor,
              onPressed: (){},
            ),
          ]


        ),
        body: Column(
          children: const [
            Text('ffmpeg -i * -o *'),
            Text('warning'),
            Text('scrollablearea'),
          ]
        ),

        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.list),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Settings',
            ),
        ]),
      )
    );
  }
}