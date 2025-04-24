import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';
import 'package:pregnancy_app/resources/colors.dart';
import 'package:pregnancy_app/resources/icons.dart';
import 'package:pregnancy_app/resources/spaces.dart';
import 'package:pregnancy_app/resources/strings.dart';
import 'package:pregnancy_app/routes/app_route.dart';
import 'package:pregnancy_app/utils/validation.dart';
import 'package:pregnancy_app/views/widgets/custom_social_button.dart';
import 'package:pregnancy_app/views/widgets/custom_toggle.dart';
import 'package:pregnancy_app/views/screens/resset_password_screen.dart';

import '../../../controllers/auth_controller.dart';
import '../../../styles/_text_header_style.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field_widget.dart';

class SignInScreen extends StatefulWidget {
  SignInScreen({Key? key}) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final AuthController controller = Get.find<AuthController>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final RxString emailError = ''.obs;
  final RxString passwordError = ''.obs;
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: AppColors.backgroundWhiteColor,
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.all(AppSpace.spaceMedium),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Center(
                    child: Image.asset(
                      AppIcons.logo_shape,
                      height: 15.h,
                    ),
                  ),
                  SizedBox(height: AppSpace.spaceMedium),
                  Text(
                    AppString.signIn,
                    textAlign: TextAlign.start,
                    style: AppTextStyle.textH5Style,
                  ),
                  SizedBox(height: AppSpace.spaceMedium),
                  Obx(() {
                    return CustomTextFieldWidget(
                      hintText: AppString.emailHint,
                      prefixImage: AppIcons.ic_mail,
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      errorText:
                          emailError.value.isEmpty ? null : emailError.value,
                    );
                  }),
                  SizedBox(height: AppSpace.spaceInputForm),
                  Obx(() {
                    return CustomTextFieldWidget(
                      hintText: AppString.passwordHint,
                      prefixImage: AppIcons.ic_lock,
                      keyboardType: TextInputType.visiblePassword,
                      controller: passwordController,
                      suffixImage:
                          _isObscure ? AppIcons.ic_show : AppIcons.ic_hiden,
                      obscureText: _isObscure,
                      errorText: passwordError.value.isEmpty
                          ? null
                          : passwordError.value,
                      onSuffixIconTap: () {
                        setState(() {
                          _isObscure = !_isObscure;
                        });
                      },
                    );
                  }),
                  SizedBox(height: AppSpace.spaceMedium),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Obx(() {
                            return CustomToggleButton(
                              initialValue: controller.rememberMe.value,
                              onChanged: (value) {
                                controller.toggleRememberMe(value);
                              },
                            );
                          }),
                          SizedBox(width: AppSpace.spaceSmallW),
                          Text(
                            AppString.remember,
                            style: AppTextStyle.textMainStyle,
                          ),
                        ],
                      ),
                      GestureDetector(
                        child: Text(
                          AppString.forgotPass,
                          style: AppTextStyle.textMainStyle,
                        ),
                        onTap: () => Get.to(RessetPasswordScreen()),
                      ),
                    ],
                  ),
                  SizedBox(height: AppSpace.spaceMain),
                  Obx(() {
                    return controller.isLoading.value
                        ? Center(child: CircularProgressIndicator())
                        : CustomButton(
                            text: AppString.signIn.toUpperCase(),
                            onPressed: () {
                              emailError.value = AppValidator.validateEmail(
                                      emailController.text) ??
                                  '';
                              passwordError.value =
                                  AppValidator.validatePassword(
                                          passwordController.text) ??
                                      '';
                              if (emailError.value.isEmpty &&
                                  passwordError.value.isEmpty) {
                                controller.login(
                                  emailController.text.trim(),
                                  passwordController.text.trim(),
                                );
                              }
                            },
                          );
                  }),
                  SizedBox(height: AppSpace.spaceMain),
                  Center(
                    child: Text(
                      AppString.or.toUpperCase(),
                      style: AppTextStyle.textTitle2Style,
                    ),
                  ),
                  SizedBox(height: AppSpace.spaceMain),
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
                  SizedBox(height: AppSpace.spaceMedium),
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
                  SizedBox(height: AppSpace.spaceMain),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        AppString.dontHaveAcc,
                        style: AppTextStyle.textTitle3Style,
                      ),
                      SizedBox(
                        width: 1.w,
                      ),
                      GestureDetector(
                        onTap: () => Get.toNamed(AppRoutes.signup),
                        child: Text(
                          AppString.signUp.toUpperCase(),
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
