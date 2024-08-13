import 'package:emart_app/consts/colors.dart';
import 'package:emart_app/consts/styles.dart';
import 'package:flutter/material.dart';

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "My Messages",
          style: TextStyle(
              color: darkFontGrey, fontFamily: (semibold), fontSize: 18),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(12.0),
        child: Column(
          children: [
            Expanded(
                child: ListView.builder(
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      return Container(
                        decoration:
                            BoxDecoration(color: whiteColor, boxShadow: [
                          BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              blurRadius: 4,
                              spreadRadius: 4,
                              offset: Offset(0, 3)),
                        ]),
                        child: ListTile(
                          title: Text(
                            "sss",
                            style: TextStyle(
                                color: darkFontGrey, fontFamily: (semibold)),
                          ),
                          leading: CircleAvatar(
                              backgroundColor: redColor,
                              child: Icon(
                                Icons.person,
                                color: whiteColor,
                              )),
                        ),
                      );
                    }))
          ],
        ),
      ),
    );
  }
}
