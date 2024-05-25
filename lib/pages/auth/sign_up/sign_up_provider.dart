import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shecker_partners/entity/user_entity.dart';
import 'package:shecker_partners/provider/firebase_provider.dart';
import 'package:shecker_partners/provider/localization_provider.dart';
import 'package:shecker_partners/provider/store_provider.dart';
import 'package:shecker_partners/utils/snackbar_util.dart';
import 'package:flareline_uikit/service/base_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/utils.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';

class SignUpProvider extends BaseProvider {
  final box = GetStorage();

  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController rePasswordController;
  late TextEditingController businessNameController;

  SignUpProvider(super.context) {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    rePasswordController = TextEditingController();
    businessNameController = TextEditingController();
  }

  Future<void> signUp(BuildContext context) async {
    if (emailController.text.isEmpty ||
        passwordController.text.isEmpty ||
        rePasswordController.text != passwordController.text ||
        businessNameController.text.isEmpty) {
      SnackBarUtil.showSnack(context, 'Please enter your info');
      return;
    }
    if (passwordController.text.trim().length < 6) {
      SnackBarUtil.showSnack(context, 'Please enter 6+ Characters password');
      return;
    }

    try {
      UserCredential credential =
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      debugPrint('credential $credential');
      if (credential.user != null) {
        User? user = credential.user;
        if (user != null) {
          context.read<StoreProvider>().saveEmail(user.email);

          await FirebaseAuth.instance.setLanguageCode(
              context.read<LocalizationProvider>().languageCode);
          await user.sendEmailVerification();

          // Save user data to Firestore
          await FirebaseFirestore.instance.collection('staff').doc(user.uid).set({
            'email': user.email,
            'id': user.uid,
            'name': user.displayName ?? 'No Name',
            'role': 'user',
            'username': user.email!.split('@').first,
            'business_name': businessNameController.text.trim(),
            'created_at': user.metadata.creationTime?.toIso8601String(),
          });

          SnackBarUtil.showSuccess(
              context, 'Sign Up Success, Please verify your email');
          Navigator.of(context).popAndPushNamed('/signIn');
        }
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        SnackBarUtil.showSnack(context, 'The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        SnackBarUtil.showSnack(
            context, 'The account already exists for that email.');
        Navigator.of(context).popAndPushNamed('/signIn');
      } else if (e.code == 'network-request-failed') {
        SnackBarUtil.showSnack(context, 'Network error. Please try again.');
      } else {
        SnackBarUtil.showSnack(context, 'Authentication error: ${e.message}');
      }
    } catch (e) {
      SnackBarUtil.showSnack(context, 'Error: ${e.toString()}');
    }
  }
}
