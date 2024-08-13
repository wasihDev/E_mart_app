import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/consts/lists.dart';
import 'package:emart_app/consts/snackbars.dart';
import 'package:emart_app/controller/auth_controller.dart';
import 'package:emart_app/views/auth_screen/signup_screen.dart';
import 'package:emart_app/views/home_screen/home.dart';
import 'package:emart_app/widgets.common/bg_widget2.dart';
import 'package:emart_app/widgets.common/custom_textfield.dart';
import 'package:emart_app/widgets.common/our_button.dart';
import 'package:emart_app/widgets.common/widgets.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  var controller = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    return bgwidegt(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Obx(() {
          return Column(
            children: [
              (context.screenHeight * 0.1).heightBox,
              applogoWidget(),
              10.heightBox,
              "Log in to $appname".text.fontFamily(bold).white.size(18).make(),
              15.heightBox,
              Column(
                children: [
                  textFieldwidget(
                      hint: emailHint,
                      title: email,
                      controller: emailController),
                  textFieldwidget(
                      hint: passwordHint,
                      title: password,
                      controller: passwordController),
                  Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                          onPressed: () {}, child: forgetPass.text.make())),
                  5.heightBox,
                  //  ourButton().box.width(context.screenWidth -50).make(),
                  controller.isLoading.value
                      ? const CircularProgressIndicator(color: redColor)
                      : ourButton(
                          Color: redColor,
                          title: login,
                          textColor: whiteColor,
                          onPress: () async {
                            controller.isLoading(true);
                            if (emailController.text.isNotEmpty ||
                                passwordController.text.isNotEmpty) {
                              await controller
                                  .signInMethod(
                                      email: emailController.text,
                                      password: passwordController.text)
                                  .then((value) {
                                if (value != null) {
                                  Get.snackbar(
                                      "Successfully", "Login Sucesfully",
                                      backgroundColor: green);
                                  controller.isLoading(false);
                                  Get.offAll(() => const Home());
                                } else {
                                  controller.isLoading(false);
                                }
                              });
                            } else {
                              errorSnack("Fill the fields");
                            }
                            // });
                          }).box.width(context.screenWidth - 50).make(),
                  createNewAccount.text.color(fontGrey).make(),

                  ourButton(
                      Color: redColor,
                      title: signup,
                      textColor: whiteColor,
                      onPress: () {
                        Get.to(() => SignupScreen());
                      }).box.width(context.screenWidth - 50).make(),
                  10.heightBox,
                  loginwith.text.color(fontGrey).make(),
                  5.heightBox,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                        3,
                        (index) => Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CircleAvatar(
                                backgroundColor: lightGrey,
                                radius: 25,
                                child: Image.asset(
                                  socialIconlist[index],
                                  width: 30,
                                ),
                              ),
                            )),
                  ),
                ],
              )
                  .box
                  .white
                  .rounded
                  .padding(EdgeInsets.all(16))
                  .width(context.screenWidth - 70)
                  .shadowSm
                  .make(),
            ],
          );
        }),
      ),
    ));
  }
}
