import 'package:flutter/material.dart';
import 'package:todo_app_5stack/home_page.dart';
import 'package:todo_app_5stack/utils/todo_note.dart';

class GroupPage extends StatefulWidget {
  const GroupPage({super.key});

  @override
  State<GroupPage> createState() => _GroupPageState();
}

class _GroupPageState extends State<GroupPage> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blue.shade100,
        appBar: AppBar(
          title: Text('Groups'),
          centerTitle: true, // Aligns the title in the center
          backgroundColor: Colors.indigo,
          foregroundColor: Colors.lightBlue.shade200,
          leading: BackButton(
            onPressed: () {
              Navigator.pop(context);
              //assign current group here
            },
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: HomePage.filteredGroups.length,
                itemBuilder: (BuildContext context, index) {
                  return Placeholder(); //temporary
                },
              ),
            ),
          ],
        ),
    );
  }
}