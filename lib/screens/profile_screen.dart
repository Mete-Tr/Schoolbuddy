import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:x/provider/authProv.dart';
import 'package:x/screens/change_email.dart';
import 'package:x/screens/change_password.dart';

import '../widgets/app_drawer.dart';

class ProfileScreen extends StatefulWidget {
  static const routhName = '/profile';
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  bool edit = false;
  String fullName = '';

  void _submit() async {
    //TODO: Doku -> der name wurde zu spät geänert. Lösung: async und await
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    await Provider.of<AuthProv>(context, listen: false).changeName(fullName);
    setState(() {
      edit = false;
    });
  }

  Future<SharedPreferences> getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getUserData(),
        builder: (context, snapshot) {
          if (snapshot?.hasData ?? false) {
            return Scaffold(
              backgroundColor: Theme.of(context).primaryColor,
              appBar: AppBar(
                elevation: 0,
                title: Text('Dein Profil'),
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
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
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
                                    '\tKlasse: ${snapshot.data.getString('klasse')}',
                                    style: TextStyle(fontSize: 20),
                                  )
                                ],
                              ),
                              const SizedBox(height: 10),
                              if (!edit)
                                Text(
                                  'Name:\n${snapshot.data.getString('firstname')}\t${snapshot.data.getString('lastname')}',
                                  style: TextStyle(fontSize: 25),
                                )
                              else
                                TextFormField(
                                  decoration: InputDecoration(
                                    labelText: 'Neuer Name',
                                  ),
                                  onSaved: (val) {
                                    fullName = val;
                                  },
                                ),
                              const SizedBox(height: 10),
                              Text(
                                'E-mail:\t${snapshot.data.getString('email')}',
                                style: TextStyle(fontSize: 20),
                              ),
                              if (edit)
                                Center(
                                  child: RaisedButton(
                                    child: Text('Speichern'),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    color: Theme.of(context).primaryColor,
                                    textColor: Theme.of(context)
                                        .primaryTextTheme
                                        .button
                                        .color,
                                    onPressed: _submit,
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
                        child: Text('Email ändern'),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        onPressed: () {
                          Navigator.of(context)
                              .pushNamed(ChangeEmail.routhName);
                        },
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
                        child: Text('Passwort ändern'),
                        onPressed: () {
                          Navigator.of(context)
                              .pushNamed(ChangePassword.routhName);
                        },
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
