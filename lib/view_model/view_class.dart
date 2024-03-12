
import 'package:flutter/material.dart';
import 'package:todo_app/model/model_class.dart';

import '../repositry/repositry_class.dart';


class TodoViewModel extends ChangeNotifier {
  final TodoRepository _repository = TodoRepository();

  Stream<List<Todo>> getTodos() => _repository.getTodos();

  Future<void> addTodo(Todo todo) async {
    await _repository.addTodo(todo);
    notifyListeners();
  }

  Future<void> updateTodo(Todo todo) async {
    await _repository.updateTodo(todo);
    notifyListeners();
  }

  Future<void> deleteTodo(String todoId) async {
    await _repository.deleteTodo(todoId);
    notifyListeners();
  }
}
