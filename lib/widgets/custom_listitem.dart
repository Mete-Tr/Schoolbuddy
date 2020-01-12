import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:x/provider/authProv.dart';

class CustomListitem extends StatefulWidget {
  //TODO: Add color!
  String teacher;
  String subject;
  String room;
  String tmpColor;
  String col;
  Color color;

  CustomListitem(
    this.subject,
    this.teacher,
    this.room,
    this.tmpColor,
  ) {
    col = '0xff' + tmpColor.replaceFirst('#', '');
    color = Color(int.parse(col));
  }

  @override
  _CustomListitemState createState() => _CustomListitemState();
}

class _CustomListitemState extends State<CustomListitem> {
  bool check = false;
  @override
  Widget build(BuildContext context) {
    // TODO: Design
    return Card(
      elevation: 8,
      child: Container(
        padding: EdgeInsets.only(top: 8, bottom: 8, right: 8),
        height: 80,
        child: Row(
          children: <Widget>[
            Card(
              child: Container(
                width: 30,
                height: 80,
              ),
              color: widget.color,
            ),
            SizedBox(width: 8),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Fach: ${widget.subject}',
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    'Lehrer: ${widget.teacher}',
                    style: TextStyle(fontSize: 17),
                  ),
                  Text(
                    'Raum: ${widget.room}',
                    style: TextStyle(fontSize: 15),
                  )
                ],
              ),
            ),
            Checkbox(
              value: check,
              activeColor: Theme.of(context).primaryColor,
              onChanged: (bool val) {
                setState(() {
                  check = val;
                });
                if (val == true)
                  Provider.of<AuthProv>(context)
                      .addToCourseList(widget.subject);
                else if (val == false)
                  Provider.of<AuthProv>(context)
                      .removeFromCourseList(widget.subject);
              },
            )
          ],
        ),
      ),
    );
  }
}