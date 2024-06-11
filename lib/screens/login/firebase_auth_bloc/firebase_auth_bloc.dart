import 'dart:async';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fancy/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../constants/app_keys.dart';
import '../../../firebase/firebase_auth_services.dart';

part 'firebase_auth_event.dart';

part 'firebase_auth_state.dart';

class FirebaseAuthBloc extends Bloc<FirebaseAuthEvent, FirebaseAuthState> {
  FirebaseAuthBloc() : super(FirebaseAuthInitial()) {
    on<UserRegister>(registerUser);
    on<UserSignIn>(signInUser);
  }

  Future<void> registerUser(
      UserRegister event, Emitter<FirebaseAuthState> emit) async {
    UserModel user = UserModel.fromJson(event.json);
    try {
      emit(FirebaseAuthLoading());
      await FireBaseAuthServices.signUpWithEmailPass(
        user.email?.trim() ?? '',
        user.pass?.trim() ?? '',
      );
      emit(FirebaseAuthLoaded());
      emit(FirebaseAuthSuccess(true));
    } on FirebaseException catch (e) {
      emit(FirebaseAuthLoaded());
      emit(FirebaseAuthFailed(e.message.toString()));
    }
  }

  Future<void> signInUser(
      UserSignIn event, Emitter<FirebaseAuthState> emit) async {
    UserModel user = UserModel.fromJson(event.json);
    try {
      emit(FirebaseAuthLoading());
      await FireBaseAuthServices.signInWithEmailPass(
        user.email?.trim() ?? '',
        user.pass?.trim() ?? '',
      );
      var sp = await SharedPreferences.getInstance();
      sp.setBool(AppKeys.keyLogin, true);
      emit(FirebaseAuthLoaded());
      emit(FirebaseAuthSuccess(true));
    } on FirebaseException catch (e) {
      emit(FirebaseAuthLoaded());
      emit(FirebaseAuthFailed(
        e.code == 'invalid-credential'
            ? 'Invalid email or password.'
            : e.message ?? '',
      ));
    }
  }
}
