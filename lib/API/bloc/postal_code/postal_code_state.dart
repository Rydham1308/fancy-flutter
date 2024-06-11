part of 'postal_code_bloc.dart';

abstract class PostalCodeState {
  const PostalCodeState();
}

class CodeState extends PostalCodeState {
  final ApiStatus status;
  final List<PostOfficeData>? dataList;
  final String? errorMessage;
  final String? message;

  const CodeState._({required this.status, this.dataList, this.errorMessage, this.message});

  const CodeState.isLoaded({
    required List<PostOfficeData>? dataList,
    required String? message,
  }) : this._(status: ApiStatus.isLoaded, dataList: dataList, message: message);

  const CodeState.isLoading() : this._(status: ApiStatus.isLoading);

  const CodeState.isError({required String? errorMessage})
      : this._(status: ApiStatus.isError, errorMessage: errorMessage);
}

// class PostalCodeInitial extends PostalCodeState {}
//
// class IsLoadingState extends PostalCodeState {}
//
// class IsLoadedState extends PostalCodeState {
//   final List<PostOfficeData>? dataList;
//
//   IsLoadedState({required this.dataList});
// }
//
// class IsEmptyState extends PostalCodeState {
//   final String message;
//
//   IsEmptyState({required this.message});
// }
//
// class IsErrorState extends PostalCodeState {
//   final String error;
//
//   IsErrorState(this.error);
// }
