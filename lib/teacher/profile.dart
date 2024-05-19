

// ignore_for_file: camel_case_types, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class stdprofile extends StatefulWidget {
  const stdprofile({super.key});

  @override
  State<stdprofile> createState() => _stdprofileState();
}

class _stdprofileState extends State<stdprofile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Center(child: Padding(
              padding: const EdgeInsets.only(top: 50),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 110,left: 20),
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.arrow_back_ios)),
                  ),
                  Text('Profile',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),),
                ],
              ),
            )),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Image(
                height: 100,
                width: 100,
                image: AssetImage('images/person.png')),
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
                width: 350,
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
                width: 350,
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
                width: 350,
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
                width: 350,
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
                width: 350,
                child: TextFormField(
                  decoration: InputDecoration(border: OutlineInputBorder()),
                ),
              ),
            ),
             Padding(
              padding: const EdgeInsets.only(top: 140),
              child: Container(
                height: 50,
                width: 350,
                decoration: BoxDecoration(color: Color(0xFF3063A5),borderRadius: BorderRadius.circular(7)),
                child: Center(child: Text('Submit',style: TextStyle(color: Colors.white,fontSize: 15),)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
