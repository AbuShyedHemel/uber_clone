import 'package:flutter/material.dart';
import 'package:uber_clone/utils/Divider.dart';

class NavigationBar extends StatefulWidget {
  @override
  _NavigationBArState createState() => _NavigationBArState();
}

class _NavigationBArState extends State<NavigationBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      width: 255.0,
      child: Drawer(
        child: ListView(
          children: [
            Container(
              height: 165.0,
              child: DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Row(
                  children: [
                    Image.asset(
                      "images/man.png",
                      height: 65.0,
                      width: 65.0,
                    ),
                    SizedBox(
                      width: 16.0,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Profile Name",
                          style: TextStyle(fontSize: 16.0),
                        ),
                        SizedBox(
                          height: 6.0,
                        ),
                        Text("Visit Profile"),
                      ],
                    )
                  ],
                ),
              ),
            ),
            DeviderWidget(),
            SizedBox(
              height: 6.0,
            ),
            ListTile(
              leading: Icon(Icons.history),
              title: Text(
                "History",
                style: TextStyle(fontSize: 15.0),
              ),
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text(
                "Visit Profile",
                style: TextStyle(fontSize: 15.0),
              ),
            ),
            ListTile(
              leading: Icon(Icons.info),
              title: Text(
                "About",
                style: TextStyle(fontSize: 15.0),
              ),
            )
          ],
        ),
      ),
    );
  }
}
