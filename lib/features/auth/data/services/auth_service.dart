import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  bool _initialized = false;
  // ============================================
  // Google Sign In
  // ============================================
  Future<UserCredential?> signInWithGoogle() async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn.instance;
      if (!_initialized) {
        await googleSignIn.initialize(
          serverClientId:
              "648950609561-5vt66br00oe08ffg1sordicl751tk7e1.apps.googleusercontent.com",
        );
        _initialized = true;
      }
      final GoogleSignInAccount googleSignInAccount = await googleSignIn
          .authenticate(scopeHint: ['email']);
      final String? idToken = googleSignInAccount.authentication.idToken;

      if (idToken == null) {
        throw Exception();
      }
      String? accessToken;
      try {
        final clientAuth = await googleSignInAccount.authorizationClient
            .authorizationForScopes(['email']);
        accessToken = clientAuth?.accessToken;
      } catch (_) {
      }

      final credential = GoogleAuthProvider.credential(
        idToken: idToken,
        accessToken: accessToken,
      );

      final userCredential = await FirebaseAuth.instance.signInWithCredential(
        credential,
      );

      if (userCredential.user == null) {
        throw Exception('Firebase sign-in succeeded but user is null');
      }

      return userCredential;
    } catch (e) {
      return Future.error(e);
    }
  }

  // ============================================
  // Forgot Password
  // ============================================
  Future<void> sendPasswordResetEmail(String email) async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email.trim());
  }

  // ============================================
  // Email & Password - Create Account
  // ============================================
  Future<UserCredential?> createUserWithEmailAndPassword(
    String emailAddress,
    String password,
  ) async {
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: emailAddress,
            password: password,
          );

      return credential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
      } else if (e.code == 'email-already-in-use') {}
      return Future.error(e);
    } catch (e) {
      return Future.error(e);
    }
  }

  // ============================================
  // Email & Password - Sign In
  // ============================================
  Future<UserCredential?> signInWithEmailAndPassword(
    String emailAddress,
    String password,
  ) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );

      return credential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
      } else if (e.code == 'wrong-password') {}
      return Future.error(e);
    }
  }
}
