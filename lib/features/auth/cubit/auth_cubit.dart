import 'package:eduon/core/service/auth_service.dart';
import 'package:eduon/core/service/prefrances_maneger.dart';
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
      final userCredential = await _authService.signInWithEmailAndPassword(
        emailController.text.trim(),
        passwordController.text.trim(),
      );

      if (userCredential?.user != null) {
        emit(AuthSuccess(userCredential!.user!));
      }
    } on FirebaseAuthException {
      emit(AuthUserNotFound());
    }
  }

  // ============================================
  // Register with Email and Password
  // ============================================
  Future<void> register() async {
    emit(AuthLoading());

    try {
      final userCredential = await _authService.createUserWithEmailAndPassword(
        emailController.text.trim(),
        passwordController.text.trim(),
      );

      if (userCredential?.user != null) {
        emit(AuthSuccess(userCredential!.user!));
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        emit(AuthEmailAlreadyExists());
      } else {
        emit(const AuthError("Registration failed"));
      }
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
        final name = userCredential!.user!.displayName;
        await PrefrancesManeger().setFullName(name ?? "");
        emit(AuthSuccess(userCredential.user!));
      } else {
        emit(AuthCanceled()); // ✅ بدل AuthInitial
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
    await FirebaseAuth.instance.sendPasswordResetEmail(
      email: email.trim(),
    );

    emit(AuthPasswordResetSent());
  } on FirebaseAuthException catch (e) {
    emit(AuthError(_handleAuthError(e)));
  } catch (e) {
    emit(const AuthError("Failed to send reset email."));
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
          return "No account found with this email.";
        case 'wrong-password':
          return "Incorrect password.";
        case 'invalid-credential':
          return "Invalid email or password.";
        case 'email-already-in-use':
          return "This email is already in use.";
        case 'weak-password':
          return "The password is too weak.";
        case 'too-many-requests':
          return "Too many tries. Please wait and try again.";
        default:
          return e.message ?? "Authentication failed.";
      }
    }
    return e.toString();
  }

  @override
  Future<void> close() {
    emailController.dispose();
    passwordController.dispose();
    fullNameController.dispose();
    return super.close();
  }
}
