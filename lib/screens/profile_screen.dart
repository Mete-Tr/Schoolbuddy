import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:x/provider/profileProv.dart';

import '../widgets/app_drawer.dart';

class ProfileScreen extends StatefulWidget {
  static const routhName = '/profile';
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final divice = MediaQuery.of(context).size;

    return FutureBuilder(
        future: Provider.of<ProfileProv>(context).getUserData(),
        builder: (context, snapshot) {
          if (snapshot?.hasData ?? false) {
            return Scaffold(
              backgroundColor: Theme.of(context).primaryColor,
              appBar: AppBar(
                elevation: 0,
                title: Text('Profile Screen'),
              ),
              drawer: AppDrawer(),
              body: SafeArea(
                minimum: EdgeInsets.only(left: 5, right: 5),
                child: Column(
                  children: <Widget>[
                    Card(
                      elevation: 10,
                      child: Container(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                CircleAvatar(
                                  radius: 30,
                                  child: IconButton(
                                    icon: Icon(Icons.person),
                                    iconSize: 35,
                                    onPressed: () {},
                                  ),
                                ),
                                Text(
                                  '\tClass: ${snapshot.data['klasse']}',
                                  style: TextStyle(fontSize: 20),
                                )
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: <Widget>[
                                Text(
                                  'Name:\n${snapshot.data['lastname']},\t${snapshot.data['firstname']}',
                                  style: TextStyle(fontSize: 25),
                                )
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: <Widget>[
                                Text(
                                  'E-mail:\t${snapshot.data['email']}',
                                  style: TextStyle(fontSize: 20),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
