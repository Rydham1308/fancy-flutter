part of 'firebase_auth_bloc.dart';

@immutable
abstract class FirebaseAuthState {}

class FirebaseAuthInitial extends FirebaseAuthState {}

class FirebaseAuthSuccess extends FirebaseAuthState {
  final bool registered;

  FirebaseAuthSuccess(this.registered);
}

class FirebaseAuthFailed extends FirebaseAuthState {
  final String error;

  FirebaseAuthFailed(this.error);
}

class FirebaseAuthLoading extends FirebaseAuthState {}

class FirebaseAuthLoaded extends FirebaseAuthState {}

// class FirebaseAuthRegistered extends FirebaseAuthState {
//   final bool registered;
//   FirebaseAuthRegistered(this.registered);
// }
