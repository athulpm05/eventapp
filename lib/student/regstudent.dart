// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, non_constant_identifier_names, depend_on_referenced_packages, unnecessary_import

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/student/signin1.dart';

class Regstudent extends StatefulWidget {
  const Regstudent({super.key});

  @override
  State<Regstudent> createState() => _RegstudentState();
}

class _RegstudentState extends State<Regstudent> {
  //controller
  TextEditingController name = TextEditingController();
  TextEditingController department = TextEditingController();
  TextEditingController reg_no = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  final valid = GlobalKey<FormState>();

  // Future<void> checking()async{
  //   if (valid.currentstate!.validate()){

  //   }
  // }

  //snackbar
  final SnackBar _snackBar = SnackBar(
    content: Text("Submit successfull"),
    duration: Duration(seconds: 4),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Form(
            key: valid,
            child: Column(
              children: [
                Center(
                    child: Padding(
                  padding: const EdgeInsets.only(top: 35),
                  child: Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(Icons.arrow_back_ios)),
                      Padding(
                        padding: const EdgeInsets.only(left: 80),
                        child: Text(
                          'Registration',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                )),
                Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 40, left: 30),
                          child: Text(
                            'Name',
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: SizedBox(
                    width: 350,
                    child: TextFormField(
                      controller: name,
                      decoration: InputDecoration(border: OutlineInputBorder()),
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'Please enter name';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20, left: 30),
                      child: Text(
                        'Department',
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: SizedBox(
                    width: 350,
                    child: TextFormField(
                      decoration: InputDecoration(border: OutlineInputBorder()),
                      controller: department,
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'please enter department';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20, left: 30),
                      child: Text(
                        'Reg no',
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: SizedBox(
                    width: 350,
                    child: TextFormField(
                      decoration: InputDecoration(border: OutlineInputBorder()),
                      controller: reg_no,
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'please enter register number';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20, left: 30),
                      child: Text(
                        'Phone No',
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: SizedBox(
                    width: 350,
                    child: TextFormField(
                      decoration: InputDecoration(border: OutlineInputBorder()),
                      controller: phone,
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'please enter phone number';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20, left: 30),
                      child: Text(
                        'Email',
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: SizedBox(
                    width: 350,
                    child: TextFormField(
                      decoration: InputDecoration(border: OutlineInputBorder()),
                      controller: email,
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'please enter email';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20, left: 30),
                      child: Text(
                        'Password',
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: SizedBox(
                    width: 350,
                    child: TextFormField(
                      decoration: InputDecoration(border: OutlineInputBorder()),
                      controller: password, 
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'please enter password';
                        } else if (value!.length < 6) {
                          // Check if password length is less than 6
                          return 'Password should be at least 6 characters';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: InkWell(
                    onTap: () async {
                      ScaffoldMessenger.of(context).showSnackBar(_snackBar);

                      if (valid.currentState?.validate() ?? false) {
                        UserCredential userCredential = await FirebaseAuth
                            .instance
                            .createUserWithEmailAndPassword(
                                email: email.text, password: password.text);
                        String uid = userCredential.user!.uid;
                        await FirebaseFirestore.instance
                            .collection('student data')
                            .add({
                          'Name': name.text,
                          'Depatment': department.text,
                          'Register': reg_no.text,
                          'Phone': phone.text,
                          'Email': email.text,
                          'Password': password.text
                        });
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Signinstudent(),
                            ));
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
                        'Submit',
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      )),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
