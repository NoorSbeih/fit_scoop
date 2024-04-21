// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:google_sign_in/google_sign_in.dart';
//
// import '../main.dart';
//
//
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(MyApp());
// }
//
// final GoogleSignIn googleSignIn = GoogleSignIn();
//
// Future<void> signInWithGoogle() async {
//   try {
//     final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
//     final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount!.authentication;
//
//     final AuthCredential credential = GoogleAuthProvider.credential(
//       accessToken: googleSignInAuthentication.accessToken,
//       idToken: googleSignInAuthentication.idToken,
//     );
//
//     final UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
//     final User? user = userCredential.user;
//
//     // Use the user object for further operations or navigate to a new screen.
//   } catch (e) {
//     print(e.toString());
//   }
// }
