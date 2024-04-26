import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/start_page_controller.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final controller = Get.put(StartPageController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Home Page'),
        actions: [
          IconButton(
              onPressed: () => controller.signOutMethode(),
              icon: const Icon(Icons.exit_to_app))
        ],
      ),
    );
  }
}
