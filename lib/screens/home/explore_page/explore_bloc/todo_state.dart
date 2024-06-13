part of 'todo_bloc.dart';

@immutable
// abstract class TodoState {
//   const TodoState();
// }
//
// class AddItemsToFireStoreState extends TodoState {
//   final String? errorMessage;
//   final ApiStatus status;
//
//   const AddItemsToFireStoreState._({required this.status, this.errorMessage});
//
//   const AddItemsToFireStoreState.isLoading()
//       : this._(
//     status: ApiStatus.isLoading,
//   );
//
//   const AddItemsToFireStoreState.isInitial()
//       : this._(
//     status: ApiStatus.isInitial,
//   );
//
//   const AddItemsToFireStoreState.isLoaded()
//       : this._(
//     status: ApiStatus.isLoaded,
//   );
//
//   const AddItemsToFireStoreState.isError({required String? errorMessage})
//       : this._(
//     status: ApiStatus.isError,
//     errorMessage: errorMessage,
//   );
// }

class TodoState {
  final String? errorMessage;
  final ApiStatus? addTodoStatus;
  final ApiStatus? editTodoStatus;
  final ApiStatus? getTodoStatus;
  final ApiStatus? deleteTodoStatus;
  final List<ToDoModel>? toDoModel;

  const TodoState({
    this.errorMessage,
    this.toDoModel,
    this.getTodoStatus = ApiStatus.isInitial,
    this.editTodoStatus = ApiStatus.isInitial,
    this.addTodoStatus = ApiStatus.isInitial,
    this.deleteTodoStatus = ApiStatus.isInitial,
  });

  TodoState copyWith({
    String? errorMessage,
    List<ToDoModel>? toDoModel,
    ApiStatus? addTodoStatus,
    ApiStatus? editTodoStatus,
    ApiStatus? getTodoStatus,
    ApiStatus? deleteTodoStatus,
  }) {
    return TodoState(
      addTodoStatus: addTodoStatus ??  this.addTodoStatus,
      editTodoStatus: editTodoStatus ??  this.editTodoStatus,
      errorMessage: errorMessage ?? this.errorMessage,
      getTodoStatus: getTodoStatus ?? this.getTodoStatus,
      deleteTodoStatus: deleteTodoStatus ?? this.deleteTodoStatus,
      toDoModel: toDoModel ?? this.toDoModel,
    );
  }
}
