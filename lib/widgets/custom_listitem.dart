import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:x/provider/authProv.dart';

class CustomListitem extends StatefulWidget {
  String teacher;
  String subject;
  String room;
  String tmpColor;
  String col;
  Color color;
  int id;
  String gender;

  CustomListitem(this.subject, this.teacher, this.room, this.tmpColor, this.id,
      this.gender) {
    col = '0xff' + tmpColor.replaceFirst('#', '');
    color = Color(int.parse(col));
  }

  @override
  _CustomListitemState createState() => _CustomListitemState();
}

class _CustomListitemState extends State<CustomListitem> {
  bool check = false;
  String teacher;
  @override
  Widget build(BuildContext context) {
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Fach: ${widget.subject}',
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    'Lehrer: ${widget.gender == 'M' ? 'Herr ' + widget.teacher : widget.gender == 'W' ? 'Frau ' + widget.teacher : widget.teacher}',
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
                if (val)
                  Provider.of<AuthProv>(context).addToCourseList(widget.id);
                else if (!val)
                  Provider.of<AuthProv>(context)
                      .removeFromCourseList(widget.id);
              },
            )
          ],
        ),
      ),
    );
  }
}
