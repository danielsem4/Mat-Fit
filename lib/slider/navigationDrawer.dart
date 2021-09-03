import 'package:fit_app/authentication.dart';
import 'package:fit_app/slider/announcements.dart';
import 'package:fit_app/slider/myDiet.dart';
import 'package:fit_app/slider/myWorkOut.dart';
import 'package:flutter/material.dart';

class NavigationDrawerWidget extends StatelessWidget {
  final padding = EdgeInsets.symmetric(horizontal: 20);
  final AuthenticationService _auth = AuthenticationService();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        color: Color.fromRGBO(60, 140, 80, 1),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: <Widget>[
              const SizedBox(
                height: 16,
              ),
              buildMenuItem(
                text: 'My Diet',
                icon: Icons.restaurant,
                onClicked: () => selectedItem(context, 0),
              ),
              const SizedBox(
                height: 16,
              ),
              buildMenuItem(
                text: 'My Workout Plan',
                icon: Icons.assignment_rounded,
                onClicked: () => selectedItem(context, 1),
              ),
              const SizedBox(
                height: 16,
              ),
              buildMenuItem(
                text: 'Book a Training',
                icon: Icons.bookmark_add,
                onClicked: () => selectedItem(context, 2),
              ),
              const SizedBox(
                height: 16,
              ),
              buildMenuItem(
                text: 'Notifications',
                icon: Icons.notifications_active_outlined,
                onClicked: () => selectedItem(context, 3),
              ),
              const SizedBox(height: 24),
              Divider(color: Colors.white),
              const SizedBox(height: 24),
              buildMenuItem(
                text: 'Settings',
                icon: Icons.settings,
                onClicked: () => selectedItem(context, 4),
              ),
              buildMenuItem(
                text: 'Logout',
                icon: Icons.logout,
                onClicked: () => selectedItem(context, 5),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildMenuItem({
    String text,
    IconData icon,
    VoidCallback onClicked,
  }) {
    final color = Colors.white;

    return ListTile(
      leading: Icon(
        icon,
        color: color,
      ),
      title: Text(
        text,
        style: TextStyle(color: color),
      ),
      onTap: onClicked,
    );
  }

  void selectedItem(BuildContext context, int index) {
    Navigator.of(context).pop();

    switch (index) {
      case 0:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => MyDietPage()));
        break;
      case 1:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => MyWorkoutPlan()));
        break;
      case 3:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Announcements()));
        break;

      case 5:
        logOut();
        break;
    }
  }

  void logOut() async {
    await _auth.signOut();
  }
}
