import 'package:flutter/material.dart';

void main() {
  runApp(const MorfosisApp());
}

const Color bgColor = Color(0xff364245);
const Color bgColor2 = Color(0xff364852);
const Color actionColor = Color(0xff467f68);
const Color dangerColor = Color(0xffff8080);
const Color foregroundColor = Color(0xffcccccc);

class CodeInput extends StatelessWidget {
  final String output;

  const CodeInput({super.key, required this.output});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Color(0xff242b2f),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(output, style: TextStyle(color: Color(0xffffe23e))),
    );
  }
}

class PromptOutput extends StatelessWidget {
  final String output;

  const PromptOutput({super.key, required this.output});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Color(0xff382929),
        border: Border.all(color: Color(0xffa13030)),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(output, style: TextStyle(color: Color(0xffffa5aa))),
    );
  }
}

class ListItem extends StatelessWidget {
  final int id;
  final String path;
  final String output;

  const ListItem({
    super.key,
    required this.id,
    required this.path,
    required this.output,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: bgColor2,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(path, style: TextStyle(color: foregroundColor, fontSize: 22)),
          const SizedBox(height: 8), // instead of spacing
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xff4b7076),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text('100%', style: TextStyle(color: foregroundColor)),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 12, 141, 141),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text('avi', style: TextStyle(color: foregroundColor)),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xff1279b1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(output, style: TextStyle(color: foregroundColor)),
              ),
              const SizedBox(width: 8),
              Container(
                decoration: BoxDecoration(
                  color: dangerColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: IconButton(
                  icon: const Icon(Icons.delete),
                  tooltip: 'Delete Item',
                  color: foregroundColor,
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class MorfosisApp extends StatefulWidget {
  const MorfosisApp({super.key});

  @override
  State<MorfosisApp> createState() => _MorfosisAppState();
}

class _MorfosisAppState extends State<MorfosisApp> {
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

                  CodeInput(output: 'ffmpeg -i * -o *'),
                  PromptOutput(output: 'error'),

                  ListItem(
                    path: 'cumpleaños alejando.avi',
                    id: 4,
                    output: 'mp4',
                  ),
                ],
              ),
            ),

            // Settings Page
            SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    child: Text(
                      'Settings',
                      style: TextStyle(color: foregroundColor, fontSize: 28),
                    ),
                  ),

                  CodeInput(output: 'ffmpeg -i * -o *'),
                  PromptOutput(output: 'error'),
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
