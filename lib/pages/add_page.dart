import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddPage extends StatefulWidget {
  const AddPage({Key? key}) : super(key: key);

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final _fromkey = GlobalKey<FormState>();

  var name = '';
  var email = '';

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  CollectionReference students =
      FirebaseFirestore.instance.collection('students');
  Future<void> addUser() {
    return students
        .add({'name': name, 'email': email})
        .then((value) => print('User Add'))
        .catchError((erroe) => print('Failed to Add user: $erroe'));
    //  print('User Added');
  }

  cleartext() {
    nameController.clear();
    emailController.clear();
  }

  // void dispose() {
  //   nameController.dispose();
  //   emailController.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add'),
      ),
      body: Form(
        key: _fromkey,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: TextFormField(
                    autofocus: false,
                    decoration: const InputDecoration(
                        labelText: 'Name',
                        labelStyle: TextStyle(fontSize: 20),
                        border: OutlineInputBorder(),
                        errorStyle: TextStyle(color: Colors.red, fontSize: 15)),
                    controller: nameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter Name';
                      }
                      return null;
                    }),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: TextFormField(
                    autofocus: false,
                    decoration: const InputDecoration(
                        labelText: 'Email',
                        labelStyle: TextStyle(fontSize: 20),
                        border: OutlineInputBorder(),
                        errorStyle: TextStyle(color: Colors.red, fontSize: 15)),
                    controller: emailController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter Email';
                      } else if (!value.contains('@')) {
                        return 'Please Enter Valid Email';
                      }
                      return null;
                    }),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      if (_fromkey.currentState!.validate()) {
                        setState(
                          () {
                            name = nameController.text;
                            email = emailController.text;
                            addUser();
                            Navigator.pop(context);
                            cleartext();
                          },
                        );
                      }
                    },
                    child: const Center(
                      child: Text('Submit'),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      cleartext();
                    },
                    child: const Center(
                      child: Text('Reset'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
