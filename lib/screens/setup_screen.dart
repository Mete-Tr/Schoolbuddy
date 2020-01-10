import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/authProv.dart';

class SetupScreen extends StatefulWidget {
  static const routhName = '/stup';
  @override
  _SetupScreenState createState() => _SetupScreenState();
}

class _SetupScreenState extends State<SetupScreen> {
  var currentitem;
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
                                color: Theme.of(context).primaryColor,
                                fontSize: 23),
                          ),
                          value: currentitem,
                          items: list.map((String item) {
                            return DropdownMenuItem<String>(
                              value: item,
                              child: Text(
                                item,
                                style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 23,
                                ),
                              ),
                            );
                          }).toList(),
                          onChanged: (String newValueSelected) {
                            setState(() {
                              currentitem = newValueSelected;
                            });
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
                FutureBuilder()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
