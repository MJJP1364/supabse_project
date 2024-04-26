import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class StartPageController extends GetxController {
  // Variables
  final SupabaseClient supabase = Supabase.instance.client;
  RxBool _signInLoading = false.obs;
  RxBool _signUpLoading = false.obs;
  final emailController = TextEditingController().obs;
  final passwordController = TextEditingController().obs;
  RxBool sufixIcon = false.obs;

  // Methodes
  void sufixIconMethod() {
    sufixIcon.value = !sufixIcon.value;
    print(sufixIcon.value);
  }
}
