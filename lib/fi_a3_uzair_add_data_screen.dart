import 'package:flutter/material.dart';
import 'package:to_do_list_app/fi_a3_uzair_data_operations.dart';

// ignore: must_be_immutable
class AddContentScreen extends StatelessWidget {
  TextEditingController titleC = TextEditingController();
  TextEditingController detailC = TextEditingController();
  final formKey = GlobalKey<FormState>();
  AddContentScreen({super.key});
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
                        DataOperations.addData(titleC.text, detailC.text);
                        _showNoteAddedPopup(context);
                      }
                    },
                    child: const Text(
                      "ADD",
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
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
