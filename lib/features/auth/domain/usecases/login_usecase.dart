import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  Future<UserEntity> call({
    required String email,
    required String password,
  }) async {
    final result = await repository.login(
      email: email,
      password: password,
    );
    return UserEntity(
      id: result.user!.uid,
      name: result.user!.displayName ?? '',
      email: result.user!.email ?? '',
      phone: result.user!.phoneNumber ?? '',

    );
  }

  }

