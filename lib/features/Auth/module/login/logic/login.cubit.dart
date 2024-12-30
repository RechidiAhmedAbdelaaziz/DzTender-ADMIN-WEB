import 'package:flutter/material.dart';
import 'package:tender/core/di/container.dart';
import 'package:tender/core/network/models/api_response.model.dart';
import 'package:tender/core/types/error_state.dart';
import 'package:tender/features/Auth/data/dto/login.dto.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tender/features/Auth/data/repositories/auth.repo.dart';

part 'login.state.dart';

class LoginCubit extends Cubit<LoginState> {
  final _authRepo = locator<AuthRepo>();
  final formKey = GlobalKey<FormState>();
  LoginCubit() : super(LoginState.initial());

  void login() async {
    emit(state.loading());

    if (!formKey.currentState!.validate()) {
      emit(state.error('Invalid input'));
      return;
    }

    final result = await _authRepo.login(state.params);

    result.when(
      success: (tokens) => emit(state.loaded(tokens)),
      error: (error) => emit(state.error(error.message)),
    );
  }
}
