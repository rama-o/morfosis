import 'package:flutter/material.dart';

void main() {
  runApp(const MorfosisApp());
}

class MorfosisApp extends StatefulWidget {
  const MorfosisApp({super.key});

  @override
  State<MorfosisApp> createState() => _MorfosisAppState();
}

class _MorfosisAppState extends State<MorfosisApp> {
  static const Color bgColor = Color(0xff364245);
  static const Color actionColor = Color(0xff467f68);
  static const Color dangerColor = Color(0xffff8080);

  final PageController _pageController = PageController();
  int _currentIndex = 0;

  void _onNavTapped(int index) {
    setState(() => _currentIndex = index);
    _pageController.jumpToPage(index); // animateToPage for smooth animation
  }

  void addFiles() { }
  void convertFiles() { }
  void clearQueue() { }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: bgColor,
        body: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() => _currentIndex = index);
          },
          children: [
            // Queue Page
            SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    width: double.infinity,
                    child: 
                      Text(
                      'Queue',
                      style: TextStyle(color: Colors.white, fontSize: 28),
                    ),
                    // IconButton(
                    //   icon: const Icon(Icons.add),
                    //   tooltip: 'Add Files',
                    //   color: actionColor,
                    //   onPressed: addFiles(),
                    // ),
                    // IconButton(
                    //   icon: const Icon(Icons.delete),
                    //   tooltip: 'Clear Queue',
                    //   color: dangerColor,
                    //   onPressed: clearQueue(),
                    // ),
                  ),

                  Container(
                    color: Color(0xff242b2f),
                    padding: const EdgeInsets.all(16),
                    width: double.infinity,
                    margin: const EdgeInsets.only(bottom: 16),
                    child: Text(
                      'ffmpeg -i * -o *',
                      style: TextStyle(color: Color(0xffffe23e)),
                    ),
                  ),

                  Container(
                    color: Color(0xff382929),
                    padding: const EdgeInsets.all(16),
                    width: double.infinity,
                    margin: const EdgeInsets.only(bottom: 16),
                    child: Text(
                      'Some warning here',
                      style: TextStyle(color: Color(0xffffa5aa)),
                    ),
                  ),
                ],
              ),
            ),

            // Settings Page
            SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Settings',
                    style: TextStyle(color: Colors.white, fontSize: 22),
                  ),
                  SizedBox(height: 12),
                  Text(
                    'ffmpeg -i * -o *',
                    style: TextStyle(color: Colors.orange),
                  ),
                  SizedBox(height: 12),
                  Text('Change Format', style: TextStyle(color: Colors.white)),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          backgroundColor: Color(0xff268289),
          onTap: _onNavTapped,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Home'),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Settings',
              // style: TextStyle(color: Color(0xff364245))
            ),
          ],
        ),
      ),
    );
  }
}
