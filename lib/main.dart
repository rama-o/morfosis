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
  static const Color bgColor2 = Color(0xff364852);
  static const Color actionColor = Color(0xff467f68);
  static const Color dangerColor = Color(0xffff8080);
  static const Color foregroundColor = Color(0xffcccccc);

  final PageController _pageController = PageController();
  int _currentIndex = 0;

  void _onNavTapped(int index) {
    setState(() => _currentIndex = index);
    _pageController.jumpToPage(index); // animateToPage for smooth animation
  }

  void addFiles() {}
  void convertFiles() {}
  void clearQueue() {}
  void deleteItem() {}

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
                    child: Row(
                      spacing: 8,
                      children: [
                        Expanded(
                          child: Text(
                            'Queue',
                            style: TextStyle(
                              color: foregroundColor,
                              fontSize: 28,
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 150, 56, 187),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: IconButton(
                            icon: const Icon(Icons.swap_horiz),
                            tooltip: 'Convert Files',
                            color: foregroundColor,
                            onPressed: addFiles,
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: actionColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: IconButton(
                            icon: const Icon(Icons.add),
                            tooltip: 'Add Files',
                            color: foregroundColor,
                            onPressed: addFiles,
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: dangerColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: IconButton(
                            icon: const Icon(Icons.delete),
                            tooltip: 'Clear Queue',
                            color: foregroundColor,
                            onPressed: clearQueue,
                          ),
                        ),
                      ],
                    ),
                  ),

                  Container(
                    padding: const EdgeInsets.all(16),
                    width: double.infinity,
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      color: Color(0xff242b2f),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      'ffmpeg -i * -o *',
                      style: TextStyle(color: Color(0xffffe23e)),
                    ),
                  ),

                  Container(
                    padding: const EdgeInsets.all(16),
                    width: double.infinity,
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      color: Color(0xff382929),
                      border: Border.all(color: Color(0xffa13030)),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      'Some warning here',
                      style: TextStyle(color: Color(0xffffa5aa)),
                    ),
                  ),

                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: bgColor2,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      spacing: 8,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Long File Name',
                          style: TextStyle(
                            color: foregroundColor,
                            fontSize: 22,
                          ),
                        ),
                        Row(
                          spacing: 8,
                          children: [
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Color(0xff4b7076),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  '100%',
                                  style: TextStyle(
                                    color: foregroundColor,
                                    // fontSize: 22,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 12, 141, 141),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                'avi',
                                style: TextStyle(
                                  color: foregroundColor,
                                  // fontSize: 22,
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Color(0xff1279b1),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                'mp4',
                                style: TextStyle(
                                  color: foregroundColor,
                                  // fontSize: 22,
                                ),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: dangerColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: IconButton(
                                icon: const Icon(Icons.delete),
                                tooltip: 'Delete Item',
                                color: foregroundColor,
                                onPressed: deleteItem,
                              ),
                            ),
                          ],
                        ),
                      ],
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
