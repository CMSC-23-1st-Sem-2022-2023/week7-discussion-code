/*
  Created by: Claizel Coubeili Cepe
  Date: 27 October 2022
  Description: Sample todo app with networking
*/

import 'package:flutter/material.dart';
import 'package:week7_networking_discussion/api/firebase_todo_api.dart';
import 'package:week7_networking_discussion/api/todo_api.dart';
import 'package:week7_networking_discussion/models/todo_model.dart';

class TodoListProvider with ChangeNotifier {
  late TodoAPI todoAPI;
  // Todo list is now a Future
  late Future<List<Todo>> _todoList;
  late FirebaseTodoAPI firebaseService;

  TodoListProvider() {
    todoAPI = TodoAPI();
    fetchTodos();
    firebaseService = FirebaseTodoAPI();
  }

  // getter
  Future<List<Todo>> get todo => _todoList;

  void fetchTodos() {
    _todoList = todoAPI.fetchTodos();
    notifyListeners();
  }

  void addTodo(Todo item) async {
    String message = await firebaseService.addTodo(item.toJson(item));
    print(message);
    notifyListeners();
  }

  void editTodo(int index, String newTitle) {
    // _todoList[index].title = newTitle;
    print("Edit");
    notifyListeners();
  }

  void deleteTodo(String title) {
    // for (int i = 0; i < _todoList.length; i++) {
    //   if (_todoList[i].title == title) {
    //     _todoList.remove(_todoList[i]);
    //   }
    // }
    print("Delete");
    notifyListeners();
  }

  void toggleStatus(int index, bool status) {
    // _todoList[index].completed = status;
    print("Toggle Status");
    notifyListeners();
  }
}
