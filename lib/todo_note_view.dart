import 'package:flutter/material.dart';
import 'package:todo_app_5stack/utils/todo_note.dart';

class TodoNoteView extends StatefulWidget {

  TodoNote tn;
  TodoNoteView({
    super.key,
    required this.tn
    });

  @override
  State<TodoNoteView> createState() => _TodoNoteViewState();
}

class _TodoNoteViewState extends State<TodoNoteView> {

  TextEditingController _contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blue.shade100,
        appBar: AppBar(
          title: Text(widget.tn.taskName),
          centerTitle: true, // Aligns the title in the center
          backgroundColor: Colors.indigo,
          foregroundColor: Colors.lightBlue.shade200,
          leading: BackButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                widget.tn.content = _contentController.text;
              });
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: ListView(
          children: [
            TextField(
              cursorColor: Colors.black,
              controller: _contentController = TextEditingController(text: widget.tn.content),
              style: TextStyle(color: Colors.black, fontSize: 15),
              maxLines: null,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Start wrtiting notes!',
                  hintStyle: TextStyle(color: Colors.black, fontSize: 15)),
            ),
          ],
        ),
      )
    );
  }
}