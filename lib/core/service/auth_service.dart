import 'package:eduon/core/service/prefrances_maneger.dart';
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

      // initialize يجب يتنادى مرة واحدة بس
      if (!_initialized) {
        await googleSignIn.initialize(
          serverClientId:
              "648950609561-5vt66br00oe08ffg1sordicl751tk7e1.apps.googleusercontent.com",
        );
        _initialized = true;
      }

      // فتح نافذة اختيار الحساب
      final GoogleSignInAccount googleSignInAccount = await googleSignIn
          .authenticate(scopeHint: ['email']);
      // الحصول على idToken
      final String? idToken = googleSignInAccount.authentication.idToken;

      if (idToken == null) {
        throw Exception();
      }
      // محاولة الحصول على accessToken (اختياري - بتحسين الأمان)
      String? accessToken;
      try {
        final clientAuth = await googleSignInAccount.authorizationClient
            .authorizationForScopes(['email']);
        accessToken = clientAuth?.accessToken;
      } catch (_) {
        // accessToken مش ضروري — نكمل بـ idToken بس
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
  // Email Link - Create Account
  // ============================================
  Future<void> sendEmailLink(String email) async {
    final acs = ActionCodeSettings(
      url: 'https://eduon-a2ec6.firebaseapp.com',
      handleCodeInApp: true,
      androidPackageName: 'com.example.eduon',
      androidInstallApp: true,
      androidMinimumVersion: '1',
    );

    await FirebaseAuth.instance.sendSignInLinkToEmail(
      email: email,
      actionCodeSettings: acs,
    );

    await PrefrancesManeger().setString('emailForSignIn', email);
  }

  // ============================================
  // Email Link - Sign In
  // ============================================
  Future<void> signInWithEmailLink(String emailLink) async {
    final email = PrefrancesManeger().getString('emailForSignIn');

    if (email != null &&
        FirebaseAuth.instance.isSignInWithEmailLink(emailLink)) {
      await FirebaseAuth.instance.signInWithEmailLink(
        email: email,
        emailLink: emailLink,
      );
    }
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
      print('Account created successfully!');
      return credential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
      return Future.error(e);
    } catch (e) {
      print('Create Account Error: $e');
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
      print('Signed in successfully!');
      return credential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
      return Future.error(e);
    }
  }
}
