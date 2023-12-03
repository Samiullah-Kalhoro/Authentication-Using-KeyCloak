import 'package:auth_keycloak/auth/repository/auth_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthLoading()){
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
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> login(String username, String password) async {
    emit(AuthLoading());
    try {
      String token = await _authRepo.login(username, password);
      await _authRepo.persistToken(token);
      emit(Authenticated());
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }
}
