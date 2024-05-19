// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class StdDetails extends StatefulWidget {
  const StdDetails({super.key});

  @override
  State<StdDetails> createState() => _StdDetailsState();
}

class _StdDetailsState extends State<StdDetails> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
     body: SafeArea(
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
                      'Student Detail',
                      style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500 ),
                    ),
                  ],
                ),
              )),
              Padding(
                padding: const EdgeInsets.only(top: 10,bottom: 5),
                child: Image(
                  height: 100,
                  width: 100,
                  image: AssetImage('images/person1.png')),
              ),
              Text('Anandhu',style: TextStyle(fontSize: 16),),
             Padding(
               padding: const EdgeInsets.only(top: 20),
               child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Department'),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Text('Request Event'),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Text('Date'),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Text('Time'),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Text('Location'),
                      )
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(':'),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Text(':'),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Text(':'),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Text(':'),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Text(':'),
                      )
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text('Bcom'),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Text('Holi Festival'),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Text('25/03/2025'),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top:10),
                        child: Text('10.00'),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Text('College Hall'),
                      )
                    ],
                  )
                ],
               ),
             ),
             Column(
               children: [
                 Row(
                          children: [
                            Padding(
                 padding: const EdgeInsets.only(top: 20,left: 20),
                 child: Text('Host ',style: TextStyle(fontSize: 16,color: Color(0xFF3063A5),),),
                            ),
                          ],
                        ),
               ],
             ),
        Padding(
          padding: const EdgeInsets.only(top: 5,left: 20,right: 20),
          child: ListTile(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
                          textColor: Colors.black,
                          tileColor: Color.fromRGBO(68, 114, 178, 0.2),

                          leading: Image(
                            height: 40,
                            width: 40,
                            image: AssetImage('images/person.png')),
                          title: Text('Host'),
                          subtitle: Text('Department'),
                          
                        ),
        ),
           Row(
         children: [
           Padding(
             padding: const EdgeInsets.only(top: 20,left: 20),
             child: Text('Description  :',style: TextStyle(fontSize: 16),),
           ),
         ],
       ),
       Padding(
         padding: const EdgeInsets.only(top: 10,left: 20,right: 20),
         child: Text('Corem ipsum dolor sit amet, consectetur adipiscing elit. Nunc vulputate libero et velit interdum, ac aliquet odio mattis. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Curabitur tempus urna at turpis condimentum lobortis.'),
       ),    
              
          ],
        ),
      ),
    );
  }
}