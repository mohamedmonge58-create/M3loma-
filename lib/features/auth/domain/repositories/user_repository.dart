import '../../data/models/user_model.dart';

abstract class UserRepository {
  Future<void> createUser( UserModel user);
  Future <void> updateUser(UserModel user);
}