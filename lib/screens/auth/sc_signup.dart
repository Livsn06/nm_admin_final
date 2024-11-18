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

class SignupScreen extends StatefulWidget with SignUpFormController {
  SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  @override
  Widget build(BuildContext context) {
    html.document.title = 'Naturemedix | Signup';

    return Scaffold(
      body: Center(
        child: Container(
          width: double.maxFinite,
          height: double.maxFinite,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/sys_image/ast_landing_bg.jpg'),
              fit: BoxFit.cover,
              alignment: Alignment.center,
              opacity: 0.4,
            ),
          ),
          child: LayoutBuilder(builder: (context, constraint) {
            return Stack(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: _buildBody(constraint),
                ),
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
                  const Text(
                    'REGISTER',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const Gap(5),
                  const Text(
                    'Create a new account',
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  const Gap(8),
                  const SizedBox(
                    width: 200,
                    child: Divider(
                      thickness: 1,
                      color: Colors.grey,
                    ),
                  ),
                  const Gap(30),
                  Form(
                    key: widget.formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: widget.firstNameController,
                          decoration: _buildFormDecoration('First Name'),
                          validator: widget.validateFirstName,
                        ),
                        const Gap(10),
                        TextFormField(
                          controller: widget.lastNameController,
                          decoration: _buildFormDecoration('Last Name'),
                          validator: widget.validateLastName,
                        ),
                        const Gap(10),
                        TextFormField(
                          controller: widget.emailController,
                          decoration: _buildFormDecoration('Email Address'),
                          style: const TextStyle(
                            fontSize: 14.5,
                          ),
                          validator: widget.validateEmail,
                        ),
                        const Gap(10),
                        TextFormField(
                          controller: widget.passwordController,
                          decoration: _buildFormDecoration('Password',
                              isPassword: true),
                          obscureText: !widget.showPassword,
                          validator: widget.validatePassword,
                        ),
                        const Gap(10),
                        TextFormField(
                          controller: widget.confirmPasswordController,
                          decoration: _buildFormDecoration('Confirm Password',
                              isPassword: true),
                          obscureText: !widget.showPassword,
                          validator: widget.validateConfirmPassword,
                        ),
                        const Gap(20),
                        MaterialButton(
                          minWidth: 440,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 40, vertical: 16),
                          color: const Color(0xFF007E62),
                          onPressed: widget.registerCredentials,
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
                          widget.gotoLoginScreen();
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

  InputDecoration _buildFormDecoration(label, {isPassword = false}) {
    return InputDecoration(
      labelText: label,
      border: const OutlineInputBorder(),
      constraints: const BoxConstraints(
        maxWidth: 430,
      ),
      suffixIcon: isPassword
          ? IconButton(
              icon: Icon(
                widget.showPassword ? Icons.visibility : Icons.visibility_off,
              ),
              onPressed: () {
                setState(() {
                  widget.showPasswordToggle();
                });
              },
            )
          : null,
    );
  }

  Widget _buildLogo() {
    return GestureDetector(
      onTap: () {
        widget.backtoLandingScreen();
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
}

mixin SignUpFormController {
  final formKey = GlobalKey<FormState>();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  ErrorModel? error;
  bool showPassword = false;
  void registerCredentials() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    var user = UserModel(
      firstname: firstNameController.text,
      lastname: lastNameController.text,
      email: emailController.text,
      password: passwordController.text,
      confirm_password: confirmPasswordController.text,
    );

    showLoading('Registering', 'Please wait...');

    var response = await SignupApi.auth.register(user);
    Get.close(1);

    if (response.clientError ?? false) {
      showFailedDialog('Failed', 'Something went Wrong!');
      return;
    }

    if (response.success == false && response.errors != null) {
      error = ErrorModel.fromJson(response.errors!);
      formKey.currentState!.validate();
      error = null;
      return;
    }

    if (response.success == true && response.data != null) {
      showSuccessDialog('Success', 'Registered successfully!');
      resetForm();
    }
  }

//Controls
  void showPasswordToggle() {
    showPassword = !showPassword;
  }

  void resetForm() {
    firstNameController.clear();
    lastNameController.clear();
    emailController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
  }

  // validations

  String? validateFirstName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Required. Please enter your first name';
    }
    if (!GetUtils.isAlphabetOnly(value.removeAllWhitespace)) {
      return 'Invalid. First name can only contain alphabets';
    }
    if (error?.name != null) {
      return error?.name;
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

    if (error?.name != null) {
      return error?.name;
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
    if (error?.email != null) {
      return error?.email;
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
    if (error?.password != null) {
      return error?.password;
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

    if (error?.password != null) {
      return error?.password;
    }
    return null;
  }

  //navigations
  void backtoLandingScreen() {
    Get.offAllNamed(CustomRoute.path.root);
  }

  void gotoLoginScreen() {
    Get.offNamed(CustomRoute.path.login, preventDuplicates: true);
  }

  //Modals
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

  void showSuccessDialog(title, message) {
    Get.snackbar(
      title,
      message,
      colorText: Colors.black,
      margin: const EdgeInsets.all(10),
    );
  }
}
