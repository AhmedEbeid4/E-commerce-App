import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/exceptions.dart';

class AuthService {
  FirebaseAuth firebaseAuth;

  AuthService(this.firebaseAuth);

  Future<String?> signUp(String email, String password) async {
    UserCredential userCredential =
        await firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    await firebaseAuth.currentUser!.sendEmailVerification();
    return userCredential.user?.uid;
  }

  Future<String?> signIn(String email, String password) async {
    UserCredential userCredential =
        await firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    if (!firebaseAuth.currentUser!.emailVerified) {
      throw NotVerifiedException();
    }
    return userCredential.user?.uid;
  }

  void observeAuthState(Function(User?) callback) {
    firebaseAuth.authStateChanges().listen((user) {
      callback(user);
    });
  }

  Future<void> resetPassword(String email) async {
    await firebaseAuth.sendPasswordResetEmail(email: email);
  }

  Future changePassword(
      String email, String oldPassword, String newPassword) async {
    final user = firebaseAuth.currentUser;
    final authCredential =
        EmailAuthProvider.credential(email: email, password: oldPassword);

    await user!.reauthenticateWithCredential(authCredential);
    user.updatePassword(newPassword);
  }

  Future logout() async {
    await firebaseAuth.signOut();
  }

  Future deleteAccount() async {
    await firebaseAuth.currentUser!.delete();
  }
}
