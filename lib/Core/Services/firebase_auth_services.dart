import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fruits_app/Core/Errors/exception.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FireBaseAuthService {
  Future<User> createUserWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential.user!;
    } on FirebaseAuthException catch (e) {
      log('Exception in Fire Base Auth Service.createUserWithEmailAndPassword : ${e.toString()} And Code Is ${e.code}');

      if (e.code == 'weak-password') {
        throw CustomException(
          message: 'هذا الرقم السري ضعيف جدا',
        );
      } else if (e.code == 'email-already-in-use') {
        throw CustomException(
          message:
              'هذا البريد الالكتروني مستخدم مسبقاً , الرجاء إدخال بريد الكتروني اخر',
        );
      } else if (e.code == 'network-request-failed') {
        throw CustomException(
            message: 'تأكد من اتصالك من الإنترنت , حاول مرة أخرى');
      } else if (e.code == 'invalid-email') {
        throw CustomException(
            message: 'البريد الالكتروني غير صالح  , حاول مرة أخرى');
      } else {
        throw CustomException(
            message: 'هناك خطأ ما , الرجاء المحاولة مرة اخرى');
      }
    } catch (e) {
      log('Exception in FireBaseAuthService.createUserWithEmailAndPassword : ${e.toString()}');
      throw CustomException(
        message: 'هناك خطأ ما , الرجاء المحاولة مرة اخرى',
      );
    }
  }

  Future<User> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return credential.user!;
    } on FirebaseAuthException catch (e) {
      log('Exception in Fire Base Auth Service.signInWithEmailAndPassword : ${e.toString()} And Code Is ${e.code}');
      if (e.code == 'invalid-credential') {
        throw CustomException(
          message: 'البريد الالكتروني او كلمة السر خاطئة',
        );
      } else if (e.code == 'network-request-failed') {
        throw CustomException(
            message: 'تأكد من اتصالك من الإنترنت , حاول مرة أخرى');
      } else if (e.code == 'too-many-requests') {
        throw CustomException(
            message:
                'لقد تجاوزت الحد الأقصى من الطلبات , الرجاء المحاولة مرة أخرى في وقت لاحق');
      } else {
        throw CustomException(
            message: 'هناك خطأ ما , الرجاء المحاولة مرة اخرى');
      }
    } catch (e) {
      log('Exception in FireBaseAuthService.signInWithEmailAndPassword : ${e.toString()}');
      throw CustomException(
        message: 'هناك خطأ ما , الرجاء المحاولة مرة اخرى',
      );
    }
  }

  Future<User> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    return (await FirebaseAuth.instance.signInWithCredential(credential)).user!;
  }
}
