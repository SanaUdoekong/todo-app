import 'package:flutter/material.dart';
import 'package:flutter_todo/core/models/todo_lists.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../core/models/todo.dart';
import '../completed/completed_view.dart';
import 'home_view_model.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      builder: (BuildContext context, HomeViewModel viewModel, Widget _) {
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: const Text('To-dos'),
            actions: [
              PopupMenuButton(
                icon: const Icon(Icons.archive),
                itemBuilder: (context) {
                  return [
                    const PopupMenuItem<int>(
                      value: 0,
                      child: Text('Completed To-Dos'),
                    ),
                  ];
                },
                onSelected: (value) {
                  if (value == 0) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CompletedView()),
                    );
                  }
                },
              ),
            ],
          ),
          body: getTodos(),
          floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () {
              viewModel.addTask(context, viewModel);
            },
          ),
        );
      },
      viewModelBuilder: () => HomeViewModel(),
    );
  }


  Widget getTodos() {
    return ViewModelBuilder<HomeViewModel>.reactive(
      builder: (BuildContext context, HomeViewModel viewModel, Widget _) {
        if (viewModel.todos.isEmpty) {
          return const Padding(
            padding: EdgeInsets.all(12.0),
            child: Center(
              child: Text(
                  "Click on the '+' button to create new todos. Swipe right to delete todos."),
            ),
          );
        } else {
          return ListView.builder(
            itemBuilder: (context, i) {
              final Todo todo = viewModel.todos[i];
              return Dismissible(
                key: Key(todo.title),
                onDismissed: (none) {
                  viewModel.todos.removeAt(i);
                  viewModel.deleteTodoSnackbar();
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Card(
                    elevation: 4,
                    child: ListTile(
                      title: Text(todo.title),
                      subtitle: Text(todo.description),
                      trailing: IconButton(
                          icon: const Icon(Icons.check_box_outline_blank),
                          onPressed: () {
                            setState(() {
                              todo.isCompleted = true;
                              TodoLists().completedTodos.add(
                                    Todo(
                                      title: todo.title,
                                      description: todo.description,
                                      id: 0,
                                    ),
                                  );
                              viewModel.todos.removeAt(i);
                              viewModel.moveToCompletedSnackbar();
                            });
                          }),
                    ),
                  ),
                ),
              );
            },
            itemCount: viewModel.todos.length,
          );
        }
      },
      viewModelBuilder: () => HomeViewModel(),
    );
  }
}
