import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/user_model.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../data/repositories/user_repository_impl.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this._repository, this._userRepository)
      : super(const AuthInitial());

  final AuthRepositoryImpl _repository;
  final UserRepositoryImpl _userRepository;

  Future<void> register({
    required String email,
    required String password,
    required String name,
    required String phone,
  }) async {
    emit(const AuthLoading());

    try {
      // Step 1: Create Firebase Auth account
      final userCredential = await _repository.register(
        email: email,
        password: password,
      );

      final user = userCredential.user;
      if (user == null) {
        throw Exception('User creation failed.');
      }

      // Step 2: Build UserModel
      final userModel = UserModel(
        id: user.uid,
        name: name,
        email: email,
        phone: phone,
      );

      // Step 3: Attempt Firestore write with timeout so registration isn't blocked
      try {
        await _userRepository
            .createUser(userModel)
            .timeout(const Duration(seconds: 4));
      } catch (firestoreError) {
        debugPrint('Firestore user creation warning: $firestoreError');
      }

      // Step 4: Emit AuthSuccess and navigate to Login
      emit(const AuthSuccess());
    } catch (e, stackTrace) {
      debugPrint('REGISTER ERROR: $e');
      debugPrintStack(stackTrace: stackTrace);

      if (e is FirebaseAuthException) {
        emit(AuthFailure(e.message ?? 'Could not create account'));
      } else {
        emit(AuthFailure(e.toString()));
      }
    }
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    emit(const AuthLoading());

    try {
      await _repository.login(
        email: email,
        password: password,
      );

      emit(const AuthSuccess());
    } catch (e) {
      if (e is FirebaseAuthException) {
        if (e.code == 'user-not-found' || e.code == 'invalid-credential') {
          emit(const AuthFailure('This email does not exist'));
        } else if (e.code == 'wrong-password') {
          emit(const AuthFailure('Incorrect password'));
        } else {
          emit(AuthFailure(e.message ?? 'This email does not exist'));
        }
      } else {
        emit(const AuthFailure('This email does not exist'));
      }
    }
  }
}
