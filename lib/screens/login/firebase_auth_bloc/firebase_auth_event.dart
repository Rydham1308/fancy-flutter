part of 'firebase_auth_bloc.dart';

@immutable
abstract class FirebaseAuthEvent {}

class UserRegister extends FirebaseAuthEvent {
  // final String email;
  // final String pass;
  //
  // UserRegister({
  //   required this.email,
  //   required this.pass,
  // });
  final Map<String, dynamic> json;

  UserRegister({required this.json});
}

class UserSignIn extends FirebaseAuthEvent {
  // final String email;
  // final String pass;
  //
  // UserSignIn({
  //   required this.email,
  //   required this.pass,
  // });
  final Map<String, dynamic> json;

  UserSignIn({required this.json});
}
