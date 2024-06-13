import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

import '../../../../models/postal_model.dart';
import '../todo_model.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoBloc() : super(const TodoState()) {
    on<AddTodoEvent>(addTodo);
    on<EditTodoEvent>(editTodo);
    on<DeleteTodoEvent>(deleteTodo);
    on<GetTodoEvent>(getTodo);
  }

  FutureOr<void> addTodo(AddTodoEvent event, Emitter<TodoState> emit) {
    final db = FirebaseFirestore.instance;
    emit(state.copyWith(addTodoStatus: ApiStatus.isLoading));
    try {
      db.collection('todo').doc('${event.toDoModel.id}').set(event.toDoModel.toJson());
      emit(state.copyWith(addTodoStatus: ApiStatus.isLoaded));
      add(GetTodoEvent());
    } catch (e) {
      if (e is FirebaseException) {
        emit(state.copyWith(addTodoStatus: ApiStatus.isError, errorMessage: e.message));
      } else {
        emit(state.copyWith(
            addTodoStatus: ApiStatus.isError, errorMessage: 'Something went wrong.'));
      }
    }
  }
  FutureOr<void> editTodo(EditTodoEvent event, Emitter<TodoState> emit) {
    final db = FirebaseFirestore.instance;
    emit(state.copyWith(editTodoStatus: ApiStatus.isLoading));
    try {
      db.collection('todo').doc('${event.toDoModel.id}').update(event.toDoModel.toJson());
      emit(state.copyWith(editTodoStatus: ApiStatus.isLoaded));
      add(GetTodoEvent());
    } catch (e) {
      if (e is FirebaseException) {
        emit(state.copyWith(editTodoStatus: ApiStatus.isError, errorMessage: e.message));
      } else {
        emit(state.copyWith(
            editTodoStatus: ApiStatus.isError, errorMessage: 'Something went wrong.'));
      }
    }
  }

  Future<void> deleteTodo(DeleteTodoEvent event, Emitter<TodoState> emit) async {
    final db = FirebaseFirestore.instance;
    emit(state.copyWith(deleteTodoStatus: ApiStatus.isLoading));
    try {
      var collection = db.collection('todo');
      collection.doc(event.todoId).delete();
      emit(state.copyWith(deleteTodoStatus: ApiStatus.isLoaded));
      add(GetTodoEvent());
    } catch (e) {
      if (e is FirebaseException) {
        emit(state.copyWith(deleteTodoStatus: ApiStatus.isError, errorMessage: e.message));
      } else {
        emit(state.copyWith(
            deleteTodoStatus: ApiStatus.isError, errorMessage: 'Something went wrong.'));
      }
    }
  }

  Future<void> getTodo(GetTodoEvent event, Emitter<TodoState> emit) async {
    emit(state.copyWith(getTodoStatus: ApiStatus.isLoading));
    try {
      final fireStore = FirebaseFirestore.instance;
      final response = await fireStore.collection('todo').get();
      List<ToDoModel> todoList =
          List<ToDoModel>.from(response.docs.map((e) => ToDoModel.fromJson(e.data())));
      emit(state.copyWith(getTodoStatus: ApiStatus.isLoaded, toDoModel: todoList));
    } catch (e) {
      if (e is FirebaseException) {
        emit(state.copyWith(getTodoStatus: ApiStatus.isError, errorMessage: e.message));
      } else {
        emit(state.copyWith(
            getTodoStatus: ApiStatus.isError, errorMessage: 'Something went wrong.'));
      }
    }
  }
}
