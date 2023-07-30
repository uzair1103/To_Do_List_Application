import 'package:flutter/material.dart';

import 'fi_a3_uzair_data_operations.dart';

// ignore: must_be_immutable
class EditContentScreen extends StatelessWidget {
  TextEditingController titleC = TextEditingController();
  TextEditingController detailC = TextEditingController();
  final formKey = GlobalKey<FormState>();
  String? title;
  String? detail;
  String? id;
  EditContentScreen({Key? key, this.id, this.title, this.detail})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Update task",
          style: TextStyle(
              fontSize: 25, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        backgroundColor: Colors.orange,
        centerTitle: true,
      ),
      body: SafeArea(
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(20),
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
                    labelText: "$title",
                    labelStyle: const TextStyle(fontSize: 20),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                TextFormField(
                  controller: detailC,
                  maxLines: null,

                  //expands: true,
                  validator: (v) {
                    if (v!.isEmpty) {
                      return ("Please enter details");
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                    labelText: "$detail",
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
                        DataOperations.updateData(
                            id!, titleC.text, detailC.text);
                        _showNoteUpdatedPopup(context);
                      }
                    },
                    child: const Text(
                      "UPDATE",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 20),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void _showNoteUpdatedPopup(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Note Updated Successfully'),
        content: const Text('Your note has been updated successfully'),
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
