import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/screens/widgets/add_photo.dart';
// import 'package:project/screens/CRUD/model/crud_model.dart';

import '../../widgets/custom_painter.dart';
import '../../widgets/input_text.dart';
import '../controller/crud_controller.dart';

class EditPage extends StatelessWidget {
  const EditPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CrudController());

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Edit Post'),
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
                hintText: controller.titleController.text =
                    Get.arguments['title'],
                icon: Icons.title,
                textMaxLines: 5,
              ),
              const SizedBox(height: 20),
              InputText(
                textMaxLines: 5,
                controller: controller.descriptonController,
                labale: 'Description',
                hintText: controller.descriptonController.text =
                    Get.arguments['description'],
                icon: Icons.description,
                textMinLines: 5,
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 160,
                    height: 60,
                    child: ElevatedButton(
                      style: const ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(Colors.green),
                          elevation: MaterialStatePropertyAll(10),
                          shadowColor: MaterialStatePropertyAll(Colors.red)),
                      onPressed: () =>
                          controller.updateData(Get.arguments['id']),
                      child: const Text(
                        'Update',
                        style: TextStyle(fontSize: 25),
                      ),
                    ),
                  ),
                  // const SizedBox(width: 15),
                  // SizedBox(
                  //   width: 160,
                  //   height: 60,
                  //   child: ElevatedButton(
                  //     style: const ButtonStyle(
                  //         backgroundColor:
                  //             MaterialStatePropertyAll(Colors.green),
                  //         elevation: MaterialStatePropertyAll(10),
                  //         shadowColor: MaterialStatePropertyAll(Colors.red)),
                  //     onPressed: () {
                  //       controller.deleteImg(controller.fileName1);
                  //       controller.updateData(Get.arguments['id']);
                  //     },
                  //     child: const Text(
                  //       'Delete Image',
                  //       style: TextStyle(fontSize: 15),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
              const SizedBox(height: 20),
              Obx(() {
                return AddPhoto(
                  w: 200,
                  h: 165,
                  widget: Align(
                    alignment: Alignment.center,
                    child: controller.uploadImgLoading.value == true
                        ? const Center(child: CircularProgressIndicator())
                        // ignore: unrelated_type_equality_checks
                        : controller.imgUrl1.value == ''
                            ? const Icon(
                                Icons.upload_file,
                                color: Colors.amber,
                                size: 55,
                              )
                            : AddPhoto(
                                w: 160,
                                h: 160,
                                onTap: () => controller.uploadImg(),
                                widget: ClipOval(
                                  child: Image.network(
                                    controller.imgUrl1.value,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                  ),
                );
              }),
              const SizedBox(height: 45),
              SizedBox(
                width: double.infinity,
                height: 70,
                child: CustomPaint(
                  size: const Size(double.infinity, double.infinity),
                  painter: RPSCustomPainter(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
