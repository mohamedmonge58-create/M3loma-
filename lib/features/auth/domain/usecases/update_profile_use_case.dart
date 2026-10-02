import '../../data/models/user_model.dart';
import '../../data/repositories/user_repository_impl.dart';

class UpdateProfileUseCase {
  final UserRepositoryImpl repository;
  UpdateProfileUseCase(this.repository);

  Future<void> call (UserModel user) async {
    await repository.updateUser(user);





  }


}