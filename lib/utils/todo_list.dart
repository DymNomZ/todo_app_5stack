import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TodoList extends StatelessWidget {
  const TodoList(
      {super.key,
      required this.taskName,
      required this.taskState,
      required this.onChanged,
      required this.deleteItem});

  final String taskName;
  final bool taskState;
  final Function(bool?)? onChanged;
  final Function(BuildContext)? deleteItem;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 0),
      child: Slidable(
        endActionPane: ActionPane(
            motion: StretchMotion(),
            children: [
              SlidableAction(
                onPressed: deleteItem,
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
                value: taskState,
                onChanged: onChanged,
                checkColor: Colors.black,
                activeColor: Colors.white,
                side: BorderSide(
                  color: Colors.white,
                ),
                // checkColor: Colors.white,
              ),
              Text(
                taskName,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  decoration: taskState ? TextDecoration.lineThrough : TextDecoration.none,
                  decorationColor: Colors.redAccent,
                  decorationThickness: 2,
                ),
              ),
            ],
          ),
        ),
      )

    );
  }
}
