import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:housr_booking_app/db/shared_prefence.dart';
import '../../db/database_helper.dart';
import 'package:sqflite/sqflite.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;

  AuthBloc() : super(AuthInitial()) {
    on<SignInEvent>(_onSignInEvent);
    on<SignUpEvent>(_onSignUpEvent);
  }

  Future<void> _onSignInEvent(SignInEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final user = await _dbHelper.getUserByEmail(event.email);
      if (user == null) {
        emit(const AuthError("Email not found"));
      } else if (user['password'] != event.password) {
        emit(const AuthError("Incorrect password"));
      } else {
        await UserPreferences.saveUser(user['name'], user['email']);  // Save user details
        emit(AuthSignedIn(user['name']));
      }
    } catch (e) {
      emit(AuthError("Sign-in failed: $e"));
    }
  }

  Future<void> _onSignUpEvent(SignUpEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final user = {
        'name': event.name,
        'email': event.email,
        'password': event.password
      };
      await _dbHelper.createUser(user);
      await UserPreferences.saveUser(event.name, event.email);  // Save user details
      emit(AuthSignedIn(event.name));  // Emit AuthSignedIn state
    } catch (e) {
      if (e is DatabaseException && e.isUniqueConstraintError()) {
        emit(const AuthError("Email already exists Please Login"));
      } else {
        emit(AuthError("Sign-up failed: $e"));
      }
    }
  }
}
