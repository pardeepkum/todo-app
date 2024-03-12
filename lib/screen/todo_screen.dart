
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/model_class.dart';
import '../view_model/view_class.dart';

class TodoScreen extends StatelessWidget {
  const TodoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        title: const Text('Todo App',
        style: TextStyle(
          color: Colors.white,
          fontSize: 18
        ),
        ),
      ),
      body: const TodoList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddTodoDialog(context),
        tooltip: 'Add Todo',
        child: const Icon(Icons.add),
      ),
    );
  }

  // Function to show the dialog for adding a new Todo
  void _showAddTodoDialog(BuildContext context) {
    TextEditingController titleController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Todo'),
          content: TextField(
            controller: titleController,
            decoration: InputDecoration(labelText: 'Todo Title'),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {

                Todo newTodo = Todo(
                  id: '',
                  title: titleController.text,
                  completed: false,
                );


                await Provider.of<TodoViewModel>(context, listen: false).addTodo(newTodo);

                // Close the dialog
                Navigator.of(context).pop();
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }
}

class TodoList extends StatelessWidget {
  const TodoList({super.key});

  @override
  Widget build(BuildContext context) {
    var viewModel = Provider.of<TodoViewModel>(context);

    return StreamBuilder<List<Todo>>(
      stream: viewModel.getTodos(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Todo> todos = snapshot.data!;
          return ListView.builder(
            itemCount: todos.length,
            itemBuilder: (context, index) {
              return Card(
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: ListTile(
                  title: Text(todos[index].title),
                 // subtitle: Text(todos[index].completed ? 'Completed' : 'Incomplete'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () async {
                          await _editTodoDialog(context, todos[index]);
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () async {
                          await viewModel.deleteTodo(todos[index].id);
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }

  Future<void> _editTodoDialog(BuildContext context, Todo todo) async {
    TextEditingController titleController = TextEditingController(text: todo.title);
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Todo'),
          content: TextField(
            controller: titleController,
            decoration: const InputDecoration(labelText: 'Todo Title'),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                Todo editedTodo = Todo(
                  id: todo.id,
                  title: titleController.text,
                  completed: todo.completed,
                );
                await Provider.of<TodoViewModel>(context, listen: false).updateTodo(editedTodo);
                Navigator.of(context).pop();
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }
}


