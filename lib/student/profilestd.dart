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
  Future<void>fetchstudentDetails()async{
    try{
      SharedPreferences spreff=await SharedPreferences.getInstance();
      String?std =spreff.getString('student_Id');
      print("sharedprefence student id : $std");
      if(std!.isNotEmpty){
        Stream<DocumentSnapshot>studentstream=FirebaseFirestore.instance
        . collection('student data')
        .doc()
        .snapshots();

        studentstream.listen((studentsnapshot) {
          if(studentsnapshot.exists){
            setState(() {
              name.text=studentsnapshot['Name']??'';
              department.text=studentsnapshot['Department']??'';
              register_no.text=studentsnapshot['Register']??'';
              phone.text=studentsnapshot['Phone']??'';
              email.text=studentsnapshot['Email']??'';
            });
          }
        });

      }
    }catch (e){
      print('error:$e');
      return null;
    }
  }
  
  var name =TextEditingController();
  var department =TextEditingController();
  var register_no=TextEditingController();
  var phone =TextEditingController();
  var email =TextEditingController();

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
       body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Center(child: Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 92,left: 10),
                      child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.arrow_back_ios)),
                    ),
                    Text('Profile',style: TextStyle(
                      fontSize: 18,fontWeight: FontWeight.w700),),
                      Padding(
                        padding: const EdgeInsets.only(left: 80),
                        child: IconButton(onPressed: () {
                          Navigator.push(context,
                   MaterialPageRoute(builder: (context) => StudentProfile1(),));
                        
                        }, icon: Icon(Icons.edit_document)),
                      )
                  ],
                ),
              )),
                Row(
              mainAxisAlignment: MainAxisAlignment
              .center,
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: widget.image != null? FileImage(widget.image!):null,
                  // child: widget.image == null? Icon(Icons.person,size: 50,):null,
                  ),
              ],
            ),
               Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20,left: 30),
                    child: Text('Name',style: TextStyle(fontSize: 14),),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: SizedBox(
                  height: 40,
                  width: 320,
                  child: TextFormField(
                    decoration: InputDecoration(border: OutlineInputBorder()),
                  ),
                ),
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20,left: 30),
                    child: Text('Department',style: TextStyle(fontSize: 14),),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: SizedBox(
                  height: 40,
                  width: 320,
                  child: TextFormField(
                    decoration: InputDecoration(border: OutlineInputBorder()),
                  ),
                ),
              ),
                Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20,left: 30),
                    child: Text('Register No',style: TextStyle(fontSize: 14),),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: SizedBox(
                  height: 40,
                  width: 320,
                  child: TextFormField(
                    decoration: InputDecoration(border: OutlineInputBorder()),
                  ),
                ),
              ),
                Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20,left: 30),
                    child: Text('Phone No',style: TextStyle(fontSize: 14),),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: SizedBox(
                  height: 40,
                  width: 320,
                  child: TextFormField(
                    decoration: InputDecoration(border: OutlineInputBorder()),
                  ),
                ),
              ),
                Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20,left: 30),
                    child: Text('Email',style: TextStyle(fontSize: 14),),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: SizedBox(
                  height: 40,
                  width: 320,
                  child: TextFormField(
                    decoration: InputDecoration(border: OutlineInputBorder()),
                  ),
                ),
              ),
               
            ],
          ),
        ),
      ),
    );
  }
}