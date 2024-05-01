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
      final response = await supabase.from('todos').select();
      final result = response
          .map((data) => CrudModel(
                id: data['id'],
                title: data['title'],
                description: data['description'],
                user_id: data['user_id'],
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
    createPostLoading.value = true;
    try {
      await supabase.from('todos').insert({
        'title': titleController.text,
        'description': descriptonController.text,
        'user_id': userId
      });
      Get.back();
      Get.snackbar(
        'Add Post',
        'Success to Add Post',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
        margin: const EdgeInsets.all(15),
      );
      getData();
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
    updateDataLoading.value = true;
    try {
      await supabase.from('todos').update({
        'title': titleController.text,
        'description': descriptonController.text,
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
      Get.back();
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
}
