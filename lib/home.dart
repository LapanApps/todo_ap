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
        itemBuilder: (context, index) {
          return ListTile(
            title: Text("hello"),
            subtitle: Text("subtitle"),
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
                        itemsTodo.add(_controller.text);

                        print(itemsTodo);
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
