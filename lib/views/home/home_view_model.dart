import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:flutter_todo/core/logger.dart';

import '../../core/models/todo.dart';
import 'home_view.dart';

class HomeViewModel extends BaseViewModel {
  Logger log;

  HomeViewModel() {
    this.log = getLogger(this.runtimeType.toString());
  }

  String title = 'Untitled';
  String description = 'No description given';

  static ValueNotifier<List<Todo>> todoList = ValueNotifier([]);

  final todos = todoList.value;

  void addTodo(Todo todo) {
    todoList.value.add(todo);
    notifyListeners();
    todo.id = todos.indexOf(todo);
  }

  Future<dynamic> addTask(BuildContext context, HomeViewModel viewModel) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add a new todo item'),
          content: SizedBox(
            height: 100,
            child: Column(
              children: [
                TextField(
                  controller: TextEditingController(),
                  decoration: const InputDecoration(hintText: 'Title'),
                  onChanged: (value) {
                    viewModel.title = value;
                    notifyListeners();
                  },
                  onEditingComplete: () {
                    TextInputAction.next;
                  },
                ),
                TextField(
                  controller: TextEditingController(),
                  decoration: const InputDecoration(
                    hintText: 'Enter a detailed description',
                  ),
                  onChanged: (value) {
                    viewModel.description = value;
                    notifyListeners();
                  },
                  onEditingComplete: () {
                    TextInputAction.done;
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: const Text('Add'),
              onPressed: () {
                Navigator.pop(context);
                viewModel.addTodo(
                  Todo(
                    title: (viewModel.title),
                    description: viewModel.description,
                    id: 0,
                  ),
                );
                notifyListeners();
                SnackbarService()
                    .showSnackbar(message: 'Todo added successfully!');
              },
            ),
            TextButton(
              child: const Text(
                'Cancel',
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }

  void moveToCompletedSnackbar() {
    SnackbarService().showSnackbar(message: 'Moved to archive successfully!');
  }

  void deleteTodoSnackbar() {
    SnackbarService().showSnackbar(message: 'Todo removed successfully!');
  }
}
