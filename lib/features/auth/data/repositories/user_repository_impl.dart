import '../../domain/repositories/user_repository.dart';
import '../datasources/auth_remote_data_source.dart';
import '../models/user_model.dart';

class UserRepositoryImpl implements UserRepository {
  UserRepositoryImpl(this._remoteDataSource);

  final UserRemoteDataSource _remoteDataSource;

  @override
  Future<void> createUser(UserModel user) {
    return _remoteDataSource.createUser(user);
  }
  @override
  Future<void> updateUser(UserModel user) {
    return _remoteDataSource.updateUser(user);
  }
}