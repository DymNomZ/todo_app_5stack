import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_app_5stack/utils/todo_list.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _controller = TextEditingController();
  List toDoList = [
    ['Learn These Shit', false],
    ['Drink', false],
    ['yawa', false],
  ];

  void checkBoxChanged(int idx){
    setState(() {
      toDoList[idx][1] = !toDoList[idx][1];
    });
  }

  void newTask(){
    setState(() {
      toDoList.add([_controller.text, false]);
      _controller.clear();
    });
  }

  void deleteTask(int idx){
    setState(() {
      toDoList.removeAt(idx);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blue.shade100,
        appBar: AppBar(
          title: Text('TODO'),
          centerTitle: true, // Aligns the title in the center
          backgroundColor: Colors.indigo,
          foregroundColor: Colors.lightBlue.shade200,
        ),
        body: ListView.builder(
          itemCount: toDoList.length,
          itemBuilder: (BuildContext context, index) {
            return TodoList(
              taskName: toDoList[index][0],
              taskState: toDoList[index][1],
              onChanged: (value) => checkBoxChanged(index),
              deleteItem: (context) => deleteTask(index),
            );
          },
        ),
        floatingActionButton: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20
                    ),
                    child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        hintText: 'What are you gonna do today?',
                        filled: true,
                        fillColor: Colors.blue.shade200,
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white,
                            ),
                            borderRadius:  BorderRadius.circular(17)
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white,
                            ),
                            borderRadius:  BorderRadius.circular(17)
                        ),
                      ),
                    ),
                  ),

                ),
                FloatingActionButton(
                  onPressed: newTask,
                  child: Icon(Icons.add),

                ),
              ],
            )
        )


    );
  }
}
