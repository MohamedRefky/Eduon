// lib/services/firebase_service.dart

import 'package:eduon/core/service/prefrances_maneger.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  Future<UserCredential?> signInWithGoogle() async {
    try {
      await GoogleSignIn.instance.initialize();

      final GoogleSignInAccount googleSignInAccount = await GoogleSignIn
          .instance
          .authenticate(scopeHint: ["email"]);

      final GoogleSignInAuthorizationClient authenticationClient =
          googleSignInAccount.authorizationClient;

      GoogleSignInClientAuthorization? auth = await authenticationClient
          .authorizationForScopes(["email"]);
      auth ??= await authenticationClient.authorizationForScopes(["email"]);

      GoogleSignInAuthentication newAuth = googleSignInAccount.authentication;

      print('ID Token: ${newAuth.idToken}');
      print('Access Token: ${auth!.accessToken}');

      final credential = GoogleAuthProvider.credential(
        idToken: newAuth.idToken,
        accessToken: auth.accessToken,
      );
      print('Credential: $credential');
      return await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      print('Google Sign In Error: $e');
      return null;
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

    await PreferencesManager().setString('emailForSignIn', email);
  }

  Future<void> signInWithEmailLink(String emailLink) async {
    final email = PreferencesManager().getString('emailForSignIn');

    if (email != null &&
        FirebaseAuth.instance.isSignInWithEmailLink(emailLink)) {
      await FirebaseAuth.instance.signInWithEmailLink(
        email: email,
        emailLink: emailLink,
      );
    }
  }
}
