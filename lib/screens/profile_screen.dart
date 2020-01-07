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
  final GlobalKey<FormState> _formKey = GlobalKey();
  bool edit = false;
  @override
  Widget build(BuildContext context) {
    final divice = MediaQuery.of(context).size;

    return FutureBuilder(
        future: Provider.of<ProfileProv>(context).getUserData(),
        builder: (context, snapshot) {
          final user = snapshot.data;
          if (snapshot?.hasData ?? false) {
            return Scaffold(
              backgroundColor: Theme.of(context).primaryColor,
              appBar: AppBar(
                elevation: 0,
                title: Text('Profile'),
                actions: <Widget>[
                  Icon(Icons.edit),
                  Switch(
                    activeColor: Colors.white,
                    value: edit,
                    onChanged: (val) {
                      setState(() {
                        edit = val;
                      });
                    },
                  )
                ],
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
                        child: Form(
                          key: _formKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                                  SizedBox(width: 10),
                                  Text(
                                    '\tClass: ${user['klasse']}',
                                    style: TextStyle(fontSize: 20),
                                  )
                                ],
                              ),
                              const SizedBox(height: 10),
                              if (!edit)
                                Text(
                                  'Name:\n${user['lastname']},\t${user['firstname']}',
                                  style: TextStyle(fontSize: 25),
                                )
                              else
                                TextFormField(
                                  decoration: InputDecoration(
                                    labelText: 'New name',
                                  ),
                                  onSaved: (val) {
                                    //TODO:
                                  },
                                ),
                              const SizedBox(height: 10),
                              Text(
                                'E-mail:\t${user['email']}',
                                style: TextStyle(fontSize: 20),
                              ),
                              if (edit)
                                Center(
                                  child: RaisedButton(
                                    child: Text('Save'),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    color: Theme.of(context).primaryColor,
                                    textColor: Theme.of(context)
                                        .primaryTextTheme
                                        .button
                                        .color,
                                    onPressed: () {
                                      //TODO:what happens after save
                                    },
                                  ),
                                )
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 50),
                    Container(
                      width: 250,
                      child: RaisedButton(
                        color: Colors.white,
                        textColor: Theme.of(context).primaryColor,
                        child: Text('Change Email'),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        onPressed: () {},
                      ),
                    ),
                    Container(
                      width: 250,
                      child: RaisedButton(
                        color: Colors.white,
                        textColor: Theme.of(context).primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Text('Change Password'),
                        onPressed: () {},
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
