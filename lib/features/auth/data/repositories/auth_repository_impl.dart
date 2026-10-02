import 'package:firebase_auth/firebase_auth.dart';

import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<UserCredential> register({
    required String email,
    required String password,
  }) {
    return remoteDataSource.register(email: email, password: password);
  }

  @override
  Future<UserCredential> login({
    required String email,
    required String password,
  }) {
    return remoteDataSource.login(email: email, password: password);
  }

  @override
  Future<void> logout() {
    return remoteDataSource.logout();
  }

  @override
  Future<void> updateName(String name) {
    return remoteDataSource.updateName(name);
  }

  @override
  Future<void> updateEmail(String email) {
    return remoteDataSource.updateEmail(email);
  }

  @override
  Future<void> updatePhoto(String imageUrl) {
    return remoteDataSource.updatePhoto(imageUrl);
  }
}
