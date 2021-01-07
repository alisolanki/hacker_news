import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../home_page.dart';

class DrawerItems extends StatefulWidget {
  @override
  _DrawerItemsState createState() => _DrawerItemsState();
}

class _DrawerItemsState extends State<DrawerItems> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Colors.black54,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              onDetailsPressed: null,
              currentAccountPicture: CircleAvatar(
                child: Image.asset("assets/user.png"),
              ),
              accountName: Text(
                "My Account",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              accountEmail: Text(
                "${FirebaseAuth.instance.currentUser.phoneNumber}",
                style: TextStyle(
                  color: Colors.orange,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home, color: Colors.orange),
              title: Text(
                'Home',
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.list, color: Colors.orange),
              title: Text(
                'Categories',
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return HomePage();
                    },
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.info, color: Colors.orange),
              title: Text(
                'About Us',
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return AboutDialog(
                        applicationName: 'Hacker News',
                        applicationVersion: '1.0.0',
                        children: <Widget>[
                          Divider(),
                          Text(
                            "For any problems, contact Ali Solanki at +91 88502-83085",
                          ),
                          Divider(),
                          Text(
                            "Developed by Ali Solanki (Contact: +91 88502-83085)",
                          ),
                          Divider(),
                        ],
                        applicationLegalese: "© AliSolanki 2020",
                      );
                    },
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app, color: Colors.orange),
              title: Text(
                'Log Out',
              ),
              onTap: () {
                Navigator.pop(context);
                FirebaseAuth.instance.signOut();
              },
            ),
          ],
        ),
      ),
    );
  }
}
