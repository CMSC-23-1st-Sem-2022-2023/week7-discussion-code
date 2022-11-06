/*
  Created by: Claizel Coubeili Cepe
  Date: 27 October 2022
  Description: Sample todo app with networking
*/

import 'package:flutter/material.dart';
import 'package:week7_networking_discussion/models/todo_model.dart';

class TodoListProvider with ChangeNotifier {
  List<Todo> _todoList = [
    Todo(
      completed: true,
      userId: 1,
      id: 1,
      title: "Grocery",
    ),
    Todo(
      completed: true,
      userId: 1,
      id: 2,
      title: "Bills",
    ),
    Todo(
      completed: false,
      userId: 1,
      id: 3,
      title: "Walk dog",
    ),
  ];

  // getter
  List<Todo> get todo => _todoList;

  void addTodo(Todo item) {
    _todoList.add(item);
    notifyListeners();
  }

  void editTodo(int index, String newTitle) {
    _todoList[index].title = newTitle;
    notifyListeners();
  }

  void deleteTodo(String title) {
    for (int i = 0; i < _todoList.length; i++) {
      if (_todoList[i].title == title) {
        _todoList.remove(_todoList[i]);
      }
    }
    notifyListeners();
  }

  void toggleStatus(int index, bool status) {
    _todoList[index].completed = status;
    notifyListeners();
  }
}
