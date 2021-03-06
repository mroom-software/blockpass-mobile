import 'dart:convert';

import 'package:blockpass/config/app.dart';
import 'package:blockpass/data/db/db.dart';
import 'package:blockpass/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChangePwdScreen extends StatefulWidget {

  @override
  _ChangePwdScreenState createState() => _ChangePwdScreenState();
}

class _ChangePwdScreenState extends State<ChangePwdScreen> {
  final txtOldPwdController = TextEditingController();
  final txtNewPwdController = TextEditingController();
  bool showOldPwd = false;
  bool showNewPwd = false;

  @override
  void initState() {
    super.initState();
  }

  void btnSaveTouched() async {
    String oldPwd = txtOldPwdController.text.trim();
    String newPwd = txtNewPwdController.text.trim();

    if (base64.encode(utf8.encode(oldPwd)) != app.user.password) {
      Utils.showPopup(context, 'ERROR', 'Please doule check your old password!');
      return;
    }

    if (newPwd.length == 0) {
      Utils.showPopup(context, 'ERROR', 'New password is invalid!');
      return;
    }

    app.user.password = base64.encode(utf8.encode(newPwd));
    await db.updateUser(app.user);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
        elevation: 0.0,
        title: Text(
          'CHANGE PASSWORD',
          style: Theme.of(context).textTheme.title,
        ),
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 110),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Old Password',
                    style: Theme.of(context).textTheme.subtitle,
                  ),
                ),
              ), 
              Container(
                color: Colors.white,
                height: 60,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                    child: TextField(
                      controller: txtOldPwdController,
                      obscureText: showOldPwd ? false : true,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: '',
                        suffixIcon: IconButton(
                          color: Colors.blueGrey,
                          icon: showOldPwd ? Icon(Icons.visibility_off) : Icon(Icons.visibility),
                          onPressed: () => showOldPwdChanged(),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 10),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    'New Password',
                    style: Theme.of(context).textTheme.subtitle,
                  ),
                ),
              ), 
              Container(
                color: Colors.white,
                height: 60,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                    child: TextField(
                      controller: txtNewPwdController,
                      obscureText: showOldPwd ? false : true,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: '',
                        suffixIcon: IconButton(
                          color: Colors.blueGrey,
                          icon: showNewPwd ? Icon(Icons.visibility_off) : Icon(Icons.visibility),
                          onPressed: () => showNewPwdChanged(),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 30.0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 60,
                  child: RaisedButton(
                    color: Color.fromRGBO(36, 59, 107, 1),
                    onPressed: () => btnSaveTouched(),
                    child: Text(
                      'Save',
                      style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 16),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showOldPwdChanged() {
    setState(() {
      showOldPwd = !showOldPwd;
    });
  }

  void showNewPwdChanged() {
    setState(() {
      showNewPwd = !showNewPwd;
    });
  }

}