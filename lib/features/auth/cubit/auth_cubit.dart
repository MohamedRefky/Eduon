import 'package:eduon/features/auth/data/services/auth_service.dart';
import 'package:eduon/core/service/preferences_manager.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthService _authService;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController fullNameController = TextEditingController();

  bool showPassword = false;

  AuthCubit(this._authService) : super(AuthInitial());

  void togglePasswordVisibility() {
    showPassword = !showPassword;
    emit(AuthFormUpdated());
  }

  // ============================================
  // Login with Email and Password
  // ============================================

  Future<void> login() async {
    emit(AuthLoading());

    try {
      await Future.delayed(const Duration(seconds: 1));
      final userCredential = await _authService.signInWithEmailAndPassword(
        emailController.text.trim(),
        passwordController.text.trim(),
      );

      if (userCredential?.user != null) {
        emit(AuthSuccess(userCredential!.user!));
      }
    } catch (e) {
      emit(AuthError(_handleAuthError(e)));
    }
  }

  // ============================================
  // Register with Email and Password
  // ============================================
  Future<void> register() async {
    emit(AuthLoading());

    try {
      final registerFuture = _authService.createUserWithEmailAndPassword(
        emailController.text.trim(),
        passwordController.text.trim(),
      );

      await Future.wait([
        registerFuture,
        Future.delayed(const Duration(seconds: 1)),
      ]);

      final userCredential = await registerFuture;

      if (userCredential?.user != null) {
        await PreferencesManager().setUserFullName(
          userCredential!.user!.uid,
          fullNameController.text.trim(),
        );
        emit(AuthSuccess(userCredential.user!, isNewUser: true));
      }
    } on FirebaseAuthException catch (e) {
      await Future.delayed(const Duration(seconds: 1));
      emit(AuthError(_handleAuthError(e)));
    }
  }

  // ============================================
  // Google Sign In
  // ============================================
  Future<void> signInWithGoogle() async {
    emit(AuthLoading());
    try {
      final userCredential = await _authService.signInWithGoogle();

      if (userCredential?.user != null) {
        final user = userCredential!.user!;
        final uid = user.uid;
        final name = user.displayName ?? "User";
        final isNewUser = userCredential.additionalUserInfo?.isNewUser ?? false;

        final savedName = PreferencesManager().getUserFullName(uid);

        if (savedName == null) {
          await PreferencesManager().setUserFullName(uid, name);
        }
        emit(AuthSuccess(userCredential.user!, isNewUser: isNewUser));
      } else {
        emit(AuthCanceled());
      }
    } catch (e) {
      if (e.toString().contains('canceled')) {
        emit(AuthCanceled());
      } else {
        emit(AuthError(_handleAuthError(e)));
      }
    }
  }

  Future<void> forgotPasswordWithEmail(String email) async {
    emit(AuthLoading());

    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email.trim());

      emit(AuthPasswordResetSent());
    } on FirebaseAuthException catch (e) {
      emit(AuthError(_handleAuthError(e)));
    } catch (e) {
      emit(const AuthError("something_went_wrong"));
    }
  }

  // ============================================
  // Logout
  // ============================================
  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
    emit(AuthInitial());
  }

  // ============================================
  // Error Handler
  // ============================================
  String _handleAuthError(dynamic e) {
    if (e is FirebaseAuthException) {
      switch (e.code) {
        case 'user-not-found':
          return "user_not_found_signup";
        case 'wrong-password':
          return "wrong_password";
        case 'invalid-credential':
          return "invalid_credential";
        case 'email-already-in-use':
          return "email_already_registered";
        case 'weak-password':
          return "password_at_least_6";
        case 'too-many-requests':
          return "too_many_requests";
        case 'network-request-failed':
          return "network_error";
        default:
          return "auth_failed";
      }
    }
    return "something_went_wrong";
  }

  @override
  Future<void> close() {
    emailController.dispose();
    passwordController.dispose();
    fullNameController.dispose();
    return super.close();
  }
}
