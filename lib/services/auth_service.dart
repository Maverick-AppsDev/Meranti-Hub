import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  // Google Sign in
  signInWithGoogle() async {
    // Interaction sign in process
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

    // Obtaining authentication details
    final GoogleSignInAuthentication gAuth = await gUser!.authentication;

    // Creating new credential/account for user
    final credential = GoogleAuthProvider.credential(
      accessToken: gAuth.accessToken,
      idToken: gAuth.idToken,
    );

    // Signing in
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
