import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo_app_5stack/home_page.dart';

class GroupPage extends StatefulWidget {

  Function(int) fillTodoNoteList;
  GroupPage({super.key, required this.fillTodoNoteList});

  @override
  State<GroupPage> createState() => _GroupPageState();
}

class _GroupPageState extends State<GroupPage> {

  TextEditingController _groupNameController = TextEditingController();

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
              //pops the current screen, mimics "going back" to the previous screen you've been to
              Navigator.pop(context);
            },
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: HomePage.groupList.length,
                itemBuilder: (BuildContext context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 0),
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                        setState(() {
                          widget.fillTodoNoteList(index); 
                        });
                        
                      },
                      child: Slidable(
                        endActionPane: ActionPane(
                            motion: StretchMotion(),
                            children: [
                              SlidableAction(
                                onPressed: (context) {
                                  setState(() {
                                    HomePage.groupList.removeAt(index);
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
                              Text(
                                HomePage.groupList[index],
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
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
                      controller: _groupNameController,
                      decoration: InputDecoration(
                        hintText: 'What will be the new group name?',
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
                  onPressed: () {
                    setState(() {
                      HomePage.groupList.add(_groupNameController.text);
                    });
                  },
                  child: Icon(Icons.add),
                ),
              ],
            )
        )
    );
  }
}