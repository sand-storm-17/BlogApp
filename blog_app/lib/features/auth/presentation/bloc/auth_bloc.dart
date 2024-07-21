import 'package:blog_app/features/auth/domain/entities/user.dart';
import 'package:blog_app/features/auth/domain/usecases/user_signup.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignup _userSignup;
  AuthBloc({
    required UserSignup userSignup
  }) : _userSignup = userSignup, super(AuthInitial()) {
    on<AuthSignUp>((event, emit) async {
      final res = await _userSignup(
        UserSignupParams(email: event.email, name: event.name, password: event.password)
      );
      res.fold((failure)=> emit(AuthFailure(failure.message)), (user)=> emit(AuthSuccess(user)));
    });
  }
}
