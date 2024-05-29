// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_application_1/student/Event.dart';
import 'package:flutter_application_1/student/regstudent.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Signinstudent extends StatefulWidget {
  const Signinstudent({super.key});

  @override
  State<Signinstudent> createState() => _SigninstudentState();
}

class _SigninstudentState extends State<Signinstudent> {
  //
  final valid = GlobalKey<FormState>();
  var email = TextEditingController();
  var password = TextEditingController();

  Future<void> studentdata(String data) async {
    SharedPreferences std = await SharedPreferences.getInstance();
    await std.setString('studentId', data);

  }
  //snackbar
  final SnackBar _snackBar1 = SnackBar(
    content: Text("Logon successfull"),
    duration: Duration(seconds: 10),
  );


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Form(
        key: valid,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 25),
              child: Text(
                'Sign in',
                style: TextStyle(fontSize: 33, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25),
              child: Text(
                'Sign into your account',
                style: TextStyle(fontSize: 20),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Center(
                child: SizedBox(
                  height: 50,
                  width: 350,
                  child: TextFormField(
                    decoration: InputDecoration(hintText: 'Email Address'),
                    //
                    controller: email,
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'please enter email';
                      }
                    },
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Center(
                child: SizedBox(
                  height: 50,
                  width: 350,
                  child: TextFormField(
                    decoration: InputDecoration(hintText: 'Password'),
                    controller: password,
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'please enter password';
                      }
                    },
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Center(
                child: InkWell(
                  onTap: () async {
                    //email adding in firebase
                    if (valid.currentState?.validate() ?? false) {
                      String email1 = email.text.trim();
                      String password1 = password.text.trim();
                      var querysnap = await FirebaseFirestore.instance
                          .collection('student data')
                          .where('Email', isEqualTo: email1)
                          .limit(1)
                          .get();

                      //password adding in firebase
                      if (querysnap.docs.isNotEmpty) {
                        var studdata = querysnap.docs.first.data();
                        if (studdata['Password'] == password1) {
                          var studentid = studdata['studentid'] as String?;
                          if (studentid != null) {
                            await studentdata(studentid);
                          }
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Event1(),
                              ));
                        }
                      }
                    }
                  },
                  child: Container(
                    height: 50,
                    width: 350,
                    decoration: BoxDecoration(
                        color: Color(0xFF3063A5),
                        borderRadius: BorderRadius.circular(7)),
                    child: Center(
                        child: Text(
                      'Login',
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    )),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Don’t have an account? '),
                  GestureDetector(
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(_snackBar1);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Regstudent(),
                            ));
                      },
                      child: Text(
                        'Sign up',
                        style: TextStyle(color: Colors.blue),
                      ))
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }
}
