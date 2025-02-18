import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo_app_5stack/todo_note_view.dart';

class TodoNote extends StatefulWidget {

  TodoNote(
      {super.key,
      required this.taskName,
      required this.groupName,
      required this.taskState,
      required this.deleteItem});

  String taskName;
  String content = "";
  String groupName;
  bool taskState;
  Function(TodoNote) deleteItem;

  @override
  State<TodoNote> createState() => _TodoNoteState();
}

class _TodoNoteState extends State<TodoNote> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 0),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => TodoNoteView(tn: widget))
          );
        },
        child: Slidable(
          endActionPane: ActionPane(
              motion: StretchMotion(),
              children: [
                SlidableAction(
                  onPressed: (context) {
                    setState(() {
                      widget.deleteItem(widget);
                    });
                  },
                  icon:Icons.delete,
                  borderRadius: BorderRadius.circular(15),
                  backgroundColor: Colors.redAccent.shade200,
                ),
              ]
          ),
          child: Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.deepPurple, // Keeps only BoxDecoration's color
              borderRadius: BorderRadius.circular(17),
            ),
            child: Row(
              children: [
                Checkbox(
                  value: widget.taskState,
                  onChanged: (value) {
                    setState(() {
                      widget.taskState = !widget.taskState;
                    });
                  },
                  checkColor: Colors.black,
                  activeColor: Colors.white,
                  side: BorderSide(
                    color: Colors.white,
                  ),
                  // checkColor: Colors.white,
                ),
                Text(
                  widget.taskName,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    decoration: widget.taskState ? TextDecoration.lineThrough : TextDecoration.none,
                    decorationColor: Colors.redAccent,
                    decorationThickness: 2,
                  ),
                ),
              ],
            ),
          ),
        ),
      )

    );
  }
}
