import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/colors.dart';
import 'package:emart_app/consts/styles.dart';
import 'package:emart_app/services/firestore_services.dart';
import 'package:emart_app/views/chat_screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "My Messages",
          style: TextStyle(
              color: darkFontGrey, fontFamily: (semibold), fontSize: 18),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: StreamBuilder(
            stream: FirestoreServices.getAllMessages(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.data!.docs.isEmpty) {
                return const Center(child: Text('No messages found!'));
              } else {
                return Column(
                  children: [
                    Expanded(
                        child: ListView.separated(
                            itemCount: snapshot.data!.docs.length,
                            separatorBuilder: (context, index) =>
                                const SizedBox(height: 5),
                            itemBuilder: (context, index) {
                              var itemData = snapshot.data!.docs[index];
                              return Card(
                                child: ListTile(
                                  onTap: () {
                                    Get.to(() => const ChatScreen(),
                                        arguments: [
                                          itemData['friend_name'].toString(),
                                          itemData['toId'].toString(),
                                        ]);
                                  },
                                  title: Text(
                                    itemData['friend_name'],
                                    style: const TextStyle(
                                        color: darkFontGrey,
                                        fontFamily: (semibold)),
                                  ),
                                  subtitle: Text(
                                    itemData['last_msg'],
                                    style: TextStyle(
                                        color: Colors.grey[400],
                                        fontSize: 12,
                                        fontFamily: (semibold)),
                                  ),
                                  leading: const CircleAvatar(
                                      backgroundColor: redColor,
                                      child: Icon(
                                        Icons.person,
                                        color: whiteColor,
                                      )),
                                ),
                              );
                            }))
                  ],
                );
              }
            }),
      ),
    );
  }
}
