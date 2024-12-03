import 'package:admin/api/auth/api_signup.dart';
import 'package:admin/models/auth/md_signup.dart';
import 'package:admin/models/error/md_error.dart';
import 'package:admin/models/user/md_user.dart';
import 'package:admin/routes/rt_routers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'dart:html' as html;

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  String? emailExistError;
  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    html.document.title = 'Naturemedix | Signup';

    return Scaffold(
      body: Center(
        child: Container(
          width: double.maxFinite,
          height: double.maxFinite,
          decoration: _buildBackgroundImage(),
          child: LayoutBuilder(builder: (context, constraint) {
            return Stack(
              children: [
                // BODY CONTENTS
                Align(
                  alignment: Alignment.center,
                  child: _buildBody(constraint),
                ),

                // LOGO
                Positioned(
                  top: 20,
                  left: 30,
                  child: _buildLogo(),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }

  //? ====[ BODY CONTENTS ]===
  Widget _buildBody(constraint) {
    return SingleChildScrollView(
      child: Container(
        color: Colors.transparent,
        width: constraint.maxWidth,
        height: constraint.maxHeight + 90,
        child: Center(
          child: LayoutBuilder(builder: (context, constraint2) {
            return Container(
              margin: const EdgeInsets.symmetric(vertical: 20),
              width: constraint2.maxWidth * 0.4,
              height: constraint2.maxHeight,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 5.0,
                    ),
                  ]),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // ================ TITLE
                  const Text(
                    'REGISTER',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w900,
                    ),
                  ),

                  // ================ SUBTITLE
                  const Gap(5),
                  const Text(
                    'Create a new account',
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),

                  // ================ DIVIDER
                  const Gap(8),
                  const SizedBox(
                    width: 200,
                    child: Divider(
                      thickness: 1,
                      color: Colors.grey,
                    ),
                  ),

                  // =============== SIGNUP FORM
                  const Gap(30),
                  Form(
                    key: formKey,
                    child: Column(
                      children: [
                        // ================ NAME TEXTFIELD
                        const Gap(10),
                        TextFormField(
                          controller: nameController,
                          decoration: _buildFormDecoration('Name'),
                          validator: validateLastName,
                        ),

                        // ================ EMAIL TEXTFIELD
                        const Gap(10),
                        TextFormField(
                          controller: emailController,
                          decoration: _buildFormDecoration('Email Address'),
                          style: const TextStyle(
                            fontSize: 14.5,
                          ),
                          validator: validateEmail,
                        ),

                        // ================ PASSWORD TEXTFIELD
                        const Gap(10),
                        TextFormField(
                          controller: passwordController,
                          decoration: _buildFormDecoration('Password',
                              isPassword: true),
                          obscureText: !showPassword,
                          validator: validatePassword,
                        ),

                        // =============== CONFIRM PASSWORD TEXTFIELD
                        const Gap(10),
                        TextFormField(
                          controller: confirmPasswordController,
                          decoration: _buildFormDecoration('Confirm Password',
                              isPassword: true),
                          obscureText: !showPassword,
                          validator: validateConfirmPassword,
                        ),

                        // =============== SIGNUP BUTTON
                        const Gap(20),
                        MaterialButton(
                          minWidth: 440,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 40, vertical: 16),
                          color: const Color(0xFF007E62),
                          onPressed: registerCredentials,
                          child: const Text(
                            'Sign up',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Gap(20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Already have an account?',
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                      const Gap(5),
                      GestureDetector(
                        onTap: () {
                          gotoLoginScreen();
                        },
                        child: const Text(
                          'Login',
                          style: TextStyle(
                            color: Color(0xFF007E62),
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }

  ///=======================================================================================================
  ///
  ///

  //? ===[ LOGO ]====
  Widget _buildLogo() {
    return GestureDetector(
      onTap: () {
        backtoLandingScreen();
      },
      child: RichText(
        text: const TextSpan(
          children: [
            TextSpan(
              text: 'Nature',
              style: TextStyle(
                color: Color(0xFF007E62),
                fontSize: 20,
                fontWeight: FontWeight.w900,
              ),
            ),
            TextSpan(
              text: ' Medix',
              style: TextStyle(
                fontSize: 9,
                color: Color(0xFF000000),
              ),
            ),
          ],
        ),
      ),
    );
  }

  ///

  //? ===[ TEXT FIELDS/INPUTS RELATED ]====
  InputDecoration _buildFormDecoration(label,
      {void iconOnpress, isPassword = false}) {
    return InputDecoration(
      labelText: label,
      border: const OutlineInputBorder(),
      constraints: const BoxConstraints(
        maxWidth: 430,
      ),
      suffixIcon: isPassword
          ? IconButton(
              icon: Icon(
                showPassword ? Icons.visibility : Icons.visibility_off,
              ),
              onPressed: () {
                setState(() {
                  showPasswordToggle();
                });
              },
            )
          : null,
    );
  }

  ///
  ///=======================================================================================================
  ///

  // validations

  String? validateFirstName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Required. Please enter your first name';
    }
    if (!GetUtils.isAlphabetOnly(value.removeAllWhitespace)) {
      return 'Invalid. First name can only contain alphabets';
    }
    return null;
  }

  String? validateLastName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Required. Please enter your last name';
    }
    if (!GetUtils.isAlphabetOnly(value.removeAllWhitespace)) {
      return 'Invalid. Last name can only contain alphabets';
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Required. Please enter a email address';
    }
    if (!GetUtils.isEmail(value)) {
      return 'Invalid. Please enter a valid email address';
    }
    if (emailExistError != null) {
      return emailExistError;
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Required. Please enter a password';
    }
    if (!GetUtils.isLengthGreaterOrEqual(value, 8)) {
      return 'Required. Password must be at least 8 characters';
    }
    if (GetUtils.isAlphabetOnly(value)) {
      return 'Required. Password must contain special characters or numbers';
    }

    return null;
  }

  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Required. Please enter a password';
    }
    if (value != passwordController.text) {
      return 'Invalid. Passwords do not match';
    }

    return null;
  }

  ///
  ///=======================================================================================================
  ///

  //? ===[ BACK TO LANDING SCREEN ]====
  void backtoLandingScreen() {
    Get.offAllNamed(CustomRoute.path.root);
  }

  //? ===[ GOTO LOGIN SCREEN ]====
  void gotoLoginScreen() {
    Get.offNamed(CustomRoute.path.login, preventDuplicates: true);
  }

  ///
  ///=======================================================================================================
  ///

  //? ===[ SHOW PASSWORD TOGGLE ]====
  void showPasswordToggle() {
    showPassword = !showPassword;
  }

  ///

  //? ===[ BOX DECORATION ]====
  BoxDecoration _buildBackgroundImage() {
    return const BoxDecoration(
      image: DecorationImage(
        image: AssetImage('assets/sys_image/ast_landing_bg.jpg'),
        fit: BoxFit.cover,
        alignment: Alignment.center,
        opacity: 0.4,
      ),
    );
  }

  ///

  //? ===[ RESET FORM ]====
  void resetForm() {
    nameController.clear();
    emailController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
  }

  ///

  //? ===[ SHOW LOADING DIALOG ]====
  void showLoading(String? title, String? subtitle) {
    Get.defaultDialog(
      title: '$title',
      barrierDismissible: false,
      titlePadding: const EdgeInsets.all(10),
      contentPadding: const EdgeInsets.all(10),
      content: Center(
        child: Column(
          children: [
            Text('$subtitle'),
            const Gap(10),
            const CircularProgressIndicator(
              color: Color(0xFF007E62),
              strokeWidth: 2,
            ),
          ],
        ),
      ),
      backgroundColor: Colors.white,
      titleStyle: const TextStyle(
        color: Colors.black,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  ///

  //? ===[ SHOW FAILED DIALOG ]====
  void showFailedDialog(title, message) {
    Get.defaultDialog(
      title: title,
      barrierDismissible: false,
      middleText: message,
      middleTextStyle: const TextStyle(color: Colors.red),
      textConfirm: 'OK',
      confirmTextColor: Colors.white,
      buttonColor: Colors.red,
      onConfirm: () {
        Get.close(1);
      },
    );
  }

  ///

  //? ===[ SHOW SUCCESS DIALOG ]====
  void showSuccessDialog(title, message) {
    Get.snackbar(
      title,
      message,
      colorText: Colors.black,
      margin: const EdgeInsets.all(10),
    );
  }

  ///
  ///=======================================================================================================
  ///

  void registerCredentials() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    var user = UserModel(
      name: nameController.text,
      email: emailController.text,
      password: passwordController.text,
      confirm_password: confirmPasswordController.text,
    );

    showLoading('Registering', 'Please wait...');
    var response = await SignupApi.auth.register(user);
    Get.close(1);

    if (response == "Cannot connect to server") {
      showFailedDialog('Failed', response);
      return;
    }

    if (response == "Email already exists") {
      emailExistError = "Invalid. Email is already exists";
      !formKey.currentState!.validate();
      return;
    }

    if (response == "Registration successful") {
      showSuccessDialog('Success', 'Registered successfully!');
      resetForm();
    }
  }
}
