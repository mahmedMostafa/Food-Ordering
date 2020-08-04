import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:res_delivery/utils/session_management.dart';

class AuthRepository {
  //i'm just too lazy to inject them :D
  final _googleSignIn = GoogleSignIn();
  final _root = Firestore.instance.collection("users");
  final _auth = FirebaseAuth.instance;

  Future loginUser(String email, String password) async {
    final AuthResult _user = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    print("Gemy called from here");
    await _root.document(_user.user.uid).get().then((document) {
      return SessionManagement.saveUserData(
          email, document.data['name'], _user.user.uid);
    });
  }

  Future<void> gmailLogin() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    final firebaseUser = await _auth.signInWithCredential(credential);
    return SessionManagement.saveUserData(firebaseUser.user.email,
        firebaseUser.user.displayName, firebaseUser.user.uid);
  }

  Future registerUser(String email, String password, String name) async {
    final AuthResult _user = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
    final userId = _user.user.uid;
    await SessionManagement.saveUserData(email, name, userId);
    print(
        "Saved Data ${SessionManagement.getValue(SessionManagement.USER_ID_KEY)}");
    return await _root.document(userId).setData({'email': email, 'name': name});
  }

  void facebookLogin() async {
    final facebookLogin = FacebookLogin();
    final result = await facebookLogin.logIn(['email']);
    final token = result.accessToken.token;
    final graphResponse = await http.get(
        'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email&access_token=${token}');
    print(graphResponse.body);
    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        print(result.accessToken.token);
        final credential =
            FacebookAuthProvider.getCredential(accessToken: token);
        _auth.signInWithCredential(credential);
//        _showLoggedInUI();
        break;
      case FacebookLoginStatus.cancelledByUser:
//        _showCancelledMessage();
        break;
      case FacebookLoginStatus.error:
        print("Error is ${result.errorMessage}");
//        _showErrorOnUI(result.errorMessage);
        break;
    }
  }
}
