/*
  Created by: Claizel Coubeili Cepe
  Date: 27 October 2022
  Description: Sample todo app with networking
*/

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:week7_networking_discussion/models/todo_model.dart';
import 'package:week7_networking_discussion/providers/todo_provider.dart';
import 'package:week7_networking_discussion/screens/modal_todo.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  @override
  Widget build(BuildContext context) {
    // access the list of todos in the provider
    List<Todo> todoList = context.watch<TodoListProvider>().todo;

    return Scaffold(
      appBar: AppBar(
        title: Text("Todo"),
      ),
      body: ListView.builder(
        itemCount: todoList.length,
        itemBuilder: ((context, index) {
          final todo = todoList[index];
          return Dismissible(
            key: Key(todo.id.toString()),
            onDismissed: (direction) {
              // Delete item when swiped
              context.read<TodoListProvider>().deleteTodo(todo.title);

              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('${todo.title} dismissed')));
            },
            background: Container(
              color: Colors.red,
              child: const Icon(Icons.delete),
            ),
            child: ListTile(
              title: Text(todo.title),
              leading: Checkbox(
                value: todo.completed,
                onChanged: (bool? value) {
                  context.read<TodoListProvider>().toggleStatus(index, value!);
                },
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) => TodoModal(
                          type: 'Edit',
                          todoIndex: index,
                        ),
                      );
                    },
                    icon: const Icon(Icons.create_outlined),
                  ),
                  IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) => TodoModal(
                          type: 'Delete',
                          todoIndex: index,
                        ),
                      );
                    },
                    icon: const Icon(Icons.delete_outlined),
                  )
                ],
              ),
            ),
          );
        }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) => TodoModal(
              type: 'Add',
              todoIndex: -1, // Flag to identify that this particular modal is for add
            ),
          );
        },
        child: const Icon(Icons.add_outlined),
      ),
    );
  }
}
