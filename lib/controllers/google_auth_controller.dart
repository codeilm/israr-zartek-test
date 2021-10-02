import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:myfood/widgets/dialogs.dart';

class GoogleAuthController {
  final googleSignIn = GoogleSignIn();
  GoogleSignInAccount user;
  Future login() async {
    try {
      showLoader('Wait for few seconds');
      final googleUser = await googleSignIn.signIn();
      hideLoader();
      if (googleUser == null) return;
      user = googleUser;
      print(user.displayName);
      print(user.email);
      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
      await FirebaseAuth.instance.signInWithCredential(credential);
      hideLoader();
    } catch (e, s) {
      showError();
    }
  }

  Future logout() async {
    showLoader('Wait for few seconds');
    await googleSignIn.disconnect();
    await FirebaseAuth.instance.signOut();
    hideLoader();
  }
}
