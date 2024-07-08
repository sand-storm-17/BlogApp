import 'package:blog_app/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:blog_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:blog_app/features/auth/domain/repository/auth_repository.dart';
import 'package:blog_app/features/auth/domain/usecases/user_signup.dart';
import 'package:blog_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'core/secrets/app_secrets.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  _initAuth();
  final supabase = await Supabase.initialize(
      url: AppSecrets.supabaseUrl, anonKey: AppSecrets.anonKey);

  serviceLocator.registerLazySingleton(() => {supabase.client});
}

void _initAuth() {
  serviceLocator
      .registerFactory<AuthRemoteDataSource>(() => AuthRemoteDataSourceImpl(
            serviceLocator(),
          ));

  serviceLocator.registerFactory<AuthRepository>(() => AuthRepositoryImpl(serviceLocator()));

  serviceLocator.registerFactory(()=> UserSignup(serviceLocator()));


  serviceLocator.registerLazySingleton(()=> AuthBloc(userSignup: serviceLocator()));
}