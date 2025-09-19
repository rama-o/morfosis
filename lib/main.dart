import 'package:flutter/material.dart';
import 'package:path/path.dart' as p;

void main() {
  runApp(const MorfosisApp());
}

const Color bgColor = Color(0xff364245);
const Color bgColor2 = Color(0xff364852);
const Color actionColor = Color(0xff467f68);
const Color dangerColor = Color(0xffff8080);
const Color foregroundColor = Color(0xffcccccc);

class SectionTitle extends StatelessWidget {
  final String label;

  const SectionTitle({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Text(label, style: TextStyle(color: foregroundColor, fontSize: 28));
  }
}

class CustomBtn extends StatelessWidget {
  final Icon glyph;
  final String tooltip;
  final Color bg;
  final Color fg;
  final VoidCallback action;

  const CustomBtn({
    super.key,
    required this.glyph,
    required this.tooltip,
    required this.bg,
    required this.fg,
    required this.action,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(10),
      ),
      child: IconButton(
        icon: glyph,
        tooltip: tooltip,
        color: fg,
        onPressed: action,
      ),
    );
  }
}

class CodeInput extends StatelessWidget {
  final String output;

  const CodeInput({super.key, required this.output});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      width: double.infinity,
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
    final String name = p.basenameWithoutExtension(path);
    final String inputFormat = p.extension(path).replaceFirst('.', '');

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: bgColor2,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        spacing: 8,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(name, style: TextStyle(color: foregroundColor, fontSize: 22)),
          Row(
            spacing: 8,
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xff4b7076),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    '100%',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: foregroundColor),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 12, 141, 141),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  inputFormat,
                  style: TextStyle(color: foregroundColor),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xff1279b1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(output, style: TextStyle(color: foregroundColor)),
              ),
              CustomBtn(
                glyph: const Icon(Icons.delete),
                tooltip: 'Delete Item',
                bg: dangerColor,
                fg: foregroundColor,
                action: () {},
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
    _pageController.jumpToPage(index);
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
            SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                spacing: 16,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    spacing: 8,
                    children: [
                      Expanded(child: SectionTitle(label: 'Queue')),
                      CustomBtn(
                        glyph: const Icon(Icons.add),
                        tooltip: 'Add Files',
                        bg: actionColor,
                        fg: foregroundColor,
                        action: addFiles,
                      ),
                      CustomBtn(
                        glyph: const Icon(Icons.cleaning_services),
                        tooltip: 'Clear Queue',
                        bg: dangerColor,
                        fg: foregroundColor,
                        action: clearQueue,
                      ),
                      CustomBtn(
                        glyph: const Icon(Icons.swap_horiz),
                        tooltip: 'Convert Files',
                        bg: Color.fromARGB(255, 150, 56, 187),
                        fg: foregroundColor,
                        action: convertFiles,
                      ),
                    ],
                  ),

                  CodeInput(output: 'ffmpeg -i * -o *'),
                  PromptOutput(output: 'error'),

                  ListItem(
                    path: 'cumpleaños alejando.wmv',
                    id: 4,
                    output: 'mp4',
                  ),
                ],
              ),
            ),

            SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                spacing: 16,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Row(
                      spacing: 8,
                      children: [
                        Expanded(child: SectionTitle(label: 'Settings')),
                        CustomBtn(
                          glyph: const Icon(Icons.autorenew),
                          tooltip: 'Reset Settings',
                          bg: dangerColor,
                          fg: foregroundColor,
                          action: clearQueue,
                        ),
                      ],
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
            ),
          ],
        ),
      ),
    );
  }
}
