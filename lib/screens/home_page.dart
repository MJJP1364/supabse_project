import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/screens/CRUD/controller/crud_controller.dart';
import 'package:project/screens/CRUD/view/create_page.dart';
import 'package:project/screens/CRUD/view/edit_page.dart';
import 'package:project/screens/widgets/add_photo.dart';

import '../controller/start_page_controller.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(StartPageController());
    final datacontroller = Get.put(CrudController());
    return Scaffold(
      // backgroundColor: const Color.fromARGB(255, 158, 158, 158),
      appBar: AppBar(
        elevation: 0,
        // backgroundColor: const Color.fromARGB(255, 158, 158, 158),
        centerTitle: true,
        title: const Text('Home Page'),
        actions: [
          IconButton(
              onPressed: () => controller.signOutMethode(),
              icon: const Icon(Icons.exit_to_app))
        ],
      ),
      body: RefreshIndicator(
        onRefresh: datacontroller.getData,
        child: Obx(
          () => datacontroller.getdataList.isEmpty
              ? const Center(
                  child: Text(
                    'No Post Avalable',
                    style: TextStyle(fontSize: 25),
                  ),
                )
              : ListView.separated(
                  itemCount: datacontroller.getdataList.length,
                  itemBuilder: (context, index) {
                    var data = datacontroller.getdataList[index];
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () {
                            datacontroller.getData();
                            Get.to(() => const EditPage(),
                                arguments: {
                                  'title': data.title,
                                  'description': data.description,
                                  'id': data.id,
                                  'user_id': data.user_id,
                                  'img_url': data.imgUrl,
                                },
                                duration: const Duration(milliseconds: 1000),
                                transition: Transition.fadeIn);
                          },
                          child: Card(
                            color: Colors.blue[800],
                            elevation: 10,
                            shadowColor: Colors.amber,
                            child: SizedBox(
                              width: double.infinity,
                              height: 150,
                              child: Stack(
                                children: [
                                  Positioned(
                                    left: 20,
                                    top: 15,
                                    child: Text(
                                      // ignore: prefer_interpolation_to_compose_strings
                                      'Title: ' + data.title,
                                      style: const TextStyle(
                                          color: Colors.white, fontSize: 30),
                                    ),
                                  ),
                                  Positioned(
                                    left: 20,
                                    top: 60,
                                    child: Text(
                                      // ignore: prefer_interpolation_to_compose_strings
                                      'Description: ' + data.description,

                                      style: const TextStyle(
                                          color: Colors.white, fontSize: 25),
                                    ),
                                  ),
                                  // ignore: unrelated_type_equality_checks
                                  datacontroller.deleteDataLoading == true
                                      ? const Center(
                                          child: CircularProgressIndicator(),
                                        )
                                      : Positioned(
                                          right: 15,
                                          bottom: 10,
                                          child: SizedBox(
                                            width: 100,
                                            height: 40,
                                            child: ElevatedButton(
                                              style: const ButtonStyle(
                                                  backgroundColor:
                                                      MaterialStatePropertyAll(
                                                          Colors.green),
                                                  elevation:
                                                      MaterialStatePropertyAll(
                                                          10),
                                                  shadowColor:
                                                      MaterialStatePropertyAll(
                                                          Colors.red)),
                                              onPressed: () {
                                                datacontroller
                                                    .deleteImg(data.fileName);
                                                datacontroller
                                                    .deleteData(data.id);
                                              },
                                              child: const Text(
                                                'Delete',
                                                style: TextStyle(fontSize: 15),
                                              ),
                                            ),
                                          ),
                                        ),
                                  Positioned(
                                    right: 10,
                                    top: 10,
                                    child: data.imgUrl == ''
                                        ? const AddPhoto(
                                            w: 70,
                                            h: 70,
                                            widget: Align(
                                              alignment: Alignment.center,
                                              child: Icon(
                                                Icons.upload_file,
                                                color: Colors.amber,
                                                size: 35,
                                              ),
                                            ),
                                          )
                                        : AddPhoto(
                                            h: 70,
                                            w: 70,
                                            widget: ClipOval(
                                              child: Image.network(
                                                data.imgUrl,
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                          ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => Divider(
                    indent: 20,
                    endIndent: 20,
                    thickness: 2,
                    color: Colors.red[900],
                  ),
                ),
        ),
      ),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Get.to(() => CreatePage(),
              duration: const Duration(milliseconds: 1000),
              transition: Transition.fadeIn);
          datacontroller.titleController.text = '';
          datacontroller.descriptonController.text = '';
          datacontroller.imgUrl1.value = '';
        },
        label: const Text('Add Post'),
      ),
    );
  }
}
