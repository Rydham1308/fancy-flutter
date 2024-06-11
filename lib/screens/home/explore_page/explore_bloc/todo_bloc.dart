import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

import '../../../../models/postal_model.dart';
import '../../../../models/todo_model.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoBloc() : super(const AddItemsToFireStoreState.isInitial()) {
    on<AddTodoEvent>(addTodo);
  }

  FutureOr<void> addTodo(AddTodoEvent event, Emitter<TodoState> emit) {
    final db = FirebaseFirestore.instance;
    ToDoModel toDoModel = ToDoModel();
    emit(const AddItemsToFireStoreState.isLoading());
    try {
      db.collection('todo').doc('${toDoModel.id}').set(toDoModel.toJson());
      emit(const AddItemsToFireStoreState.isLoaded());
    } catch (e) {
      emit(AddItemsToFireStoreState.isError(errorMessage: e.toString()));
    }
  }
}
