import 'package:environ/screens/camera/camera.dart';
import 'package:environ/screens/lessons/lessons.dart';
import 'package:environ/shared/components/pop_up_dialog.dart';
import 'package:environ/screens/statistics/stats.dart';
import 'package:environ/shared/constants.dart';
import 'package:environ/screens/home/trash_modal.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:math';
import '../../services/auth.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthService _auth = AuthService();

  Map<String, dynamic>? trashData;

  // callback for camera, sets new state of trashData
  void updateTrashdata(Map<String, dynamic> data) {
    setState(() {
      trashData = data;
    });
    _showTrashModal();
  }

  final PageController _controller = PageController(initialPage: 0);
  int _currentPage = 0;

  // flexible callback for children to navigate to another page
  void changePage(int index) {
    setState(() {
      _currentPage = index;
      _controller.animateToPage(
        index,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
      );
    });
  }

  void _showTrashModal() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return TrashModal(
          data: trashData,
        );
      },
    );
  }

  Future<void> _showHelpDialog() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          insetPadding:
              const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
          child: PopUpDialog(
            bodyWidget: Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'How to scan items',
                    style: Theme.of(context)
                        .textTheme
                        .headline6!
                        .copyWith(color: black),
                  ),
                ),
                const SizedBox(height: 16.0),
                const Text(
                  'Place the item you want to scan on a surface with a quiet background.',
                  style: TextStyle(color: black),
                ),
                const SizedBox(height: 12.0),
                const Text(
                  "The AI works best when the object is against a white background and place in the center.",
                  style: TextStyle(color: black),
                ),
                const SizedBox(height: 12.0),
                const Text(
                  "Keep in mind that the AI is not perfect. It's meant to be an indicator and to assist in identification, not to make the final judgement.",
                  style: TextStyle(color: black),
                ),
                const SizedBox(height: 8.0),
                Align(
                  alignment: Alignment.bottomRight,
                  child: TextButton(
                    child: const Text(
                      'Close',
                      style: linkButtonStyle,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: themeGreen,
      appBar: AppBar(
        title: Text("Environ", style: Theme.of(context).textTheme.headline5),
        backgroundColor: themeDarkGreen,
        brightness: Brightness.dark,
        elevation: 8.0,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.help),
            onPressed: () => _showHelpDialog(),
          ),
          IconButton(
            icon: const Icon(Icons.fact_check_outlined),
            onPressed: () => _showTrashModal(),
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await _auth.signOut();
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Stack(
              children: [
                Transform(
                  transform: Matrix4.rotationZ(pi / 12.0)..scale(2.0),
                  alignment: Alignment.center,
                  child: SvgPicture.asset(
                    "assets/leavesbg.svg",
                    color: const Color.fromRGBO(0, 0, 0, 0.1),
                  ),
                ),
                PageView(
                  controller: _controller,
                  onPageChanged: (index) {
                    setState(() {
                      _currentPage = index;
                    });
                  },

                  // main pages
                  children: <Widget>[
                    Camera(
                      changeData: updateTrashdata,
                    ),
                    const Lessons(),
                    const Stats(),
                  ],
                ),
              ],
            ),
          ),

          // bottom app bar
          Container(
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(width: 2.0, color: Colors.white),
              ),
              color: themeDarkGreen,
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 8,
            ),
            child: GNav(
              rippleColor: Colors.white24,
              selectedIndex: _currentPage,
              tabBorderRadius: 50,
              gap: 4,
              duration: const Duration(milliseconds: 500),
              color: Colors.white60,
              activeColor: Colors.white,
              iconSize: 28,
              tabBackgroundColor: Colors.white24,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              onTabChange: (tab) {
                setState(() {
                  _controller.animateToPage(
                    tab,
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.easeOut,
                  );
                });
              },
              tabs: const [
                GButton(
                  icon: Icons.camera_alt_rounded,
                  text: 'Scan',
                ),
                GButton(
                  icon: Icons.school_rounded,
                  text: 'Lessons',
                ),
                GButton(
                  icon: Icons.insights_rounded,
                  text: 'Statistics',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
