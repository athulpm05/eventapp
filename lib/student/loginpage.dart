// ignore_for_file: prefer_const_constructors, depend_on_referenced_packages, use_key_in_widget_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/student/Event.dart';
import 'package:flutter_application_1/student/regstudent.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StudentSignIn extends StatefulWidget {
  const StudentSignIn({Key? key});

  @override
  State<StudentSignIn> createState() => _StudentSignInState();
}

class _StudentSignInState extends State<StudentSignIn> {
  final username = TextEditingController();
  final password = TextEditingController();
  final formKey = GlobalKey<FormState>();

  bool obscurePassword = true;
  bool isLoading = false;

  void validateLogin() async {
  setState(() {
    isLoading = true;
  });

  final String enteredEmail = username.text.trim();
  final String enteredPassword = password.text.trim();

  try {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('student data')
        .where('Email', isEqualTo: enteredEmail)
        .where('Password', isEqualTo: enteredPassword)
        .limit(1)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      String docId = querySnapshot.docs.first.id;

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('studentId', docId);

      // Print the stored studentId to the console
      String? storedStudentId = prefs.getString('studentId');
      print('Stored studentId: $storedStudentId');

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Event1()),
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Invalid Credentials'),
            content: Text('Please enter valid email and password.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  } catch (e) {
    print('Error: $e');
  } finally {
    setState(() {
      isLoading = false;
    });
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Sign in",
                    style: TextStyle(fontSize: 33, fontWeight: FontWeight.w500),
                  ),
                  Text(
                    "Sign into your account",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  TextFormField(
                    controller: username,
                    validator: (value) {
                      if (value!.isEmpty ||
                          !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(value)) {
                        return 'Enter a valid email!';
                      }
                    },
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                        hintText: "Email Address",
                        focusedBorder: UnderlineInputBorder()),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: password,
                    obscureText: obscurePassword,
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                      hintText: "Password",
                      focusedBorder: UnderlineInputBorder(),
                      suffixIcon: IconButton(
                        icon: Icon(
                          obscurePassword
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.black,
                        ),
                        onPressed: () {
                          setState(() {
                            obscurePassword = !obscurePassword;
                          });
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  isLoading
                      ? Center(child: CircularProgressIndicator())
                      : Center(
                        child: FloatingActionButton(
                          backgroundColor: Colors.teal,
                          
                            onPressed: () {
                              validateLogin();
                            },
                            child: Text('Login',style: 
                            TextStyle(color: Colors.black),),
                          ),
                      ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don’t have an account?",
                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Regstudent(),
                            ),
                          );
                        },
                        child: Text(
                          " Sign up",
                          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400, color: Colors.blue),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

}