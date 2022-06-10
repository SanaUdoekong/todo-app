import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_todo/core/logger.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../core/models/todo.dart';

class CompletedViewModel extends BaseViewModel {
  Logger log;

  CompletedViewModel() {
    this.log = getLogger(this.runtimeType.toString());
  }

  static ValueNotifier<List<Todo>> _completedTodos = ValueNotifier([]);

  final completedTodos = _completedTodos.value;

  void moveToPendingSnackbar() {
    SnackbarService().showSnackbar(message: 'Moved to pending successfully!');
  }

  void deleteTodoSnackbar() {
    SnackbarService()
                    .showSnackbar(message: 'Deleted successfully!');
  }
}
