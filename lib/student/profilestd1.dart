// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, non_constant_identifier_names, depend_on_referenced_packages, must_be_immutable, avoid_print, unused_import, avoid_returning_null_for_void, use_build_context_synchronously, curly_braces_in_flow_control_structures

import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/student/profilestd1.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class Studentprofile1 extends StatefulWidget {
  

  Studentprofile1({super.key, File?image});
  
  
  
  
  @override
  State<Studentprofile1> createState() => _Studentprofile1State();
}

class _Studentprofile1State extends State<Studentprofile1> {
  XFile? pick;
  File? image;
  Future<void> ProfileImg() async {
    if (image != null) {
      try {
        final reff = FirebaseStorage.instance
            .ref()
            .child('profile')
            .child(DateTime.now().microsecondsSinceEpoch.toString());
        await reff.putFile(image!);
        final imageurl = await reff.getDownloadURL();
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Studentprofile1(image: image),
            ));
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('error'),
        ));
      }
    }
    }
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
                       
                      ],
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                 
                  InkWell(
                    onTap: () async {
                      ImagePicker Picked = ImagePicker();
                      pick =
                          await Picked.pickImage(source: ImageSource.gallery);
                      setState(() {
                        image = File(pick!.path);
                      });
                    },
                    //circle image adding potion
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: image!=null?FileImage(image!):null,
                      child: image==null?
                      Icon(Icons.person,size: 50,):null)
                    ),


                  ],
                ),
                _buildProfileField('Name', name),
                _buildProfileField('Department', department),
                _buildProfileField('Register No', register_no),
                _buildProfileField('Phone No', phone),
                _buildProfileField('Email', email),

                Padding(
            padding: const EdgeInsets.only(left: 22, top: 45),
            child: Row(
              children: [
                InkWell(
                  onTap: () async{
                    if(name.text.isNotEmpty &&
                    department.text.isNotEmpty&&
                    register_no.text.isNotEmpty&&
                    phone.text.isNotEmpty&&
                    email.text.isNotEmpty)
                    try{
                    SharedPreferences preff=await SharedPreferences.getInstance();
                    String?std=preff.getString('studentID');
                    if(std!=null){

                      await FirebaseFirestore.instance
                      .collection('student data')
                      .doc(std)
                      .update({
                        "Name":name.text,
                        "Depatment":department.text,
                        "Register":register_no.text,
                        "Phone":phone.text,
                        "Email":email.text
                        
                      });
                      ScaffoldMessenger.of(context).
                      showSnackBar(SnackBar(content: Text("Profile successfully updated")));
                    }

                    }catch(e){
                      print("$e");
                    }
                    
                    Navigator.pop(context);

                    
                  },
                  child: Container(
                    width: 320,
                    height: 50,
                    decoration: BoxDecoration(
                        color: Color(0xFF3063A5),
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                        child: Text(
                      'Submit',
                      style: TextStyle(color: Colors.white),
                    )),
                  ),
                ),
              ],
            ),
            )],
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
