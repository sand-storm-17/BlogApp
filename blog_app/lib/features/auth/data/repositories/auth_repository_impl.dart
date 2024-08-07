import 'package:blog_app/core/errors/exceptions.dart';
import 'package:blog_app/core/errors/failures.dart';
import 'package:blog_app/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:blog_app/core/common/entities/user.dart';
import 'package:blog_app/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as sb;

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, User>> currentUser() async {
    try{
      final user = await remoteDataSource.getCurrentUserData();
      if(user == null){
        return left(Failure('User not logged in'));
      }
      return right(user);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
  @override
  Future<Either<Failure, User>> loginWithEmailPassword({
    required String email,
    required String password,
  }) async {
    return _getUser(() async => await remoteDataSource.loginWithEmailPassword(
          email: email,
          password: password,
        ));
  }

  @override
  Future<Either<Failure, User>> signupWithEmailPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    return _getUser(() async => await remoteDataSource.signupWithEmailPassword(
          email: email,
          name: name,
          password: password,
        ));
  }
}

Future<Either<Failure, User>> _getUser(Future<User> Function() fn) async {
  try {
    final user = await fn();
    return right(user);
  } on sb.AuthException catch (e) {
    return left(Failure(e.message));
  } on ServerException catch (e) {
    return left(Failure(e.message));
  }
}
