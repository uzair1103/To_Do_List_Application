import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:to_do_list_app/fi_a3_uzair_data_operations.dart';

// ignore: must_be_immutable

class AddDataScreen extends StatefulWidget {
  const AddDataScreen({super.key});

  @override
  test createState() => test();
}

class test extends State<AddDataScreen> {
  TextEditingController titleC = TextEditingController();
  TextEditingController detailC = TextEditingController();
  final formKey = GlobalKey<FormState>();
  String onCloudUrl = '';
  File? file; // ignore: prefer_typing_uninitialized_variables
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      appBar: AppBar(
        title: const Text(
          "Add new task",
          style: TextStyle(
              fontWeight: FontWeight.bold, color: Colors.black, fontSize: 25),
        ),
        backgroundColor: Colors.orange,
        centerTitle: true,
      ),
      body: SafeArea(
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TextFormField(
                    controller: titleC,
                    validator: (v) {
                      if (v!.isEmpty) {
                        return ("Please enter title");
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                      labelText: "Enter title",
                      labelStyle: const TextStyle(fontSize: 20),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  TextFormField(
                    controller: detailC,
                    maxLines: 10,
                    minLines: 1,
                    validator: (v) {
                      if (v!.isEmpty) {
                        return ("Please enter details");
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                      labelText: "Enter description",
                      labelStyle: const TextStyle(fontSize: 20),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.orange)),
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          DataOperations.addData(
                              titleC.text, detailC.text, onCloudUrl);
                          _showNoteAddedPopup(context);
                        }
                      },
                      child: const Text(
                        "ADD",
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      )),
                  const SizedBox(height: 50),
                  ElevatedButton(
                    onPressed: () async {
                      final PermissionStatus status =
                          await Permission.storage.request();
                      if (!status.isGranted) {}
                      final res = await FilePicker.platform.pickFiles();
                      if (res != null) {
                        setState(() {
                          isLoading = true;
                        });

                        file = File(res.files.single.path!);

                        final onCloudFileUrl = await uploadImage(file!,
                            DateTime.now().microsecondsSinceEpoch.toString());
                        print('THE URL IS AS FOLLOWS');
                        print(onCloudUrl);
                        setState(() {
                          isLoading = false;
                          onCloudUrl = onCloudFileUrl;
                        });
                      }
                    },
                    child: const Text('Upload File'),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: isLoading
                          ? const CircularProgressIndicator()
                          : onCloudUrl.isNotEmpty
                              ? Image.network(onCloudUrl)
                              // ignore: sized_box_for_whitespace
                              : Center(
                                  child: Container(
                                  width: 200,
                                  height: 50,
                                  child: const Center(
                                      child: Text(
                                    "Image not uploaded yet",
                                    style: TextStyle(fontSize: 15),
                                  )),
                                )))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }
}

void _showNoteAddedPopup(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Note Added Successfully'),
        content: const Text('Your note has been added successfully'),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'))
        ],
      );
    },
  );
}

Future<String> uploadImage(File file, String name) async {
  final storage = FirebaseStorage.instance;
  final ref = storage.ref("images/$name");
  final uploadTask = ref.putFile(file);
  await uploadTask.whenComplete(() {
    debugPrint("Hello world");
  });
  return await ref.getDownloadURL();
}
