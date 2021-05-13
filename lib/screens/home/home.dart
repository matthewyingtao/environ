import 'package:brewcrew/models/brew.dart';
import 'package:brewcrew/screens/home/settings_form.dart';
import 'package:brewcrew/shared/constants.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:flutter/material.dart';
import '../../services/database.dart';
import '../../services/auth.dart';
import 'package:provider/provider.dart';
import 'brew_list.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();

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

    return StreamProvider<List<Brew>>.value(
      value: DatabaseService().brews,
      child: Scaffold(
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
        body: Container(
          child: Column(
            children: [
              Spacer(),
              Container(
                color: themeDarkGreen,
                padding: EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 8,
                ),
                child: GNav(
                  rippleColor: Colors.white,
                  hoverColor: Colors.white,
                  tabBorderRadius: 50,
                  gap: 4,
                  duration: Duration(milliseconds: 500),
                  color: Colors.white60,
                  activeColor: Colors.white,
                  iconSize: 24,
                  tabBackgroundColor: Colors.white24,
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  tabs: [
                    GButton(
                      icon: Icons.home_rounded,
                      text: 'Home',
                    ),
                    GButton(
                      icon: Icons.directions_bus_rounded,
                      text: 'Travel',
                    ),
                    GButton(
                      icon: Icons.school_rounded,
                      text: 'School',
                    ),
                    GButton(
                      icon: Icons.insights_rounded,
                      text: 'Statistics',
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
