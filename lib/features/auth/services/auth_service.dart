import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:http/http.dart' as http;
import 'package:res_delivery/utils/session_management.dart';

class AuthService {
  final _root = Firestore.instance.collection("users");
  final _auth = FirebaseAuth.instance;
  final _shared = SessionManagement();

  Future loginUser(String email, String password) async {
    try {
      final AuthResult _user = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return await _root.document(_user.user.uid).get().then((document) {
        _shared.saveUserData(email, document.data['name'], _user.user.uid);
      });
    } catch (e) {
      print("Login error is ${e.toString()}");
    }
  }

  Future registerUser(String email, String password, String name) async {
    try {
      final AuthResult _user = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      final userId = _user.user.uid;
      _shared.saveUserData(email, name, userId);
      print("Saved Data ${_shared.getValue(SessionManagement.USER_ID_KEY)}");
      return await _root
          .document(userId)
          .setData({'email': email, 'name': name});
    } catch (error) {
      print(error.toString());
    }
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
