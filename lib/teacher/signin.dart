// ignore_for_file: unnecessary_import, prefer_const_constructors, depend_on_referenced_packages

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/teacher/registration.dart';
import 'package:flutter_application_1/teacher/studentlist.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';



class Signin extends StatefulWidget {
  const Signin({super.key});

  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  final emailcontroller = TextEditingController();
  final passwordController = TextEditingController();
  final teacherkey = GlobalKey<FormState>();

  bool obscurePassword = true;
  bool isLoading = false;


Future<void>validateLogin()async{
   if (!teacherkey.currentState!.validate()) {
      return;
      }
      setState(() {
        isLoading =true;
      });
      final String typedemail =emailcontroller.text.trim();
      final String typedpassword = passwordController.text.trim();
      try{
        QuerySnapshot querySnapshot =await FirebaseFirestore.instance.
        collection('teacher_reg')
        .where('email',isEqualTo: typedemail)
        .where('password',isEqualTo: typedpassword)
        .limit(1)
        .get();
        if(querySnapshot.docs.isNotEmpty){
          String docId= querySnapshot.docs.first.id;
          SharedPreferences preff =await SharedPreferences.getInstance();
          await preff.setString('teaId', docId);
          // called next page to login time
          Navigator.pushReplacement(context,
           MaterialPageRoute(builder: (context) => Student_List(),));
        }else{
          showErrorDialog('Invalid Credentials','please enter a valid email and password.');

        }
      }catch(e){
      showErrorDialog('Error', 'An error occurred while trying to log in. Please try again.');

      }finally {
      setState(() {
        isLoading = false;
      });
    }
}
void showErrorDialog(String title,
String message){
 showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Form(
        key: teacherkey,
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
                  height: 40,
                  width: 350,
                  child: TextFormField(
                    controller: emailcontroller,
                    validator: (value) {
                      if (value!.isEmpty ||
                          !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(value)) {
                        return 'Enter a valid email!';
                      }
                      return null;
                    },
                    decoration: InputDecoration(hintText: 'Email Address'),
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
                    controller: passwordController,
                    obscureText: obscurePassword,
                    cursorColor: Colors.black,
                    //pass hide button
                    decoration: InputDecoration(
                        hintText: 'Password',
                        suffixIcon: IconButton(
                            onPressed: () {

                              setState(() {
                                obscurePassword =!obscurePassword;
                              });
                            },
                            icon: Icon(
                              obscurePassword
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Colors.black,
                            ))),
                  ),
                ),
              ),
            ),

            isLoading? Center(child: CircularProgressIndicator(),):
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Center(
                child: InkWell(
                  onTap: () {
                    validateLogin();
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
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Registration(),
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
