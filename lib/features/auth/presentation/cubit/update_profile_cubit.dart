import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/user_model.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../domain/usecases/update_profile_use_case.dart';

class UpdateProfileCubit extends Cubit<UpdateProfileState> {
  UpdateProfileCubit(
      this._updateProfileUseCase,
      this._authRepository,
      ) : super(const UpdateProfileInitial());

  final AuthRepositoryImpl _authRepository;
  final UpdateProfileUseCase _updateProfileUseCase;

  Future<void> updateProfile({
    required UserModel user,
    String? name,
    String? email,
  }) async {
    emit(const UpdateProfileLoading());

    try {
      // Update name in Firebase Auth
      if (name != null &&
          name.trim().isNotEmpty &&
          name.trim() != user.name) {
        await _authRepository.updateName(name.trim());
      }

      // Update email in Firebase Auth
      if (email != null &&
          email.trim().isNotEmpty &&
          email.trim() != user.email) {
        await _authRepository.updateEmail(email.trim());
      }

      // Update Firestore
      final updatedUser = UserModel(
        id: user.id,
        name: name?.trim() ?? user.name,
        email: email?.trim() ?? user.email,
        phone: user.phone,
        image: user.image,
      );

      await _updateProfileUseCase.call(updatedUser);

      emit(const UpdateProfileSuccess());
    } catch (e) {
      emit(UpdateProfileFailure(e.toString()));
    }
  }
}

abstract class UpdateProfileState {
  const UpdateProfileState();
}

class UpdateProfileInitial extends UpdateProfileState {
  const UpdateProfileInitial();
}

class UpdateProfileLoading extends UpdateProfileState {
  const UpdateProfileLoading();
}

class UpdateProfileSuccess extends UpdateProfileState {
  const UpdateProfileSuccess();
}

class UpdateProfileFailure extends UpdateProfileState {
  const UpdateProfileFailure(this.message);

  final String message;
}