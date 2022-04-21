import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:girl_hackathon/utils/resource.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:twitter_login/twitter_login.dart';
class AuthService {


  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = new GoogleSignIn();
  final fb=FacebookLogin();
  Future signUpEmailPassword(String email, String pass) async {
    try {
      User? user = (await _auth.
      createUserWithEmailAndPassword(email: email, password: pass))
          .user;

      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
  Stream<User?> get user{
    return _auth.authStateChanges();
  }
  Future signInEmailPassword(String email, String pass) async {
    try {
      User? user = (await _auth.
      signInWithEmailAndPassword(email: email, password: pass))
          .user;
      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
  Future<String?> signInwithGoogle(
      [bool link = false, AuthCredential? authCredential]) async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();

      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      if (link) {
        await linkProviders(userCredential, authCredential!);
      }
      return userCredential.user!.displayName;
    } on FirebaseAuthException catch (e) {
      throw e;
    }
  }
  

  Future<UserCredential?> linkProviders(UserCredential userCredential, AuthCredential newCredential) async {
    return await _auth.signInWithCredential(newCredential);
  }

  Future<Resource?> signInWithTwitter() async {
    final twitterLogin = TwitterLogin(
      apiKey: "<api-key>",
      apiSecretKey: "<api-secret-key>",
      redirectURI: "twitter-firebase-auth://",
    );
    final authResult = await twitterLogin.login();

    switch (authResult.status) {
      case TwitterLoginStatus.loggedIn:
        final AuthCredential twitterAuthCredential =
            TwitterAuthProvider.credential(
                accessToken: authResult.authToken!,
                secret: authResult.authTokenSecret!);

        final userCredential =
            await _auth.signInWithCredential(twitterAuthCredential);
        return Resource(status: Status.Success);
      case TwitterLoginStatus.cancelledByUser:
        return Resource(status: Status.Cancelled);
      case TwitterLoginStatus.error:
        return Resource(status: Status.Error);
      default:
        return null;
    }
  }

    Future<Resource?> signInWithFacebook() async {
      try {
      final LoginResult result = await FacebookAuth.instance.login();
    switch (result.status) {
      case LoginStatus.success:
        final AuthCredential facebookCredential =
            FacebookAuthProvider.credential(result.accessToken!.token);
        final userCredential =
            await _auth.signInWithCredential(facebookCredential);
        return Resource(status: Status.Success);
      case LoginStatus.cancelled:
        return Resource(status: Status.Cancelled);
      case LoginStatus.failed:
        return Resource(status: Status.Error);
      default:
        return null;
      }
      } on FirebaseAuthException catch (e) {
      throw e;
    }
  }

  Future<void> signOutFromGoogle() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
  }
  Future<User?> signInWithPhone(String code,String otp) async{
    UserCredential authResult = await _auth.signInWithCredential(PhoneAuthProvider.credential(
                          verificationId: code, smsCode: otp));
    final User? user = authResult.user;
    print(user);
    if (user != null) {
      final User? currentUser = _auth.currentUser;
      return user;
    }
    else {
      return null;
    }
  }
  // Future<User?> signInWithGoogle() async {
  //   final GoogleSignInAccount? googleSignInAccount = await _googleSignIn
  //       .signIn();
  //   final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount
  //       !.authentication;
  //   final AuthCredential credential = GoogleAuthProvider.credential(
  //     accessToken: googleSignInAuthentication.accessToken,
  //     idToken: googleSignInAuthentication.idToken,
  //   );
  //   final UserCredential authResult = await _auth.signInWithCredential(
  //       credential);
  //   final User? user = authResult.user;
  //   if (user != null) {
  //     assert(!user.isAnonymous);
  //     assert(await user.getIdToken() != null);
  //     final User? currentUser = _auth.currentUser;
  //     assert(user.uid == currentUser!.uid);
  //     return user;
  //   }
  //   else {
  //     return null;
  //   }
  // }

  //  Future facebookLogin() async {
  //   final res=await fb.logIn(
  //     permissions: [
  //       FacebookPermission.publicProfile,
  //       FacebookPermission.email
  //     ]
  //   );
  //   switch(res.status){
  //     case FacebookLoginStatus.success:
  //     final FacebookAccessToken? fbToken =res.accessToken;
  //     final AuthCredential credential=FacebookAuthProvider.credential(fbToken!.token);
  //     final result=await _auth.signInWithCredential(credential);
  //     return result.user;

  //     case FacebookLoginStatus.cancel:
  //       break;
  //     case FacebookLoginStatus.error:
  //       break;
  //   }
  // }
  Future signOut() async{
    try{
      return await _auth.signOut();
    }catch(e){
      print(e.toString());
      return null;

    }
  }
    }
