part of 'todo_bloc.dart';

@immutable
abstract class TodoEvent {}

class AddTodoEvent extends TodoEvent {
  final ToDoModel toDoModel;

  AddTodoEvent({required this.toDoModel});
}

class EditTodoEvent extends TodoEvent {
  final ToDoModel toDoModel;

  EditTodoEvent({required this.toDoModel});
}

class GetTodoEvent extends TodoEvent {}

class DeleteTodoEvent extends TodoEvent {
  final String todoId;

  DeleteTodoEvent({required this.todoId});
}
