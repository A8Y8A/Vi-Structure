import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project2/domain/usecase/login_usecase.dart';
import 'package:project2/domain/usecase/signup_uscase.dart';
import 'package:project2/presentation/controller/authcubit/auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final SignUpUseCase _signUpUseCase;
  final LoginUseCase _loginUseCase;
  AuthCubit(this._loginUseCase, this._signUpUseCase) : super(AuthInitial());

  void login(String name, String password, BuildContext context) async {
    emit(AuthLoading());
    try {
      final result =
          await _loginUseCase(LoginParameters(name, password, context));
      print("result is $result");
      emit(AuthSuccess());
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  void signup(String name, String email, String password) async {
    emit(AuthLoading());
    try {
      final result =
          await _signUpUseCase(SignUpParameters(name, email, password));

      emit(AuthSuccess());
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }
}
