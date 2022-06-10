import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../core/models/todo.dart';
import '../../core/models/todo_lists.dart';
import '../home/home_view.dart';
import 'completed_view_model.dart';

class CompletedView extends StatefulWidget {
  @override
  State<CompletedView> createState() => _CompletedViewState();
}

class _CompletedViewState extends State<CompletedView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CompletedViewModel>.reactive(
      builder: (BuildContext context, CompletedViewModel viewModel, Widget _) {
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: const Text('Completed to-dos'),
            actions: [
              PopupMenuButton(
                icon: const Icon(Icons.folder),
                itemBuilder: (context) {
                  return [
                    const PopupMenuItem<int>(
                      value: 0,
                      child: Text('Pending To-Dos'),
                    ),
                  ];
                },
                onSelected: (value) {
                  if (value == 0) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomeView()),
                    );
                  }
                },
              ),
            ],
          ),
          body: getTodos(),
        );
      },
      viewModelBuilder: () => CompletedViewModel(),
    );
  }

  Widget getTodos() {
    return ViewModelBuilder<CompletedViewModel>.reactive(
      builder: (BuildContext context, CompletedViewModel viewModel, Widget _) {
        if (viewModel.completedTodos.isEmpty) {
          return const Center(
            child: Text('You have not completed any todo yet!'),
          );
        } else {
          return ListView.builder(
            itemBuilder: (context, i) {
              final Todo todo = viewModel.completedTodos[i];
              return Dismissible(
                onDismissed: (none) {
                  viewModel.completedTodos.removeAt(i);
                  viewModel.deleteTodoSnackbar();
                },
                key: Key(todo.title),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Card(
                    elevation: 4,
                    child: ListTile(
                      title: Text(todo.title),
                      subtitle: Text(todo.description),
                      trailing: IconButton(
                        icon: const Icon(Icons.check_box),
                        onPressed: () {
                          setState(() {
                            todo.isCompleted = false;
                            TodoLists().todos.add(
                                  Todo(
                                      title: todo.title,
                                      description: todo.description,
                                      id: i),
                                );
                            viewModel.completedTodos.removeAt(i);
                            viewModel.moveToPendingSnackbar();
                          });
                        },
                      ),
                    ),
                  ),
                ),
              );
            },
            itemCount: viewModel.completedTodos.length,
          );
        }
      },
      viewModelBuilder: () => CompletedViewModel(),
    );
  }
}
