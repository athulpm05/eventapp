// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, use_build_context_synchronously, non_constant_identifier_names, depend_on_referenced_packages

import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class StudentProfile1 extends StatefulWidget {
  const StudentProfile1({super.key, File? image});

  @override
  State<StudentProfile1> createState() => _StudentProfile1State();
}

class _StudentProfile1State extends State<StudentProfile1> {
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
              builder: (context) => StudentProfile1(image: image),
            ));
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('error'),
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Center(
            child: Text(
          'Profile',
          style: TextStyle(fontWeight: FontWeight.bold),
        )),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // CircleAvatar(
                //   radius: 50,
                //   backgroundImage: AssetImage('images/profile.jpg'),),
                InkWell(
                    onTap: () async {
                      ImagePicker Picked = ImagePicker();
                      pick =
                          await Picked.pickImage(source: ImageSource.gallery);
                      setState(() {
                        image = File(pick!.path);
                      });
                    },
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: image != null ? FileImage(image!) : null,
                      child: image == null
                          ? Icon(
                              Icons.person,
                              size: 50,
                            )
                          : null,
                    )
                    //
                    // ClipRRect(
                    //   borderRadius: BorderRadius.circular(100),
                    //   child: image == null?
                    //   Image.asset('images/profile.jpg',width: 100,):Image.file(image!,width: 130,)
                    // ),
                    )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 25),
                  child: Text('Name'),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 320,
            height: 50,
            child: TextFormField(
              decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5))),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 25),
                  child: Text('Department'),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 320,
            height: 50,
            child: TextFormField(
              decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5))),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 25),
                  child: Text('Register No'),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 320,
            height: 50,
            child: TextFormField(
              decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5))),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 25),
                  child: Text('Phone No'),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 320,
            height: 50,
            child: TextFormField(
              decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5))),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 25),
                  child: Text('Email'),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 320,
            height: 50,
            child: TextFormField(
              decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5))),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 22, top: 40),
            child: Row(
              children: [
                InkWell(
                  onTap: () {
                    ProfileImg();
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
          )
        ],
      ),
    );
  }
}
