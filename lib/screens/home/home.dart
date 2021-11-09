import 'dart:math';

import 'package:environ/screens/camera/camera.dart';
import 'package:environ/screens/home/help_dialog.dart';
import 'package:environ/screens/home/trash_modal.dart';
import 'package:environ/screens/lessons/info.dart';
import 'package:environ/screens/statistics/stats.dart';
import 'package:environ/shared/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map<String, dynamic>? trashData;

  // callback for camera, sets new state of trashData
  void updateTrashdata(Map<String, dynamic> data) {
    setState(() {
      trashData = data;
    });
    _showTrashModal();
  }

  final PageController _controller = PageController();
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
      builder: (context) => TrashModal(
        data: trashData,
      ),
    );
  }

  void _showHelpDialog() => showDialog<void>(
        context: context,
        builder: (context) => Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          insetPadding:
              const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          child: const HelpDialog(),
        ),
      );

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: themeGreen,
        appBar: AppBar(
          title: SvgPicture.asset(
            'assets/leavesbg.svg',
            color: Colors.white,
            height: 36,
          ),
          backgroundColor: themeDarkGreen,
          systemOverlayStyle: SystemUiOverlayStyle.light,
          elevation: 8,
          actions: <Widget>[
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.help),
                  onPressed: _showHelpDialog,
                ),
                const Text("Help"),
              ],
            ),
            const SizedBox(
              width: 16,
            ),
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.fact_check_outlined),
                  onPressed: _showTrashModal,
                ),
                const Text("Recent"),
              ],
            ),
            const SizedBox(width: 12),
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
                      'assets/leavesbg.svg',
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
                      const Info(),
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
                  top: BorderSide(width: 2, color: Colors.white),
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
                color: Colors.white60,
                activeColor: Colors.white,
                iconSize: 28,
                tabBackgroundColor: Colors.white24,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
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
                    text: 'Info',
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
