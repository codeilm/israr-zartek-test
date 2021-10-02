import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  final IconData iconData;
  final String title;
  final Function onTap;
  final Color color;
  CustomListTile(
      {@required this.title,
      @required this.iconData,
      @required this.onTap,
      @required this.color});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 0.0),
      child: InkWell(
        splashColor: Colors.deepOrangeAccent,
        onTap: onTap,
        child: Container(
          height: 50.0,
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              children: <Widget>[
                Icon(
                  iconData,
                  color: color,
                ),
                SizedBox(width: 16.0),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
