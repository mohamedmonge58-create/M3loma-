import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:m3loma_app/features/auth/data/datasources/auth_remote_data_source.dart';

import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/data/repositories/user_repository_impl.dart';
import '../../features/auth/domain/usecases/update_profile_use_case.dart';
import '../../features/auth/presentation/cubit/auth_cubit.dart';
import '../../features/auth/presentation/cubit/update_profile_cubit.dart';

final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

final AuthRemoteDataSource authRemoteDataSource = AuthRemoteDataSource(
  firebaseAuth,
);

final AuthRepositoryImpl authRepository = AuthRepositoryImpl(
  authRemoteDataSource,
);

final FirebaseFirestore firestore = FirebaseFirestore.instance;

final UserRemoteDataSource userRemoteDataSource = UserRemoteDataSource(
  firestore,
);

final UserRepositoryImpl userRepository = UserRepositoryImpl(
  userRemoteDataSource,
);

final AuthCubit authCubit = AuthCubit(authRepository, userRepository);
final UpdateProfileUseCase updateProfileUseCase = UpdateProfileUseCase(
  userRepository,
);
final UpdateProfileCubit updateProfileCubit = UpdateProfileCubit(
  updateProfileUseCase,
  authRepository,

);
