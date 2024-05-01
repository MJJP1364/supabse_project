import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/screens/CRUD/controller/crud_controller.dart';
import 'package:project/screens/widgets/input_text.dart';

class CreatePage extends StatelessWidget {
  const CreatePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CrudController());
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Create Post'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InputText(
                controller: controller.titleController,
                labale: 'Title',
                hintText: 'Title',
                icon: Icons.title,
              ),
              const SizedBox(height: 20),
              InputText(
                controller: controller.descriptonController,
                labale: 'Description',
                hintText: 'Enter Description',
                icon: Icons.description,
                textMinLines: 5,
                textMaxLines: 10,
              ),
              const SizedBox(height: 20),
              // ignore: unrelated_type_equality_checks
              Obx(
                // ignore: unrelated_type_equality_checks
                () => controller.createPostLoading == true
                    ? const Center(child: CircularProgressIndicator())
                    : SizedBox(
                        width: 160,
                        height: 60,
                        child: ElevatedButton(
                          style: const ButtonStyle(
                              backgroundColor:
                                  MaterialStatePropertyAll(Colors.green),
                              elevation: MaterialStatePropertyAll(10),
                              shadowColor:
                                  MaterialStatePropertyAll(Colors.red)),
                          onPressed: () => controller.addPost(),
                          child: const Text(
                            'Add Post',
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
