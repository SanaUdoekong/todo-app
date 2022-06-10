import 'package:flutter_todo/views/completed/completed_view_model.dart';

import '../../views/home/home_view_model.dart';

class TodoLists {
  final todos = HomeViewModel().todos;
  final completedTodos = CompletedViewModel().completedTodos;

}
