import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../model/crud_model.dart';

class CrudController extends GetxController {
  // Variables
  final titleController = TextEditingController();
  final descriptonController = TextEditingController();
  final supabase = Supabase.instance.client;
  RxBool createPostLoading = false.obs;
  RxBool postsLoading = false.obs;
  RxBool getDataLoading = false.obs;
  RxBool updateDataLoading = false.obs;
  RxBool deleteDataLoading = false.obs;
  RxBool uploadImgLoading = false.obs;
  RxString imgUrl1 = ''.obs;
  String fileName1 = '';
  RxList getdataList = [].obs;

  @override
  void onInit() {
    getData();
    super.onInit();
  }

  // Methods

  Future<void> getData() async {
    getDataLoading.value = true;
    try {
      final response = await supabase
          .from('todos')
          .select()
          .order('id', ascending: false)
          .limit(10);
      final result = response
          .map((data) => CrudModel(
                id: data['id'],
                title: data['title'],
                description: data['description'],
                user_id: data['user_id'],
                imgUrl: data['img_url'],
                fileName: data['file_name'],
              ))
          .toList();

      getdataList.value = result;
      getDataLoading.value = false;
      // return notes;
    } catch (e) {
      Get.snackbar(
        'Create Post',
        'Failed to Fetch Posts',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        margin: const EdgeInsets.all(15),
      );
      getDataLoading.value = false;
      // throw Exception('Failed to retrieve notes');
    }
  }

  Future<void> addPost() async {
    String userId = supabase.auth.currentUser!.id;
    String? imgUrl = imgUrl1.value;
    String? fileName = fileName1;
    createPostLoading.value = true;
    try {
      await supabase.from('todos').insert({
        'title': titleController.text,
        'description': descriptonController.text,
        'user_id': userId,
        'img_url': imgUrl,
        'file_name': fileName,
      });
      getData();
      Get.back();
      Get.snackbar(
        'Add Post',
        'Success to Add Post',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
        margin: const EdgeInsets.all(15),
      );

      createPostLoading.value = false;
    } catch (e) {
      createPostLoading.value = false;
      Get.snackbar(
        'Create Post',
        'Failed to Create Post',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        margin: const EdgeInsets.all(15),
      );
    }
  }

  Future<void> updateData(int id) async {
    getData();
    String? imgUrl = imgUrl1.value;
    String? fileName = fileName1;
    updateDataLoading.value = true;

    try {
      await supabase.from('todos').update({
        'title': titleController.text,
        'description': descriptonController.text,
        'img_url': imgUrl,
        'file_name': fileName,
      }).eq('id', id);
      getData();
      Get.back();
      Get.snackbar('Update Post', 'Success to Update Post',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
          margin: const EdgeInsets.all(15));

      updateDataLoading.value = false;
    } catch (e) {
      updateDataLoading.value = false;
      Get.snackbar(
        'Update Post',
        'Failed to Update Post',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        margin: const EdgeInsets.all(15),
      );
    }
  }

  Future<void> deleteData(int id) async {
    deleteDataLoading.value = true;

    try {
      await supabase.from('todos').delete().eq('id', id);
      deleteDataLoading.value = false;
      getData();

      Get.snackbar('Delete Post', 'Success to Delete Post',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
          margin: const EdgeInsets.all(15));
      deleteDataLoading.value = false;
    } catch (e) {
      deleteDataLoading.value = false;
      Get.snackbar(
        'Delete Post',
        'Failed to Delete Post',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        margin: const EdgeInsets.all(15),
      );
    }
  }

  // ignore: body_might_complete_normally_nullable
  Future<String?> uploadImg() async {
    var pickFile = await FilePicker.platform
        .pickFiles(allowMultiple: false, type: FileType.image);

    if (pickFile != null) {
      uploadImgLoading.value = true;

      try {
        File file = File(pickFile.files.first.path!);
        String fileName = pickFile.files.first.name;
        await supabase.storage
            .from('user_images')
            .upload('${supabase.auth.currentUser!.id}/$fileName', file);
        String fileUrl = supabase.storage
            .from('user_images')
            .getPublicUrl('${supabase.auth.currentUser!.id}/$fileName');

        Get.snackbar('Add Image', 'Success to Add Image',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green,
            colorText: Colors.white,
            margin: const EdgeInsets.all(15));
        uploadImgLoading.value = false;
        imgUrl1.value = fileUrl;
        fileName1 = fileName;
      } catch (e) {
        uploadImgLoading.value = false;
        Get.snackbar(
          'Add Image',
          'Failed to Add Image',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          margin: const EdgeInsets.all(15),
        );
      }
    }
  }

  Future<void> deleteImg(String fileName) async {
    await supabase.storage
        .from('user_images')
        .remove(["${supabase.auth.currentUser!.id}/$fileName"]);
  }
}
