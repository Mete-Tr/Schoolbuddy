import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:x/provider/authProv.dart';

class ChangeEmail extends StatelessWidget {
  static const routhName = '/changeEmail';
  final GlobalKey<FormState> _formKey = GlobalKey();
  String email = '';
  String pwd = '';

  @override
  Widget build(BuildContext context) {
    Future<bool> _submit() async {
      if (!_formKey.currentState.validate()) {
        return false;
      }
      _formKey.currentState.save();
      try {
        Provider.of<AuthProv>(context, listen: false).changeEmail(pwd, email);
        Navigator.of(context).pop();
        return true;
      } catch (error) {}
    }

    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        appBar: AppBar(
          title: Text('Change Email'),
        ),
        body: SafeArea(
          minimum: EdgeInsets.only(left: 5, right: 5),
          child: Column(
            children: <Widget>[
              Card(
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: 'Password',
                          ),
                          validator: (value) {
                            if (value.isEmpty || value.length < 5) {
                              return 'Password is too short!';
                            }
                          },
                          onSaved: (val) {
                            pwd = val;
                          },
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'New Email',
                          ),
                          validator: (value) {
                            if (value.isEmpty || !value.contains('@')) {
                              return 'Not a vald Email address';
                            }
                          },
                          onSaved: (val) {
                            email = val;
                          },
                        ),
                        RaisedButton(
                          child: Text('Save'),
                          color: Theme.of(context).primaryColor,
                          textColor:
                              Theme.of(context).primaryTextTheme.button.color,
                          padding: EdgeInsets.symmetric(
                              horizontal: 30.0, vertical: 8.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          onPressed: _submit,
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}