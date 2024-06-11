part of 'todo_bloc.dart';

@immutable
abstract class TodoEvent {}

class AddTodoEvent extends TodoEvent{
  AddTodoEvent();
}