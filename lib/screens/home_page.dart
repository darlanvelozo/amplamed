import 'dart:html';

import 'package:amplamed/screens/add_page.dart';
import 'package:amplamed/screens/edite_page.dart';
import 'package:amplamed/screens/visu_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

//0xffccaa6a
class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff4da5aa),
        title: const Center(child: Text("alugueis")),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('alugueis').snapshots(),
        builder: (BuildContext context,
            AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (!streamSnapshot.hasData) {
            return const Center(
              child: Text("vazio"),
            );
          }
          return ListView.builder(
            itemCount: streamSnapshot.data!.docs.length,
            itemBuilder: (context, index) {
              final DocumentSnapshot documentSnapshot =
                  streamSnapshot.data!.docs[index];

              void deletar(BuildContext context) {
                FirebaseFirestore.instance
                    .collection('alugueis')
                    .doc(documentSnapshot['id'])
                    .delete();
              }

              return Slidable(
                child: InkWell(
                  splashColor: const Color(0xff4da5aa),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const VisuPage()),
                    );
                  },
                  child: Card(
                    child: ListTile(
                      title: Text(documentSnapshot['nome']),
                      subtitle: Text(documentSnapshot['id'].toString()),
                      trailing: SizedBox(
                        width: 50,
                        child: Row(
                          children: [
                            IconButton(
                                icon: const Icon(Icons.edit,
                                    color: Color(0xffccaa6a)),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => EditePage(
                                              idnome: documentSnapshot['id'],
                                            )),
                                  );
                                }),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                endActionPane: ActionPane(
                  motion: const ScrollMotion(),
                  children: [
                    SlidableAction(
                        onPressed: deletar,
                        icon: Icons.delete,
                        backgroundColor: const Color(0xff4da5aa),
                        foregroundColor: const Color(0xffccaa6a))
                  ],
                  extentRatio: 1 / 5,
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AddPage(
                      id: id,
                    )),
          );
          id += 1;
        },
        child: const Icon(Icons.add),
        backgroundColor: const Color(0xffccaa6a),
      ),
    );
  }
}
