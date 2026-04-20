import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:eduon/core/service/auth_service.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthService _authService;

  AuthCubit(this._authService) : super(AuthInitial());

  // ============================================
  // Login with Email and Password
  // ============================================
  Future<void> login(String email, String password) async {
    emit(AuthLoading());
    try {
      final userCredential = await _authService.signInWithEmailAndPassword(email, password);
      if (userCredential?.user != null) {
        emit(AuthSuccess(userCredential!.user!));
      } else {
        emit(const AuthError("Login failed: User is null"));
      }
    } catch (e) {
      emit(AuthError(_handleAuthError(e)));
    }
  }

  // ============================================
  // Register with Email and Password
  // ============================================
  Future<void> register(String email, String password) async {
    emit(AuthLoading());
    try {
      final userCredential = await _authService.createUserWithEmailAndPassword(email, password);
      if (userCredential?.user != null) {
        emit(AuthSuccess(userCredential!.user!));
      } else {
        emit(const AuthError("Registration failed: User is null"));
      }
    } catch (e) {
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
        emit(AuthSuccess(userCredential!.user!));
      } else {
        emit(AuthInitial()); // Back to initial if canceled/null without error
      }
    } catch (e) {
      // Check if it's a cancellation error (optional, but good for UX)
      if (e.toString().contains('canceled')) {
        emit(AuthCanceled());
      } else {
        emit(AuthError(_handleAuthError(e)));
      }
    }
  }

  // ============================================
  // Logout
  // ============================================
  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
    emit(AuthInitial());
  }

  // Simple error handler helper
  String _handleAuthError(dynamic e) {
    if (e is FirebaseAuthException) {
      switch (e.code) {
        case 'user-not-found': return "No account found with this email.";
        case 'wrong-password': return "Incorrect password.";
        case 'invalid-credential': return "Invalid email or password.";
        case 'email-already-in-use': return "This email is already in use.";
        case 'weak-password': return "The password is too weak.";
        default: return e.message ?? "Authentication failed.";
      }
    }
    return e.toString();
  }
}
