import 'package:auth_keycloak/auth/repository/auth_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthLoading()) {
    checkAuth();
  }

  final AuthRepo _authRepo = AuthRepo();

  Future<void> checkAuth() async {
    emit(AuthLoading());
    try {
      bool hasToken = await _authRepo.hasToken();
      if (hasToken) {
        emit(Authenticated());
      } else {
        emit(Unauthenticated());
      }
    } on DioException catch (ex) {
      emit(AuthError(ex.message.toString()));
    }
  }

  Future<void> login(String username, String password) async {
    emit(AuthLoading());
    try {
      String token = await _authRepo.login(username, password);
      await _authRepo.persistToken(token);
      emit(Authenticated());
    } on DioException catch (ex) {
      if (ex.response!.statusCode == 401) {
        emit(AuthError('Invalid username or password'));
        emit(Unauthenticated());
      }
      emit(AuthError(ex.message.toString()));
    }
  }

  Future<void> logout() async {
    emit(AuthLoading());
    try {
      await _authRepo.deleteToken();
      emit(Unauthenticated());
    } on DioException catch (ex) {
      emit(AuthError(ex.message.toString()));
    }
  }
}
