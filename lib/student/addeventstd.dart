// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class Eventaddstd extends StatefulWidget {
  const Eventaddstd({super.key});

  @override
  State<Eventaddstd> createState() => _EventaddstdState();
}

class _EventaddstdState extends State<Eventaddstd> {
    TextEditingController requestevent = TextEditingController();
    TextEditingController name = TextEditingController();
    TextEditingController department = TextEditingController();
    TextEditingController phone = TextEditingController();
    TextEditingController description = TextEditingController();

    final valid = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        body: SafeArea(
         child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Form(
              key: valid,
              child: Column(
                children: [
                  Center(
                      child: Padding(
                    padding: const EdgeInsets.only(top: 50),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 90, left: 20),
                          child: IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: Icon(Icons.arrow_back_ios)),
                        ),
                        Text(
                          'Event Request',
                          style:
                              TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  )),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 20, left: 30),
                        child: Text(
                          'Request Event',
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: SizedBox(
                      height: 45,
                      width: 350,
                      child: TextFormField(
                        //
                        controller: requestevent,
                        validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'Please enter request event';
                        }
                        return null;
                      },

                        decoration: InputDecoration(border: OutlineInputBorder()),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 20, left: 30),
                        child: Text(
                          'Name',
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: SizedBox(
                      height: 45,
                      width: 350,
                      child: TextFormField(
                        validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'Please enter name';
                        }
                        return null;
                      },
                        controller: name,
                        decoration: InputDecoration(border: OutlineInputBorder()),
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
                      height: 45,
                      width: 350,
                      child: TextFormField(
                        validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'Please enter department';
                        }
                        return null;
                      },
                        controller: department,
                        decoration: InputDecoration(border: OutlineInputBorder()),
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
                      height: 45,
                      width: 350,
                      child: TextFormField(
                        validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'Please enter phone number';
                        }
                        return null;
                      },
                        controller: phone,
                        decoration: InputDecoration(border: OutlineInputBorder()),
                      ),
                    ),
                  ),
                  Row( 
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 20, left: 30),
                        child: Text(
                          'Description',
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Container(
                      height: 134,
                      width: 350,
                      child: TextFormField(
                        
                        maxLines: 5,
                        controller: description,
                        validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'Please enter message description';
                        }
                        return null;
                      },
                        decoration: InputDecoration(border: OutlineInputBorder(),),
                      ),
                      
              
                    ),
                  ),
                   Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: InkWell(
                    onTap: () async {
                      
                          await FirebaseFirestore.instance
                            .collection('stud_addevent')
                            .doc()
                            .set({
                          'requestevent': requestevent.text,
                          'name': name.text,
                          'department':department .text,
                          'phone': phone.text,
                          'description': description.text,
                        });
                        requestevent.clear();
                        name.clear();
                        department.clear();
                        phone.clear();
                        description.clear();
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('event requested')));

                    },
                    child: Container(
                      height: 50,
                      width: 350,
                      decoration: BoxDecoration(color: Color(0xFF3063A5),borderRadius: BorderRadius.circular(7)),
                      child: Center(child: Text('Submit',style: TextStyle(color: Colors.white,fontSize: 15),)),
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