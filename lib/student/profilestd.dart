// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/student/profilestd1.dart';

class Profilestd extends StatefulWidget {
    File? image;

   Profilestd({super.key, this.image});
  @override
  State<Profilestd> createState() => _ProfilestdState();
}

class _ProfilestdState extends State<Profilestd> {

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
               Padding(
                padding: const EdgeInsets.only(top: 55),
                child: InkWell(
                  onTap: () => Navigator.push(context,
                   MaterialPageRoute(builder: (context) => StudentProfile1(),)),
                  child: Container(
                    height: 50,
                    width: 320,
                    decoration: BoxDecoration(color: Color(0xFF3063A5),borderRadius: BorderRadius.circular(7)),
                    child: Center(child: Text('Edit',style: TextStyle(color: Colors.white,fontSize: 15),)),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}