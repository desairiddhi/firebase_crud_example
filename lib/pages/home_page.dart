import 'package:flutter/material.dart';

import 'add_page.dart';
import 'list_page.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Flutter CRUD'),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const AddPage()));
              },
              child: const Center(
                child: Text(
                  'Add',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
        body: const ListPage());
  }
}
