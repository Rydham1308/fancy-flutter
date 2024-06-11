part of 'todo_bloc.dart';

@immutable
abstract class TodoState {
  const TodoState();
}

class AddItemsToFireStoreState extends TodoState {
  final String? errorMessage;
  final ApiStatus status;

  const AddItemsToFireStoreState._({required this.status, this.errorMessage});

  const AddItemsToFireStoreState.isLoading()
      : this._(
    status: ApiStatus.isLoading,
  );

  const AddItemsToFireStoreState.isInitial()
      : this._(
    status: ApiStatus.isInitial,
  );

  const AddItemsToFireStoreState.isLoaded()
      : this._(
    status: ApiStatus.isLoaded,
  );

  const AddItemsToFireStoreState.isError({required String? errorMessage})
      : this._(
    status: ApiStatus.isError,
    errorMessage: errorMessage,
  );
}
