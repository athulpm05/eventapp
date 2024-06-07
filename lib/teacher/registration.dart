// ignore_for_file: unnecessary_import, prefer_const_constructors, prefer_const_literals_to_create_immutables, depend_on_referenced_packages, non_constant_identifier_names, use_build_context_synchronously, unnecessary_cast

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/teacher/signin.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Registration extends StatefulWidget {
  const Registration({super.key});

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {

final TextEditingController nameController=TextEditingController();
final TextEditingController departmentController=TextEditingController();
final TextEditingController phoneController=TextEditingController();
final TextEditingController emailController=TextEditingController();
final TextEditingController passwordController=TextEditingController();

final GlobalKey<FormState>teacherkey=GlobalKey<FormState>();
//adding firebase to teachers data
Future<void>teacher_register()async{
  if(teacherkey.currentState!.validate()){
    try{
      UserCredential userCredential=await FirebaseAuth.instance.
      createUserWithEmailAndPassword(email: emailController.text,
       password: passwordController.text);

       String tid = userCredential.user!.uid;
       await FirebaseFirestore.instance.collection('teacher_reg').doc(tid).set({
        'name':nameController.text,
        'department':departmentController.text,
        'phone':phoneController.text,
        'email':emailController.text,
        'password':passwordController.text,
        'uid':tid,

       });
        Navigator.pushReplacement(context,
         MaterialPageRoute(builder:
          (context) => Signin(),));

    }on FirebaseAuthException catch (e){
      print("Failed to register teacher:$e");
      String errorMessage = "registration failed.${e.message}";

      if(e.code =="email-alredy-in -use"){
        errorMessage="Email is already in use. Please use a different email";
      }
      //flutter toast
      Fluttertoast.showToast(msg: errorMessage,);
    }catch(e){
      print("unexpected error during registration:$e");
      Fluttertoast.showToast(msg: "unexpected error during registration" );
    }
  }
}
// Snackbar to show successful submission
  final SnackBar _snackBar = SnackBar(
    content: Text("Submit successful"),
    duration: Duration(seconds:3 ),
  );

@override
void dispose(){
  nameController.dispose();
  departmentController.dispose();
  phoneController.dispose();
  emailController.dispose();
  passwordController.dispose();
  super.dispose();
}
//
//
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: teacherkey,
            child: Column(
              children: [
                Center(child: Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Text('Registration',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                )
                ),
                // Row(
                //   children: [
                //     Padding(
                //       padding: const EdgeInsets.only(top: 40,left: 30),
                //       child: Text('Name',style: TextStyle(fontSize: 15),),
                //     ),
                //   ],
                // ),
                // Padding(
                //   padding: const EdgeInsets.only(top: 5),
                //   child: SizedBox(
                //     height: 45,
                //     width: 350,
                //     child: TextFormField(
                //       controller: nameController,
                //       validator: (value){
                //         if (value == null || value.isEmpty) {
                //           return "Enter your user name";
                //         }
                //         return null;
                //       },
                //       decoration: InputDecoration(border: OutlineInputBorder()),
                //     ),
                //   ),
                // ),
                //  Row(
                //   children: [
                //     Padding(
                //       padding: const EdgeInsets.only(top: 20,left: 30),
                //       child: Text('Department',style: TextStyle(fontSize: 15),),
                //     ),
                //   ],
                // ),
                // Padding(
                //   padding: const EdgeInsets.only(top: 5),
                //   child: SizedBox(
                //     height: 45,
                //     width: 350,
                //     child: TextFormField(
                //       controller: departmentController,
                //       validator: (value){
                //         if (value == null || value.isEmpty) {
                //           return "Enter your department";
                //         }
                //         return null;
                //       },
                //       decoration: InputDecoration(border: OutlineInputBorder()),
                //     ),
                //   ),
                // ),
                //  Row(
                //   children: [
                //     Padding(
                //       padding: const EdgeInsets.only(top: 20,left: 30),
                //       child: Text('Phone No',style: TextStyle(fontSize: 15),),
                //     ),
                //   ],
                // ),
                // Padding(
                //   padding: const EdgeInsets.only(top: 5),
                //   child: SizedBox(
                //     height: 45,
                //     width: 350,
                //     child: TextFormField(
                //       controller:phoneController,
                //       validator: (value){
                //         if (value == null || value.isEmpty) {
                //           return "Enter your  phone number";
                //         }
                //         return null;
                //       },
                //       decoration: InputDecoration(border: OutlineInputBorder()),
                //     ),
                //   ),
                // ),
                //  Row(
                //   children: [
                //     Padding(
                //       padding: const EdgeInsets.only(top: 20,left: 30),
                //       child: Text('Email',style: TextStyle(fontSize: 15),),
                //     ),
                //   ],
                // ),
                // Padding(
                //   padding: const EdgeInsets.only(top: 5),
                //   child: SizedBox(
                //     height: 45,
                //     width: 350,
                //     child: TextFormField(
                //       controller: emailController,
                //       validator: (value) {
                //   if (value!.isEmpty || !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value)) {
                //     return 'Please enter a valid email';
                //   }
                //   return null;
                // },
                //       decoration: InputDecoration(border: OutlineInputBorder()),
                //     ),
                //   ),
                // ),
                //  Row(
                //   children: [
                //     Padding(
                //       padding: const EdgeInsets.only(top: 20,left: 30),
                //       child: Text('Password',style: TextStyle(fontSize: 15),),
                //     ),
                //   ],
                // ),
                // Padding(
                //   padding: const EdgeInsets.only(top: 5),
                //   child: SizedBox(
                //     height: 45,
                //     width: 350,
                //     child: TextFormField(
                //       controller: passwordController,
                //       validator: (value) {
                //   if (value!.isEmpty) {
                //     return 'Please enter password';
                //   } else if (value.length < 6) {
                //     return 'Password should be at least 6 characters';
                //   }
                //   return null;
                // },
                //       decoration: InputDecoration(border: OutlineInputBorder()),
                //     ),
                  // ),
                // ),
                
                //build textfield
                buildTextField("Name",nameController,"please enter name"),
                buildTextField("Department", departmentController, "Please enter department"),
                buildTextField("Phone", phoneController, "please enter your phonr number"),
                buildTextField("Email", emailController, "please enter your email id",
                validator: (value) {
                  if (value!.isEmpty || !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value)) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },),
                buildTextField("Password", passwordController, "please enter your password",
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter password';
                  } else if (value.length < 6) {
                    return 'Password should be at least 6 characters';
                  }
                  return null;
                },),
                //inkwell button

                Padding(
                  padding: const EdgeInsets.only(top: 80 ),
                  child: InkWell(
                    onTap: () async{
                      await teacher_register();
                     ScaffoldMessenger.of(context).showSnackBar(_snackBar);

                    },
                    child: Container(
                      height: 50,
                      width: 320,
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
   //define buildtextfield 
   Widget buildTextField(String labelText,TextEditingController controller,
   String errorMessage,
   {bool obscureText = false,FormFieldValidator<String>?validator}){
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: Column(children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10,left: 30),
              child: Text(
                      labelText,
                      style: TextStyle(fontSize: 15),
                      ),
            )],
        ),
        SizedBox(
          width: 320,
          child: TextFormField(
            controller: controller,
            obscureText: obscureText,
            decoration: InputDecoration(border:OutlineInputBorder()),
            validator: validator??(value){
              if(value?.isEmpty??true){
                return errorMessage;
              }
              return null;
            },
          ),
        )
      ],
      ),
    );
   }
}