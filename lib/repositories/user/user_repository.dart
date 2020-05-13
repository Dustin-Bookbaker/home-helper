import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UserRepository {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  UserRepository({FirebaseAuth firebaseAuth, GoogleSignIn googleSignIn})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _googleSignIn = googleSignIn ?? GoogleSignIn();

  Future<FirebaseUser> signInWithGoogle() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    await _firebaseAuth.signInWithCredential(credential);
    return _firebaseAuth.currentUser();
  }

  Future<void> signInWithCredentials(String email, String password) {
    return _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> signUp({String email, String password}) async {
    await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> addUserToFireStore({String userName}) async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    UserUpdateInfo info = new UserUpdateInfo();
    info.displayName = userName;
    await user.updateProfile(info);
    await user.reload();
    user = await FirebaseAuth.instance.currentUser();

    Firestore.instance.collection('helperUsers').document().setData({
      'name': user.displayName,
      'uid': user.uid,
      'email': user.email,
      'rating': 0,
      'score': 0.0,
      'imagePath': '',
    });
  }

  String getUserImagePath(String name, String uid) {
    var path = '';
    Firestore.instance
        .collection('helperUsers')
        .where('uid', isEqualTo: uid)
        .where('name', isEqualTo: name)
        .getDocuments()
        .then(
      (snapshot) {
        path = snapshot.documents.first['imagePath'];
      },
    );
    return path;
  }

  Future<void> signOut() async {
    return Future.wait([
      _firebaseAuth.signOut(),
      _googleSignIn.signOut(),
    ]);
  }

  Future<bool> isSignedIn() async {
    final currentUser = await _firebaseAuth.currentUser();
    return currentUser != null;
  }

  Future<String> getUser() async {
    return (await _firebaseAuth.currentUser()).uid;
  }
}
