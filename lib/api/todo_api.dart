import 'dart:async';

import 'package:week7_networking_discussion/models/todo_model.dart';
import 'package:http/http.dart' as http;

class TodoAPI {
  Future<List<Todo>> fetchTodos() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/todos'));

    if (response.statusCode == 200) {
      return Todo.fromJsonArray(response.body);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load todos');
    }
  }
}
