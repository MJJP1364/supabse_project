import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class StartPageController extends GetxController {
  // Variables
  final SupabaseClient supabase = Supabase.instance.client;
  RxBool signInLoading = false.obs;
  RxBool signUpLoading = false.obs;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  RxBool sufixIcon = false.obs;

  // Methodes
  void sufixIconMethod() {
    sufixIcon.value = !sufixIcon.value;
  }

  Future<void> signUpMethod() async {
    signUpLoading.value = true;
    try {
      await supabase.auth.signUp(
        email: '${emailController.text.trim()}@gmail.com',
        password: passwordController.text.trim(),
      );
      Get.snackbar('SignUp', 'Success to SignUp',
          snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.green);
      signUpLoading.value = false;
    } catch (e) {
      Get.snackbar('SignUp', 'Failed to SignUp',
          snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red);
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
      Get.snackbar('SignIn', 'Success to SignIn',
          snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.green);
      signUpLoading.value = false;
    } catch (e) {
      Get.snackbar('SignIn', 'Failed to SignIn',
          snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red);
    } finally {
      signInLoading.value = false;
    }
  }

  Future<void> signOutMethode() async {
    emailController.text = '';
    passwordController.text = '';
    await supabase.auth.signOut();
  }
}
