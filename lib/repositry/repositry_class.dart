import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_app/model/model_class.dart';

class TodoRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<Todo>> getTodos() {
    return _firestore.collection('todos').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return Todo(
          id: doc.id,
          title: data['title'] ?? '',
          completed: data['completed'] ?? false,
        );
      }).toList();
    });
  }

  Future<void> addTodo(Todo todo) {
    return _firestore.collection('todos').add(todo.toMap());
  }

  Future<void> updateTodo(Todo todo) {
    return _firestore.collection('todos').doc(todo.id).update(todo.toMap());
  }

  Future<void> deleteTodo(String todoId) {
    return _firestore.collection('todos').doc(todoId).delete();
  }
}
