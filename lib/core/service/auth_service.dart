import 'package:eduon/core/service/prefrances_maneger.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  bool _initialized = false;

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
      final GoogleSignInAccount googleSignInAccount =
          await googleSignIn.authenticate(scopeHint: ['email']);

      print('Google Sign In Account: $googleSignInAccount');

      // الحصول على idToken
      final String? idToken = googleSignInAccount.authentication.idToken;
      print('ID Token: $idToken');

      if (idToken == null) {
        throw Exception(
          'idToken is null — تأكد أن serverClientId في Firebase Console صح، '
          'وأن SHA-1 و SHA-256 مضافين لـ Android app في Firebase.',
        );
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

      print('Access Token: $accessToken');

      final credential = GoogleAuthProvider.credential(
        idToken: idToken,
        accessToken: accessToken,
      );

      final userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      if (userCredential.user == null) {
        throw Exception('Firebase sign-in succeeded but user is null');
      }

      print('Firebase User: ${userCredential.user?.email}');
      return userCredential;
    } catch (e) {
      print('Google Sign In Error: $e');
      return Future.error(e);
    }
  }

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
}
