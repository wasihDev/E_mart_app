import 'dart:io';

import 'package:emart_app/consts/colors.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/consts/images.dart';
import 'package:emart_app/consts/snackbars.dart';
import 'package:emart_app/controller/profile_controller.dart';
import 'package:emart_app/widgets.common/bg_widget.dart';
import 'package:emart_app/widgets.common/custom_textfield.dart';
import 'package:emart_app/widgets.common/our_button.dart';
import 'package:get/get.dart';

class EditProfileScreen extends StatelessWidget {
  final dynamic data;
  const EditProfileScreen({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    var profileController = Get.put(ProfileController());
    return bgWidget(
        backgroundImage: imgBackground,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
          ),
          body: Container(
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.only(top: 50, left: 12, right: 12),
            decoration: BoxDecoration(
              color: whiteColor,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5, // Spread radius
                  blurRadius: 5, // Blur radius
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Obx(() {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  data['imageUrl'] == '' &&
                          profileController.profileImgPath.isEmpty
                      ? const CircleAvatar(
                          radius: 42.0,
                          backgroundImage: AssetImage(
                            imgProfile2,
                          ),
                        )
                      : data['imageUrl'] != '' &&
                              profileController.profileImgPath.isEmpty
                          ? CircleAvatar(
                              radius: 42.0,
                              backgroundImage: NetworkImage(data['imageUrl']),
                            )
                          : CircleAvatar(
                              radius: 42.0,
                              backgroundImage: FileImage(File(
                                  profileController.profileImgPath.value))),
                  20.heightBox,
                  ourButton(
                    title: "change",
                    Color: redColor,
                    onPress: () async {
                      await profileController.changeImage();
                    },
                    textColor: whiteColor,
                  ),
                  const Divider(),
                  20.heightBox,
                  textFieldwidget(
                      title: "Name",
                      controller: profileController.nameController,
                      hint: "Name"),
                  10.heightBox,
                  textFieldwidget(
                    title: "Old Password",
                    controller: profileController.oldPasswordController,
                    hint: "Old Password",
                  ),
                  10.heightBox,
                  textFieldwidget(
                    title: "New Password",
                    controller: profileController.newPasswordController,
                    hint: "New Password",
                  ),
                  10.heightBox,
                  profileController.isLoading.value
                      ? const CircularProgressIndicator(color: redColor)
                      : SizedBox(
                          width: context.screenWidth - 60,
                          child: ourButton(
                            title: "Save",
                            Color: redColor,
                            onPress: () async {
                              profileController.isLoading(true);
                              if (profileController
                                  .profileImgPath.value.isNotEmpty) {
                                await profileController.uploadProfileImage();
                              } else {
                                profileController.profileImageLink =
                                    data['imageUrl'];
                              }
                              if (data['password'] ==
                                  profileController
                                      .oldPasswordController.text) {
                                await profileController.changeAuthPassword(
                                    email: data['email'],
                                    password: profileController
                                        .oldPasswordController.text,
                                    newpassword: profileController
                                        .newPasswordController.text);
                                await profileController.uploadProfileData(
                                  password: profileController
                                      .newPasswordController.text,
                                  name: profileController.nameController.text,
                                );

                                successSnack('Data Updated');
                                profileController.isLoading(false);
                              } else {
                                errorSnack('Wrong old password');
                                profileController.isLoading(false);
                              }
                            },
                            textColor: whiteColor,
                          ),
                        )
                ],
              );
            }),
          ),
        ));
  }
}
