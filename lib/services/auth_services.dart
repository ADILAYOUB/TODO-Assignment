import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthServices {
  //* Google SignIn
  signInWithGoogle() async {
    //start intraction
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
    // auth details
    final GoogleSignInAuthentication gAuth = await gUser!.authentication;
    // new user credentials
    final credential = GoogleAuthProvider.credential(
      accessToken: gAuth.accessToken,
      idToken: gAuth.idToken,
    );
    // sign In
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
