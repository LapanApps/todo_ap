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
        title: const Text("My TODO App"),
      ),
      body: ListView.builder(
        itemCount: itemsTodo.length,
        itemBuilder: (context, index) {
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
              // tileColor: Colors.red.shade100,
              title: Text(itemsTodo[index]),
              trailing: IconButton(
                onPressed: () {
                  setState(() {
                    itemsTodo.remove(itemsTodo[index]);
                  });
                },
                icon: const Icon(Icons.delete),
              ),
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
                  title: const Text("Add a todo"),
                  content: TextField(
                    controller: _controller,
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
                      onPressed: () {
                        // Add item to the todo items
                        // and notify UI
                        setState(() {
                          itemsTodo.add(_controller.text);
                        });

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
  }
}
