import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:to_do_list_app/fi_a3_uzair_add_data_screen.dart';
import 'package:to_do_list_app/fi_a3_uzair_data_operations.dart';
import 'package:to_do_list_app/fi_a3_uzair_edit_screen.dart';

class DisplayDataScreen extends StatelessWidget {
  const DisplayDataScreen({super.key});

  navigation(BuildContext context, Widget next) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => next));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            navigation(context, AddContentScreen());
          },
          backgroundColor: const Color.fromARGB(255, 193, 110, 21),
          child: const Icon(Icons.add),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        appBar: AppBar(
          title: const Text(
            "Viewing all tasks",
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 25),
          ),
          centerTitle: true,
          backgroundColor: Colors.orange,
        ),
        body: Padding(
          padding: const EdgeInsets.all(15),
          child: StreamBuilder(
              stream: data.collection("Notes").snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (BuildContext context, int index) {
                      final response = snapshot.data!.docs[index];
                      return Dismissible(
                        key: UniqueKey(),
                        background: Container(
                          color: Colors.red,
                        ),
                        onDismissed: (v) {
                          DataOperations.delete(response.id);
                          _showNoteDeletedPopup(context);
                        },
                        child: Card(
                          child: ExpansionTile(
                            title: Text(
                              "${response['title']}",
                              style: const TextStyle(fontSize: 20),
                            ),
                            leading: IconButton(
                                onPressed: () {
                                  navigation(
                                    context,
                                    EditContentScreen(
                                      id: response.id,
                                      title: response['title'],
                                      detail: response['detail'],
                                    ),
                                  );
                                },
                                icon: const Icon(Icons.edit)),
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(15),
                                child: Text(
                                  "${response['detail']}",
                                  style: const TextStyle(fontSize: 20),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
        ));
  }
}

void _showNoteDeletedPopup(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Note Deleted Successfully'),
        content: const Text('Your note has been deleted successfully'),
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
