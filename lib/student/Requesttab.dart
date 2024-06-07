// ignore_for_file: prefer_const_constructors, sort_child_properties_last, sized_box_for_whitespace, depend_on_referenced_packages

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/student/addeventstd.dart';
import 'package:flutter_application_1/student/stddetails.dart';

class Requesttabstd extends StatefulWidget {
  const Requesttabstd({super.key});

  @override
  State<Requesttabstd> createState() => _RequesttabstdState();
}

class _RequesttabstdState extends State<Requesttabstd> {
  List previous = ['Holi Festival', 'Halloween'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body: StreamBuilder(stream: FirebaseFirestore.instance.collection('stud_addevent ').snapshots(),
      builder: (context,AsyncSnapshot<QuerySnapshot> snapshot) {
        if(!snapshot.hasData){
          return Center(child: CircularProgressIndicator(),);
        }
      return Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
            var event=snapshot.data!.docs[index];
           return Padding(
             padding: const EdgeInsets.all(8.0),
             child: ListTile(
                tileColor: Color(0xFF3063A5),
                // title: Text(event['requestevent'],style: TextStyle(color: Colors.white),),
                onTap: () {
                 Navigator.push(context, MaterialPageRoute(builder: (context) => StdDetails(event:event),)) ;
                },
              ),
           );
            
          },
          ),
        );
        
      },),
      floatingActionButton: Container(
        height: 70,
        width: 70,
        child: FloatingActionButton(onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => Eventaddstd(),));
        },
        child: Icon(Icons.add,color: Colors.white,size: 40,),
        backgroundColor: Color(0xFF3063A5),
             shape: CircleBorder(),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}