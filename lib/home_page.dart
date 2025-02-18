import 'package:flutter/material.dart';
import 'package:todo_app_5stack/group_page.dart';
import 'package:todo_app_5stack/utils/search_field.dart';
import 'package:todo_app_5stack/utils/todo_note.dart';

class HomePage extends StatefulWidget {

  static List groupList = ['Main'];
  static List filteredGroups = [];
  static String currentGroup = 'Main';
  
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final TextEditingController _titleController = TextEditingController();

  List todoNoteList = [];
  List filteredTodoNoteList = [];
  TextEditingController _contentController = TextEditingController();
  // TextEditingController _folderName = TextEditingController();
  // bool isMoving = false;

  // fillNoteList(){
  //   setState(() {
  //     filteredNotes = noteBox.values.where((note) => note.folder == cf).toList();
  //   });
  // }

  // fillFolderList(){
  //   setState(() {
  //     filteredFolders = folderBox.values.toList();
  //   });
  // }

  // checkFolderBox(){
  //   if(folderBox.isEmpty) {
  //     setState(() {
  //       folderBox.put(0, 'Notes');
  //     });
  //   }
  // }

  @override
  void initState(){
    super.initState();
  }

  void onSearchTextChanged(String searchText) {
    setState(() {
      if(searchText.isNotEmpty) {
          filteredTodoNoteList = todoNoteList
        .where((todonote) =>
            (todonote.taskName.toLowerCase().contains(searchText.toLowerCase()) ||
            (todonote.content.toLowerCase().contains(searchText.toLowerCase())) && 
            (todonote.groupName == HomePage.currentGroup)))
        .toList();
      }
      else {
        filteredTodoNoteList = todoNoteList;
      }
    });
  }

  void newTask(){
    setState(() {
      todoNoteList.add(
        TodoNote(
          taskName: _titleController.text, taskState: false,
          deleteItem: deleteTask, groupName: HomePage.currentGroup
          )
      );
      _titleController.clear();
      filteredTodoNoteList = todoNoteList;
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
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => GroupPage())
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
