import 'package:brewcrew/screens/camera/camera.dart';
import 'package:brewcrew/screens/home/dashboard.dart';
import 'package:brewcrew/screens/home/settings_form.dart';
import 'package:brewcrew/shared/constants.dart';
import 'package:brewcrew/shared/loading.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:flutter/material.dart';
import '../../services/auth.dart';
import 'package:camera/camera.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthService _auth = AuthService();

  final PageController _controller = PageController(initialPage: 0);
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    void _showSettingsPanel() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
                padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 8.0),
                child: SettingsForm());
          });
    }

    final cameras = availableCameras();

    return Scaffold(
      backgroundColor: themeGreen,
      appBar: AppBar(
        title: Icon(Icons.emoji_food_beverage),
        backgroundColor: themeDarkGreen,
        elevation: 8.0,
        toolbarHeight: 64,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () => _showSettingsPanel(),
          ),
          IconButton(
            icon: Icon(Icons.logout),
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
            child: PageView(
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              controller: _controller,
              children: <Widget>[
                Dashboard(),
                FutureBuilder(
                  future: cameras,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return TakePictureScreen(
                        camera: snapshot.data.first,
                      );
                    } else {
                      return Loading();
                    }
                  },
                ),

              ],
            ),
          ),
          Container(
            color: themeDarkGreen,
            padding: EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 8,
            ),
            child: GNav(
              rippleColor: Colors.white24,
              selectedIndex: _currentPage,
              tabBorderRadius: 50,
              gap: 4,
              duration: Duration(milliseconds: 500),
              color: Colors.white60,
              activeColor: Colors.white,
              iconSize: 24,
              tabBackgroundColor: Colors.white24,
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              onTabChange: (tab) {
                setState(() {
                  _controller.animateToPage(
                    tab,
                    duration: Duration(milliseconds: 200),
                    curve: Curves.easeOutExpo,
                  );
                });
              },
              tabs: [
                GButton(
                  icon: Icons.home_rounded,
                  text: 'Home',
                ),
                GButton(
                  icon: Icons.camera_alt_rounded,
                  text: 'Camera',
                ),
                GButton(
                  icon: Icons.school_rounded,
                  text: 'Learn',
                ),
                GButton(
                  icon: Icons.insights_rounded,
                  text: 'Stats',
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
