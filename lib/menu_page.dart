import 'package:satsangreader/circular_image.dart';
import 'package:satsangreader/zoom_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MenuScreen extends StatelessWidget {
  final String imageUrl =
      "https://celebritypets.net/wp-content/uploads/2016/12/Adriana-Lima.jpg";

  final List<MenuItem> options = [
    // MenuItem(Icons.search, 'Search'),
    MenuItem(Icons.file_download, 'Download'),
  ];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: (details) {
        //on swiping left
        if (details.delta.dx < -2) {
          Provider.of<MenuController>(context, listen: true).toggle();
        }
      },
      child: Container(
        padding: EdgeInsets.only(
            top: 94,
            left: 32,
            bottom: 8,
            right: MediaQuery.of(context).size.width / 2.9),
        color: Colors.white,
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: Icon(Icons.library_books),
                ),
                Text(
                  'Satsang Reader',
                  style: TextStyle(
                    color: Color(0xff4d0e0a),
                    fontSize: 20,
                  ),
                )
              ],
            ),
            Divider(),
            Column(
              children: options.map((item) {
                return ListTile(
                  leading: Icon(
                    item.icon,
                    color: Color(0xff4d0e0a),
                    size: 20,
                  ),
                  title: Text(
                    item.title,
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff4d0e0a)),
                  ),
                );
              }).toList(),
            ),
            ListTile(
              onTap: () {},
              leading: Icon(
                Icons.info,
                color: Color(0xff4d0e0a),
                size: 20,
              ),
              title: Text('About',
                  style: TextStyle(fontSize: 14, color:Color(0xff4d0e0a))),
            ),
            ListTile(
              onTap: () {},
              leading: Icon(
                Icons.arrow_downward,
                color: Color(0xff4d0e0a),
                size: 20,
              ),
              title: Text('Logout',
                  style: TextStyle(fontSize: 14, color: Color(0xff4d0e0a))),
            ),
          ],
        ),
      ),
    );
  }
}

class MenuItem {
  String title;
  IconData icon;

  MenuItem(this.icon, this.title);
}
