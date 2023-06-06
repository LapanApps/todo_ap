import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/theme_provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final db = FirebaseFirestore.instance;
  late CollectionReference collectionReference;

  @override
  void initState() {
    super.initState();

    // point to our collection name in Firebase Console
    collectionReference = db.collection("my todos");
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(builder: (context, themeSetting, _) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("My TODO App"),
          actions: [
            Switch.adaptive(
                value: themeSetting.isDarkMode,
                onChanged: (bool newValue) {
                  themeSetting.isDarkMode = newValue;
                }),
          ],
        ),
        body: StreamBuilder(
            // get all the documents (all the todo items)
            stream: collectionReference.snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot<Object?>> snapshot) {
              if (!snapshot.hasData) {
                // if data on laoded yet, display a loading indicator
                return const LinearProgressIndicator();
              }

              var documents = snapshot.data as QuerySnapshot;

              // Actually get all the todo items
              var todoItems = documents.docs;

              // sort the items so that the latest todo item is at the bottom
              todoItems.sort((a, b) {
                var aDateTime = a["dateTime"] as Timestamp;
                var bDateTime = b["dateTime"] as Timestamp;
                return aDateTime.compareTo(bDateTime);
              });

              return ListView.builder(
                itemCount: todoItems.length,
                itemBuilder: (context, index) {
                  // Extract the title and dateTime from the todo item
                  // by its index.
                  // The todoItems is just a Map (or key value pair)
                  // so to access it just give it a key
                  var todoTitle = todoItems[index]["title"];
                  var todoDateTime = todoItems[index]["dateTime"] as Timestamp;
                  return Card(
                    margin: const EdgeInsets.all(4),
                    // some choices
                    // ContinousRectangeBorder
                    // CircleBorder
                    // StarBorder
                    // StadiumBorder
                    shape: BeveledRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      title: Text(todoTitle),
                      subtitle: Text(todoDateTime.toDate().toString()),
                      trailing: IconButton(
                        onPressed: () {
                          // delete the todo item from firestore
                          setState(() {
                            collectionReference
                                .doc(todoItems[index].id)
                                .delete();
                          });
                        },
                        tooltip: "Delete todo item",
                        icon: const Icon(Icons.delete),
                      ),
                    ),
                  );
                },
              );
            }),
        floatingActionButton: FloatingActionButton(
          tooltip: "Add a todo",
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) {
                  TextEditingController controller = TextEditingController();
                  return AlertDialog(
                    title: const Text("Add a todo"),
                    content: TextField(
                      controller: controller,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        hintText: "eg: Walk the cat",
                        labelText: "Todo item",
                      ),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () async {
                          // ignore if empty
                          if (controller.text.isEmpty) {
                            return;
                          }

                          // add to firestore document
                          collectionReference.doc().set({
                            "title": controller.text,
                            "dateTime": DateTime.now()
                          });

                          // notify UI to refresh
                          setState(() {});

                          // close the dialog
                          Navigator.pop(context);
                        },
                        child: const Text("Save"),
                      ),
                    ],
                  );
                });
          },
          child: const Icon(Icons.add),
        ),
      );
    });
  }
}
