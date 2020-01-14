import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:x/widgets/custom_listitem.dart';

import '../provider/authProv.dart';

class SetupScreen extends StatefulWidget {
  static const routhName = '/stup';
  @override
  _SetupScreenState createState() => _SetupScreenState();
}

class _SetupScreenState extends State<SetupScreen> {
  var currentitem;
  bool gotList = false;

  void saveClass(String newValueSelected) {
    setState(() {
      currentitem = newValueSelected;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        elevation: 0,
        title: Text('Kurse einrichten'),
      ),
      body: SafeArea(
        minimum: EdgeInsets.only(left: 5, right: 5),
        child: Card(
          elevation: 10,
          child: Container(
            padding: EdgeInsets.only(top: 7),
            width: double.infinity,
            height: size.height,
            child: Column(
              children: <Widget>[
                FutureBuilder(
                  future: Provider.of<AuthProv>(context).getClasses(),
                  builder: (context, snapshot) {
                    if (snapshot?.hasData ?? false) {
                      List<String> list = snapshot.data;
                      return Center(
                        child: DropdownButton<String>(
                          hint: Text(
                            'Wähle deine Klasse',
                            style: TextStyle(
                              fontSize: 23,
                              color: Colors.black,
                            ),
                          ),
                          value: currentitem,
                          items: list.map((String item) {
                            return DropdownMenuItem<String>(
                              value: item,
                              child: Text(
                                item,
                                style: TextStyle(
                                  fontSize: 23,
                                ),
                              ),
                            );
                          }).toList(),
                          onChanged: (String newValueSelected) {
                            saveClass(newValueSelected);
                            Provider.of<AuthProv>(context)
                                .setClass(currentitem);
                            gotList = true;
                          },
                        ),
                      );
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
                if (currentitem != null)
                  Column(
                    children: <Widget>[
                      FutureBuilder(
                        future: Provider.of<AuthProv>(context)
                            .getCourses(currentitem),
                        builder: (context, snapshot) {
                          if (snapshot?.hasData ?? false) {
                            List<dynamic> list = snapshot.data;
                            return Container(
                              height: size.height * 0.77,
                              child: ListView.builder(
                                itemCount: list.length,
                                itemBuilder: (ctx, i) {
                                  return CustomListitem(
                                    list[i]['subject']['subject_name'],
                                    list[i]['teacher']['lastname'],
                                    list[i]['room_name'],
                                    list[i]['color'],
                                  );
                                },
                              ),
                            );
                          } else {
                            gotList = false;
                            return Container();
                          }
                        },
                      ),
                      if (gotList)
                        RaisedButton(
                          child: Text('Speichern'),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          color: Theme.of(context).primaryColor,
                          textColor:
                              Theme.of(context).primaryTextTheme.button.color,
                          onPressed: () {
                            Provider.of<AuthProv>(context, listen: false)
                                .setSeenTrue();
                          },
                        ),
                    ],
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
