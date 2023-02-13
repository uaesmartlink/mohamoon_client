import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:get/get.dart';
import 'package:client_mohamoon/app/modules/login/views/widgets/divider_or.dart';
import 'package:client_mohamoon/app/modules/login/views/widgets/label_button.dart';
import 'package:client_mohamoon/app/modules/login/views/widgets/title_app.dart';
import 'package:client_mohamoon/app/modules/widgets/submit_button.dart';
import '../../widgets/log_container.dart';
import '../controllers/login_controller.dart';
import 'package:client_mohamoon/app/utils/constants/style_constants.dart';

class LoginView extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    var height = Get.height;
    final node = FocusScope.of(context);
    return Scaffold(
        body: LogContainer(
         widget: Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: height * .1),
                  TitleApp(),
                  SizedBox(height: 50),
                  Form(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    key: controller.loginFormKey,
                    child: Column(
                      children: [
                        TextFormField(


                          textInputAction: TextInputAction.next,
                          onEditingComplete: () {
                            node.nextFocus();
                          },
                          validator: ((value) {
                            if (value!.length == 0) {
                              return 'Email is Required'.tr;
                            } else {
                              return null;
                            }
                          }),
                          onSaved: (username) {
                            controller.username = username ?? '';
                          },
                          decoration: InputDecoration(
                              hintText: 'Email',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: BorderSide(
                                    width: 0,
                                    style: BorderStyle.none,
                                  )),
                              fillColor: Colors.grey[200],
                              filled: true),
                        ),
                        SizedBox(height: 30),
                        GetBuilder<LoginController>(
                          builder: (controller) => TextFormField(
                            obscureText: controller.passwordVisible,
                            textInputAction: TextInputAction.done,
                            decoration: InputDecoration(
                                hintText: 'Password',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide(
                                      width: 0,
                                      style: BorderStyle.none,
                                    )),
                                fillColor: Colors.grey[200],
                                filled: true,
                                suffixIcon: IconButton(
                                  icon: Icon(
                                      controller.passwordVisible
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: Constants.primaryColor),
                                  onPressed: () {
                                    controller.passwordIconVisibility();
                                  },
                                )),
                            validator: ((value) {
                              if (value!.isEmpty) {
                                return 'Password cannot be empty'.tr;
                              } else {
                                return null;
                              }
                            }),
                            onSaved: (password) {
                              controller.password = password ?? '';
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Get.toNamed('/forgot-password');
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      alignment: Alignment.centerRight,
                      child: Text(
                        'Forgot Password ?'.tr,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                  SizedBox(height: height * .020),
                  submitButton(
                      onTap: () {
                        controller.login();
                      },
                      text: 'Login'.tr),
                  SizedBox(
                    height: 10,
                  ),
                  DividerOr(),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: Get.width,
                    height: 50,
                    child: SignInButton(
                      Buttons.Google,
                      onPressed: () {
                        controller.loginGoogle();
                      },

                    ),
                  ),
                  const SizedBox(height: 5,),
                  Container(
                    width: Get.width,
                    height: 50,
                    child: SignInButton(
                      Buttons.Facebook,
                      onPressed: () {
                        controller.loginFacebook();
                      },
                    ),
                  ),
                  LabelButton(
                    onTap: () {
                      Get.toNamed('/register');
                    },
                    title: 'Don\'t have an account,'.tr,
                    subTitle: 'Register'.tr,
                  ),
                ],
              ),
            ),
          )
    ));
  }
}
