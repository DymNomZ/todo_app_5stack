import 'package:flutter/material.dart';
import 'package:todo_app_5stack/group_page.dart';
import 'package:todo_app_5stack/utils/search_field.dart';
import 'package:todo_app_5stack/utils/todo_note.dart';

class HomePage extends StatefulWidget {

  //I made it static since there's only one groupList and GroupPage will refer to it
  static List groupList = ['Main'];
  
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final TextEditingController _titleController = TextEditingController();

  List todoNoteList = [];
  List filteredTodoNoteList = [];
  TextEditingController _contentController = TextEditingController();
  String currentGroup = 'Main'; // new Todos will base their current group on this variable

  //loads the notes of the current group
  fillTodoNoteList(int index){
    setState(() {
      currentGroup = HomePage.groupList[index];
      filteredTodoNoteList = todoNoteList.where((todonote) => todonote.groupName == currentGroup).toList();
    });
  }

  @override
  void initState(){
    super.initState();
  }

  //filters todonotes which contains the search text
  void onSearchTextChanged(String searchText) {
    setState(() {
      if(searchText.isNotEmpty) {
          filteredTodoNoteList = todoNoteList
        .where((todonote) =>
            (todonote.taskName.toLowerCase().contains(searchText.toLowerCase()) ||
            (todonote.content.toLowerCase().contains(searchText.toLowerCase())) && 
            (todonote.groupName == currentGroup)))
        .toList();
      }
      else {
        loadListOfGroup();
      }
    });
  }
  
  //ensures that the todonotes loaded will only be of that group
  void loadListOfGroup() {
    filteredTodoNoteList = todoNoteList
        .where((todonote) =>
            (todonote.groupName == currentGroup))
        .toList();
  }

  void newTask(){
    setState(() {
      todoNoteList.add(
        TodoNote(
          taskName: _titleController.text, taskState: false,
          deleteItem: deleteTask, groupName: currentGroup
          )
      );
      _titleController.clear();
      loadListOfGroup();
    });
  }

  void deleteTask(TodoNote tn){
    setState(() {
      todoNoteList.remove(tn);
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
          leading: IconButton(
            onPressed: () {
              //Flutter class that handles the navigation of pages, very neat
              //push well, puts the screen on top of the stack so that is what you'll see next
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => GroupPage(fillTodoNoteList: fillTodoNoteList))
              );
            },
            icon: Icon(
              Icons.folder_open,
              color: Colors.black,
              size: 20
            )
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: SearchField(onChanged: onSearchTextChanged)
            ),
            Expanded(
              child: ListView.builder(
                itemCount: filteredTodoNoteList.length,
                itemBuilder: (BuildContext context, index) {
                  //cleaner, so that no redundnat instances of the TodoNote class
                  TodoNote tn = filteredTodoNoteList[index];
                  return tn;
                },
              ),
            ),
          ],
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
                      controller: _titleController,
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
