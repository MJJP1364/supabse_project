import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class StartPageController extends GetxController {
  // Variables
  final SupabaseClient supabase = Supabase.instance.client;
  RxBool signInLoading = false.obs;
  RxBool signUpLoading = false.obs;
  RxBool googlesignInLoading = false.obs;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  RxBool sufixIcon = true.obs;

  // Methodes
  void sufixIconMethod() {
    sufixIcon.value = !sufixIcon.value;
  }

  Future<void> googleSignIn() async {
    // if (!kIsWeb && (Platform.isAndroid || Platform.isIOS)) {
    try {
      googlesignInLoading.value = true;
      const webClientId =
          '420276707590-9mja8n3jnia0qhgj57pbvtd1ts5b34ak.apps.googleusercontent.com';

      const iosClientId =
          '420276707590-be3meu5423lvecntb7c3935og3igsidr.apps.googleusercontent.com';

      final GoogleSignIn googleSignIn = GoogleSignIn(
        clientId: iosClientId,
        serverClientId: webClientId,
      );
      final googleUser = await googleSignIn.signIn();
      final googleAuth = await googleUser!.authentication;
      final accessToken = googleAuth.accessToken;
      final idToken = googleAuth.idToken;

      if (accessToken == null) {
        throw 'No Access Token found.';
      }
      if (idToken == null) {
        throw 'No ID Token found.';
      }

      await supabase.auth.signInWithIdToken(
        provider: OAuthProvider.google,
        idToken: idToken,
        accessToken: accessToken,
      );
      Get.snackbar(
        'SignIn With Google',
        'Success to SignIn',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
        margin: const EdgeInsets.all(15),
      );
      signUpLoading.value = false;
    } catch (e) {
      signUpLoading.value = false;
      Get.snackbar(
        'SignIn',
        'Failed to SignIn With Google',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        margin: const EdgeInsets.all(15),
      );
    } finally {
      signUpLoading.value = false;
    }
    // }
    // await supabase.auth.signInWithOAuth(OAuthProvider.google);
  }

  Future<void> signUpMethod() async {
    signUpLoading.value = true;
    try {
      await supabase.auth.signUp(
        email: '${emailController.text.trim()}@gmail.com',
        password: passwordController.text.trim(),
      );
      Get.snackbar(
        'SignUp',
        'Success to SignUp',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
        margin: const EdgeInsets.all(15),
      );
      signUpLoading.value = false;
    } catch (e) {
      Get.snackbar(
        'SignUp',
        'Failed to SignUp',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        margin: const EdgeInsets.all(15),
      );
    } finally {
      signUpLoading.value = false;
    }
  }

  Future<void> signInMethod() async {
    signInLoading.value = true;
    try {
      await supabase.auth.signInWithPassword(
        email: '${emailController.text.trim()}@gmail.com',
        password: passwordController.text.trim(),
      );
      Get.snackbar(
        'SignIn',
        'Success to SignIn',
        snackPosition: SnackPosition.BOTTOM,
        colorText: Colors.white,
        backgroundColor: Colors.green.withOpacity(0.4),
        margin: const EdgeInsets.all(15),
      );
      signUpLoading.value = false;
    } catch (e) {
      Get.snackbar(
        'SignIn',
        'Failed to SignIn',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        margin: const EdgeInsets.all(15),
      );
    } finally {
      signInLoading.value = false;
    }
  }

  Future<void> signOutMethode() async {
    emailController.text = '';
    passwordController.text = '';
    signInLoading.value = false;
    signUpLoading.value = false;
    googlesignInLoading.value = false;
    await supabase.auth.signOut();
  }
}
