// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, non_constant_identifier_names, depend_on_referenced_packages, must_be_immutable, avoid_print, unused_import, avoid_returning_null_for_void

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/student/profilestd1.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Profilestd extends StatefulWidget {
  File? image;

  Profilestd({super.key, this.image});
  
  @override
  State<Profilestd> createState() => _ProfilestdState();
}

class _ProfilestdState extends State<Profilestd> {
  var name = TextEditingController();
  var department = TextEditingController();
  var register_no = TextEditingController();
  var phone = TextEditingController();
  var email = TextEditingController();

  final validkey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    fetchstudentDetails();
  }

  Future<void> fetchstudentDetails() async {
    try {
      SharedPreferences spreff = await SharedPreferences.getInstance();
      String? std = spreff.getString('studentId');
      print("SharedPreferences student ID: $std");

      if (std != null && std.isNotEmpty) {
        DocumentSnapshot studentSnapshot = await FirebaseFirestore.instance
            .collection('student data')
            .doc(std)
            .get();

        if (studentSnapshot.exists) {
          setState(() {
            name.text = studentSnapshot['Name'] ?? '';
            department.text = studentSnapshot['Depatment'] ?? '';
            register_no.text = studentSnapshot['Register'] ?? '';
            phone.text = studentSnapshot['Phone'] ?? '';
            email.text = studentSnapshot['Email'] ?? '';
          });
          
        }
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: validkey,
            child: Column(
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 92, left: 10),
                          child: IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(Icons.arrow_back_ios),
                          ),
                        ),
                        Text(
                          'Profile',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 80),
                          child: IconButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => Studentprofile1()),
                              );
                            },
                            icon: Icon(Icons.edit_document),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: widget.image != null ? FileImage(widget.image!) : null,
                    ),
                  ],
                ),
                _buildProfileField('Name', name),
                _buildProfileField('Department', department),
                _buildProfileField('Register No', register_no),
                _buildProfileField('Phone No', phone),
                _buildProfileField('Email', email),
              ],
            ),
          ),
        ),
        
      ),
      
    );
  }
  
  Widget _buildProfileField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 30),
            child: Text(label, style: TextStyle(fontSize: 14)),
          ),
          SizedBox(
            height: 5,
          ),
          SizedBox(
            height: 40,
            width: 320,
            child: TextFormField(
              controller: controller,
              decoration: InputDecoration(border: OutlineInputBorder()),
            ),
          ),
        ],
      ),
    );
  }
}
