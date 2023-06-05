import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<String> itemsTodo = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My TODO App"),
      ),
      body: ListView.builder(
        itemCount: itemsTodo.length,
        itemBuilder: (context, index) {
          return ListTile(
            tileColor: Colors.red.shade100,
            title: Text(itemsTodo[index]),
            trailing: IconButton(
              onPressed: () {
                setState(() {
                  itemsTodo.remove(itemsTodo[index]);
                });
              },
              icon: Icon(Icons.delete),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                TextEditingController _controller = TextEditingController();
                return AlertDialog(
                  title: Text("Add a todo"),
                  content: TextField(
                    controller: _controller,
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        // Add item to the todo items
                        // and notify UI
                        setState(() {
                          itemsTodo.add(_controller.text);
                        });

                        // close the dialog
                        Navigator.pop(context);
                      },
                      child: Text("Save"),
                    ),
                  ],
                );
              });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
