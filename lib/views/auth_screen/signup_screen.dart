import 'dart:developer';

import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/consts/firebase_const.dart';
import 'package:emart_app/controller/auth_controller.dart';
import 'package:emart_app/views/home_screen/home.dart';
import 'package:emart_app/widgets.common/bg_widget2.dart';
import 'package:emart_app/widgets.common/custom_textfield.dart';
import 'package:emart_app/widgets.common/our_button.dart';
import 'package:emart_app/widgets.common/widgets.dart';
import 'package:get/get.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool? ischeck = false;
  var controller = Get.put(AuthController());
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController rePasswordController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return bgwidegt(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              (context.screenHeight * 0.1).heightBox,
              applogoWidget(),
              10.heightBox,
              "Join the $appname".text.fontFamily(bold).white.size(18).make(),
              15.heightBox,
              Obx(() {
                return Column(
                  children: [
                    textFieldwidget(
                        hint: nameHint,
                        title: name,
                        controller: nameController),
                    textFieldwidget(
                        hint: emailHint,
                        title: email,
                        controller: emailController),
                    textFieldwidget(
                        hint: passwordHint,
                        title: password,
                        controller: passwordController),
                    textFieldwidget(
                        hint: passwordHint,
                        title: retypePassword,
                        controller: rePasswordController),
                    Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                            onPressed: () {}, child: forgetPass.text.make())),
                    5.heightBox,
                    Row(
                      children: [
                        Checkbox(
                          checkColor: redColor,
                          value: ischeck,
                          onChanged: (newvalue) {
                            setState(() {
                              ischeck = newvalue;
                            });
                          },
                        ),
                        10.widthBox,
                        Expanded(
                          child: RichText(
                              text: const TextSpan(children: [
                            TextSpan(
                                text: "I agree to the",
                                style: TextStyle(
                                  fontFamily: regular,
                                  color: fontGrey,
                                )),
                            TextSpan(
                                text: " Terms and Condition",
                                style: TextStyle(
                                  fontFamily: regular,
                                  color: redColor,
                                )),
                            TextSpan(
                                text: "\n&",
                                style: TextStyle(
                                  fontFamily: regular,
                                  color: fontGrey,
                                )),
                            TextSpan(
                                text: "Privacy Policy",
                                style: TextStyle(
                                  fontFamily: regular,
                                  color: redColor,
                                )),
                          ])),
                        )
                      ],
                    ),
                    controller.isLoading.value
                        ? const CircularProgressIndicator(color: redColor)
                        : ourButton(
                            Color: ischeck == true ? redColor : lightGrey,
                            title: signup,
                            textColor: whiteColor,
                            onPress: () async {
                              log("A ${emailController.text}");
                              log("A ${passwordController.text}");
                              log("A ${nameController.text}");
                              if (ischeck != null) {
                                try {
                                  controller.isLoading(true);
                                  await controller
                                      .signUpMethod(
                                          email: emailController.text,
                                          password: passwordController.text)
                                      .then((onValue) {
                                    return controller.storeData(
                                        email: emailController.text,
                                        password: passwordController.text,
                                        name: nameController.text);
                                  }).then((val) {
                                    Get.snackbar(
                                        "Successfully", "Login Sucesfully",
                                        backgroundColor: green);
                                    controller.isLoading(false);
                                    Get.offAll(() => const Home());
                                  });
                                } catch (e) {
                                  auth.signOut();
                                  Get.snackbar("error", e.toString(),
                                      backgroundColor: redColor,
                                      colorText: whiteColor,
                                      snackPosition: SnackPosition.BOTTOM);
                                  controller.isLoading(false);
                                }
                              }
                            }).box.width(context.screenWidth - 50).make(),
                    10.heightBox,
                    RichText(
                        text: const TextSpan(children: [
                      TextSpan(
                        text: alreadyHaveAcoount,
                        style: TextStyle(
                          fontFamily: bold,
                          color: fontGrey,
                        ),
                      ),
                      TextSpan(
                        text: login,
                        style: TextStyle(
                          fontFamily: bold,
                          color: redColor,
                        ),
                      )
                    ])).onTap(() {
                      Get.back();
                    }),
                  ],
                )
                    .box
                    .white
                    .rounded
                    .padding(const EdgeInsets.all(16))
                    .width(context.screenWidth - 70)
                    .shadowSm
                    .make();
              }),
            ],
          ),
        ),
      ),
    ));
  }
}
