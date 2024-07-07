import 'package:blog_app/core/errors/failures.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class AuthRepostiory {
  Future<Either<Failure, String>> singupWithEmailPassword({
    required String name,
    required String email,
    required String password
  });
  Future<Either<Failure, String>> loginWithEmailPassword({
    required String email,
    required String password
  });
}