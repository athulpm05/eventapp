// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, non_constant_identifier_names, depend_on_referenced_packages, unnecessary_import, unused_field, avoid_print, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/student/loginpage.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Regstudent extends StatefulWidget {
  const Regstudent({super.key});

  @override
  State<Regstudent> createState() => _RegstudentState();
}

class _RegstudentState extends State<Regstudent> {
  // Controllers for form fields
  final TextEditingController nameController = TextEditingController();
  final TextEditingController departmentController = TextEditingController();
  final TextEditingController regNoController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Future<void> registerStudent() async {
    if (formKey.currentState!.validate()) {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: emailController.text, password: passwordController.text);

        String uid = userCredential.user!.uid;
        await FirebaseFirestore.instance.collection("student_reg").doc(uid).set({
          'name': nameController.text,
          'department': departmentController.text,
          'reg_no': regNoController.text,
          'phone': phoneController.text,
          'email': emailController.text,
          'pass':passwordController.text,
          'uid': uid,
        });

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => StudentSignIn()),
        );
      } on FirebaseAuthException catch (e) {
        print('Failed to register user: $e');
        String errorMessage = "Registration failed. ${e.message}";

        if (e.code == "email-already-in-use") {
          errorMessage =
              "Email is already in use. Please use a different email";
        }

        Fluttertoast.showToast(
          msg: errorMessage,
        );
      } catch (e) {
        print('Unexpected error during registration: $e');
        Fluttertoast.showToast(
          msg: "Unexpected error during registration",
        );
      }
    }
  }

  // Snackbar to show successful submission
  final SnackBar _snackBar = SnackBar(
    content: Text("Submit successful"),
    duration: Duration(seconds: 4),
  );

  @override
  void dispose() {
    // Dispose controllers to free up resources
    nameController.dispose();
    departmentController.dispose();
    regNoController.dispose();
    phoneController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(Icons.arrow_back_ios),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 80),
                          child: Text(
                            'Registration',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                buildTextField('Name', nameController, 'Please enter name'),
                buildTextField('Department', departmentController, 'Please enter department'),
                buildTextField('Reg no', regNoController, 'Please enter register number'),
                buildTextField('Phone No', phoneController, 'Please enter phone number'),
                buildTextField('Email', emailController, 'Please enter email',
                 validator: (value) {
                  if (value!.isEmpty || !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value)) {
                    return 'Please enter a valid email';
                  }
                  return null;
                }),
                buildTextField('Password', passwordController, 'Please enter password', obscureText: true, 
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter password';
                  } else if (value.length < 6) {
                    return 'Password should be at least 6 characters';
                  }
                  return null;
                }),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: InkWell(
                    onTap: () async {
                      await registerStudent();
                      ScaffoldMessenger.of(context).showSnackBar(_snackBar);
                    },
                    child: Container(
                      height: 50,
                      width: 320,
                      decoration: BoxDecoration(
                        color: Color(0xFF3063A5),
                        borderRadius: BorderRadius.circular(7),
                      ),
                      child: Center(
                        child: Text(
                          'Submit',
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Reusable widget for text fields
  Widget buildTextField(String labelText,
   TextEditingController controller,
    String errorMessage, 
    {bool obscureText = false, FormFieldValidator<String>? validator}) {
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 30),
                child: Text(
                  labelText,
                  style: TextStyle(fontSize: 15),
                ),
              ),
            ],
          ),
          SizedBox(
            width: 320,
            child: TextFormField(
              controller: controller,
              obscureText: obscureText,
              decoration: InputDecoration(border: OutlineInputBorder()),
              validator: validator ?? (value) {
                if (value?.isEmpty ?? true) {
                  return errorMessage;
                }
                return null;
              },
            ),
          ),
        ],
      ),
    );
  }
}
