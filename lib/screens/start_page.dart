import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/controller/start_page_controller.dart';
import 'package:project/screens/widgets/input_text.dart';

class StartPage extends StatelessWidget {
  StartPage({super.key});
  final controller = Get.put(StartPageController());
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Start Page'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Image.network(
                  "https://cf.appdrag.com/dashboard-openvm-clo-b2d42c/uploads/supabase-TAiY.png",
                  height: 200,
                  width: 200,
                ),
                const SizedBox(height: 10),
                const Text(
                  textAlign: TextAlign.center,
                  'Supabase Project',
                  style: TextStyle(
                    fontSize: 25,
                    shadows: [
                      BoxShadow(
                          color: Colors.blue,
                          offset: Offset(5, 5),
                          blurRadius: 10),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                InputText(
                  controller: controller.emailController,
                  icon: Icons.email,
                  labale: 'Email',
                  hintText: 'Please Enter Email',
                ),
                const SizedBox(height: 10),
                Obx(
                  () => InputText(
                    controller: controller.passwordController,
                    labale: 'password',
                    hintText: 'Enter Password',
                    icon: Icons.password,
                    obsecured: controller.sufixIcon.value,
                    onTap: controller.sufixIconMethod,
                    // ignore: unrelated_type_equality_checks
                    sufixe: controller.sufixIcon == false
                        ? Icons.remove_red_eye
                        : Icons.remove_red_eye_outlined,
                  ),
                ),
                const SizedBox(height: 10),
                Obx(
                  () => controller.signInLoading.value
                      ? const Center(child: CircularProgressIndicator())
                      : ElevatedButton(
                          onPressed: () => controller.signInMethod(),
                          child: const Text('Login')),
                ),
                const SizedBox(height: 10),
                Obx(
                  // ignore: unrelated_type_equality_checks
                  () => controller.signUpLoading == true
                      ? const Center(child: CircularProgressIndicator())
                      : OutlinedButton(
                          onPressed: () {
                            final isValid = _formKey.currentState?.validate();
                            if (isValid == true) {
                              controller.signUpMethod();
                            }
                          },
                          child: const Text('Sing Up')),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
