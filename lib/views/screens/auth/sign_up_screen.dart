import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';
import 'package:pregnancy_app/controllers/auth_controller.dart';
import 'package:pregnancy_app/resources/icons.dart';
import 'package:pregnancy_app/resources/spaces.dart';
import 'package:pregnancy_app/resources/strings.dart';
import 'package:pregnancy_app/routes/app_route.dart';
import 'package:pregnancy_app/utils/validation.dart';
import 'package:pregnancy_app/views/widgets/custom_social_button.dart';
import 'package:pregnancy_app/views/screens/auth/sign_in_screen.dart';
import 'package:pregnancy_app/views/screens/verification_screen.dart';

import '../../../styles/_text_header_style.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field_widget.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final signUpController = Get.find<AuthController>();

  final TextEditingController usernameController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController confirmPasswordController =
      TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? usernameError;

  String? emailError;

  String? passwordError;

  String? confirmPasswordError;

  bool _isObscure = true;

  // void validateForm() {
  //   setState(() {
  //     emailError = AppValidator.validateEmail(emailController.text);
  //     passwordError = AppValidator.validatePassword(passwordController.text);
  //     confirmPasswordError =
  //         passwordController.text != confirmPasswordController.text
  //             ? 'Passwords do not match.'
  //             : null;
  //   });

  //   if (usernameError == null &&
  //       emailError == null &&
  //       passwordError == null &&
  //       confirmPasswordError == null) {
  //     signUpController.register(
  //       username: usernameController.text,
  //       email: emailController.text,
  //       password: passwordController.text,
  //       confirmPassword: confirmPasswordController.text,
  //     );
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.all(AppSpace.paddingMain),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    child: Icon(Icons.arrow_back),
                    onTap: () => Get.back(),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Text(
                    AppString.signUp,
                    textAlign: TextAlign.start,
                    style: AppTextStyle.textH5Style,
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        CustomTextFieldWidget(
                          hintText: AppString.username,
                          prefixImage: AppIcons.ic_profile,
                          controller: usernameController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Username is required.';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: AppSpace.spaceInputForm),
                        CustomTextFieldWidget(
                          hintText: AppString.emailHint,
                          prefixImage: AppIcons.ic_mail,
                          controller: emailController,
                          validator: AppValidator.validateEmail,
                          errorText: emailError,
                        ),
                        SizedBox(height: AppSpace.spaceInputForm),
                        CustomTextFieldWidget(
                          hintText: AppString.passwordHint,
                          prefixImage: AppIcons.ic_lock,
                          suffixImage:
                              _isObscure ? AppIcons.ic_show : AppIcons.ic_hiden,
                          obscureText: _isObscure,
                          onSuffixIconTap: () {
                            setState(() {
                              _isObscure = !_isObscure;
                            });
                          },
                          controller: passwordController,
                          validator: AppValidator.validatePassword,
                          errorText: passwordError,
                        ),
                        SizedBox(height: AppSpace.spaceInputForm),
                        CustomTextFieldWidget(
                          hintText: AppString.confirmPassword,
                          prefixImage: AppIcons.ic_lock,
                          suffixImage:
                              _isObscure ? AppIcons.ic_show : AppIcons.ic_hiden,
                          obscureText: _isObscure,
                          onSuffixIconTap: () {
                            setState(() {
                              _isObscure = !_isObscure;
                            });
                          },
                          controller: confirmPasswordController,
                          errorText: confirmPasswordError,
                        ),
                        SizedBox(height: 2.h),
                        CustomButton(
                          text: AppString.signUp.toUpperCase(),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              signUpController.register(
                                usernameController.text.trim(),
                                emailController.text.trim(),
                                passwordController.text.trim(),
                                confirmPasswordController.text.trim(),
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: AppSpace.spaceMain,
                  ),
                  Center(
                    child: Text(
                      AppString.or.toUpperCase(),
                      style: AppTextStyle.textTitle2Style,
                    ),
                  ),
                  SizedBox(
                    height: AppSpace.spaceMain,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: CustomSocialButton(
                      text: AppString.loginGG,
                      iconPath: AppIcons.ic_google,
                      onPressed: () {},
                      backgroundColor: Colors.white,
                      textColor: Colors.black,
                      elevation: 3.0,
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: CustomSocialButton(
                      text: AppString.loginFB,
                      iconPath: AppIcons.ic_facebook,
                      onPressed: () {},
                      backgroundColor: Colors.white,
                      textColor: Colors.black,
                      elevation: 3.0,
                    ),
                  ),
                  SizedBox(
                    height: AppSpace.spaceMain,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        AppString.alreadyAcc,
                        style: AppTextStyle.textTitle3Style,
                      ),
                      SizedBox(
                        width: 1.w,
                      ),
                      GestureDetector(
                        onTap: () => Get.offAllNamed(AppRoutes.login),
                        child: Text(
                          AppString.signIn.toUpperCase(),
                          style: AppTextStyle.textHighlightTitle,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
