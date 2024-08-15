import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/consts/firebase_const.dart';
import 'package:emart_app/consts/lists.dart';
import 'package:emart_app/controller/auth_controller.dart';
import 'package:emart_app/controller/profile_controller.dart';
import 'package:emart_app/services/firestore_services.dart';
import 'package:emart_app/views/auth_screen/login_screen.dart';
import 'package:emart_app/views/cart_screen/component/detail_cart.dart';
import 'package:emart_app/views/chat_screens/Messages_screen.dart';
import 'package:emart_app/views/order_screens/order_screen.dart';
import 'package:emart_app/views/profile_screen/profile_edit_screen.dart';
import 'package:emart_app/views/wishlist_screen/wish_list.dart';
import 'package:emart_app/widgets.common/bg_widget.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});
  @override
  Widget build(BuildContext context) {
    var profileController = Get.put(ProfileController());

    return bgWidget(
        backgroundImage: imgBackground,
        child: StreamBuilder(
            stream: FirestoreServices.getUser(currentUser!.uid),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (snapshot.data!.docs.isEmpty) {
                return Center(
                    child: Text('No data found for uid: ${currentUser!.uid}'));
              } else {
                var data = snapshot.data!.docs[0];

                return SafeArea(
                  child: Scaffold(
                      backgroundColor: Colors.transparent,
                      body: Column(
                        children: [
                          20.heightBox,
                          Align(
                              alignment: Alignment.topRight,
                              child: InkWell(
                                onTap: () {
                                  profileController.nameController.text =
                                      data['name'];
                                  // prof ileController.oldPasswordController.text =
                                  // data['password'];
                                  Get.to(() => EditProfileScreen(data: data));
                                },
                                child: const Icon(
                                  Icons.edit,
                                  color: whiteColor,
                                ),
                              )),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 12.0),
                            child: Row(children: [
                              data['imageUrl'] == ''
                                  ? const CircleAvatar(
                                      radius: 42.0,
                                      backgroundImage: AssetImage(
                                        imgProfile2,
                                      ),
                                    )
                                  : CircleAvatar(
                                      radius: 42.0,
                                      backgroundImage: NetworkImage(
                                          data['imageUrl'].toString()),
                                    ),
                              const SizedBox(
                                width: 5,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${data["name"]}",
                                      style: const TextStyle(
                                          color: whiteColor,
                                          fontFamily: semibold),
                                    ),
                                    Text(
                                      "${data['email']}",
                                      style: const TextStyle(color: whiteColor),
                                    )
                                  ],
                                ),
                              ),
                              OutlinedButton(
                                onPressed: () async {
                                  await Get.put(AuthController())
                                      .signOutMethod();
                                  Get.offAll(() => LoginScreen());
                                },
                                style: OutlinedButton.styleFrom(
                                    side: const BorderSide(color: whiteColor)),
                                child: const Text(
                                  "LogOut",
                                  style: TextStyle(
                                      color: whiteColor, fontFamily: semibold),
                                ),
                              )
                            ]),
                          ),
                          const SizedBox(
                            height: 2,
                          ),
                          FutureBuilder(
                              future: FirestoreServices.getCounts(),
                              builder: (BuildContext context,
                                  AsyncSnapshot snapshot) {
                                if (!snapshot.hasData) {
                                  return const Center(
                                      child: CircularProgressIndicator());
                                } else {
                                  return Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      detailCart(
                                          title: "your cart",
                                          width: context.screenWidth / 3.4,
                                          count: snapshot.data[0].toString()),
                                      detailCart(
                                          title: "your wishlist",
                                          width: context.screenWidth / 3.4,
                                          count: snapshot.data[1].toString()),
                                      detailCart(
                                          title: " your orders",
                                          width: context.screenWidth / 3.4,
                                          count: snapshot.data[2].toString()),
                                    ],
                                  );
                                }
                              }),
                          Container(
                            width: double.infinity,
                            height: 250,
                            color: redColor,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                margin: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  color: whiteColor,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 2, // Spread radius
                                      blurRadius: 5, // Blur radius
                                      offset: const Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: ListView.separated(
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      return ListTile(
                                        onTap: () {
                                          switch (index) {
                                            case 0:
                                              Get.to(() => const OrderScreen());
                                              break;
                                            case 1:
                                              Get.to(
                                                  () => const WishListScreen());
                                              break;
                                            case 2:
                                              Get.to(
                                                  () => const MessagesScreen());
                                              break;
                                            default:
                                          }
                                        },
                                        leading: CircleAvatar(
                                          child: Image.asset(
                                            profileButtonIcon[index],
                                            width: 18,
                                          ),
                                        ),
                                        title: Text(
                                          profileButtonList[index],
                                          style: const TextStyle(
                                              color: darkFontGrey,
                                              fontFamily: semibold),
                                        ),
                                      );
                                    },
                                    separatorBuilder: (context, index) {
                                      return const Divider(
                                        thickness: 3,
                                        color: lightGrey,
                                      );
                                    },
                                    itemCount: 3),
                              ),
                            ),
                          )
                        ],
                      )),
                );
              }
            }));
  }
}
