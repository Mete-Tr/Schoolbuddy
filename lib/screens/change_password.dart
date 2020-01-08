import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:x/provider/authProv.dart';

class ChangePassword extends StatelessWidget {
  static const routhName = '/changePwd';
  final GlobalKey<FormState> _formKey = GlobalKey();
  final _passwordController = TextEditingController();
  String newPwd = '';
  String oldPwd = '';

  @override
  Widget build(BuildContext context) {
    Future<bool> _submit() async {
      if (!_formKey.currentState.validate()) {
        return false;
      }
      _formKey.currentState.save();
      try {
        Provider.of<AuthProv>(context, listen: false).changePwd(oldPwd, newPwd);
        Navigator.of(context).pop();
        return true;
      } catch (error) {}
    }

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        title: Text('Change password'),
      ),
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
                    children: <Widget>[
                      TextFormField(
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'Old password',
                        ),
                        validator: (value) {
                          if (value.isEmpty || value.length < 5) {
                            return 'Password is too short!';
                          }
                        },
                        onSaved: (val) {
                          oldPwd = val;
                        },
                      ),
                      TextFormField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'New password',
                        ),
                        validator: (value) {
                          if (value.isEmpty || value.length < 5) {
                            return 'Password is too short!';
                          }
                        },
                      ),
                      TextFormField(
                        decoration:
                            InputDecoration(labelText: 'Confirm Password'),
                        obscureText: true,
                        validator: (value) {
                          if (value != _passwordController.text) {
                            return 'Passwords do not match!';
                          }
                        },
                        onSaved: (val) {
                          newPwd = val;
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
      ),
    );
  }
}
