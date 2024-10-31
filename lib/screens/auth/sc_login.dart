import 'package:admin/api/auth/api_login.dart';
import 'package:admin/models/auth/md_login.dart';
import 'package:admin/models/error/md_error.dart';
import 'package:admin/models/user/md_user.dart';
import 'package:admin/routes/rt_routers.dart';
import 'package:admin/sessions/sn_access.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'dart:html' as html;

class LoginScreen extends StatefulWidget with LoginFormController {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    html.document.title = 'Naturemedix | Login';

    //
    return Scaffold(
      body: Center(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/sys_image/ast_landing_bg.jpg'),
              fit: BoxFit.cover,
              alignment: Alignment.center,
              opacity: 0.4,
            ),
          ),
          width: double.infinity,
          height: double.infinity,
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
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      width: constraint.maxWidth * 0.4,
      height: constraint.maxHeight,
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
            'LOGIN',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w900,
            ),
          ),
          const Gap(5),
          const Text(
            'Sign in to your account',
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
          const Gap(60),
          Form(
            key: widget.formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TextFormField(
                  controller: widget.emailController,
                  decoration: _buildFormDecoration('Email Address'),
                  validator: widget.validateEmail,
                ),
                const Gap(12),
                TextFormField(
                  controller: widget.passwordController,
                  decoration:
                      _buildFormDecoration('Password', isPassword: true),
                  obscureText: !widget.showPassword,
                  validator: widget.validatePassword,
                ),
                const Gap(12),
                GestureDetector(
                  onTap: () {},
                  child: const Text(
                    'Forgot Password?',
                    style: TextStyle(
                      color: Color(0xFF007E62),
                      fontSize: 14,
                    ),
                  ),
                ),
                const Gap(20),
                MaterialButton(
                  minWidth: 440,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                  color: const Color(0xFF007E62),
                  onPressed: () async {
                    await widget.loginCredentials();
                  },
                  child: const Text(
                    'Log in',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Gap(30),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Don\'t have an account?',
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
              const Gap(5),
              GestureDetector(
                onTap: () {
                  widget.gotoSignupScreen();
                },
                child: const Text(
                  'Sign Up',
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

mixin LoginFormController {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  ErrorModel? error;
  bool showPassword = false;
  Future<void> loginCredentials() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    var credentials = LoginModel(
      email: emailController.text,
      password: passwordController.text,
    );

    showLoading('Authetication', 'Please wait...');
    var response = await LoginApi.auth.login(credentials);
    Get.close(1);

    if (response == null) {
      showFailedDialog('Failed', 'Something went wrong!');
      return;
    }

    if (response.success == false && response.errors != null) {
      error = ErrorModel.fromJson(response.errors!);
      formKey.currentState!.validate();
      error = null;
      return;
    }

    if (response.success == true) {
      //
      var adminUser = UserModel.fromJson(response.data!);

      //
      showLoading('Session', 'Please wait...');
      SessionAccess.instance
          .createSession(adminUser, response.token!)
          .then((_) async {
        Get.close(1);
        showSuccessDialog('Success', 'Login successfully!');
        resetForm();
        html.window.location.reload();
      });

      //
    }
  }

//Controls
  void showPasswordToggle() {
    showPassword = !showPassword;
  }

  void resetForm() {
    emailController.clear();
    passwordController.clear();
  }

  // validations
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
    if (error?.password != null) {
      return error?.password;
    }
    return null;
  }

  //navigations
  void backtoLandingScreen() {
    Get.offAllNamed(CustomRoute.path.root);
  }

  void gotoSignupScreen() {
    Get.offNamed(CustomRoute.path.signup, preventDuplicates: true);
  }

  //Modals
  void showLoading(String? title, String? subtitle) {
    Get.defaultDialog(
      title: title ?? '',
      barrierDismissible: false,
      titlePadding: const EdgeInsets.all(10),
      contentPadding: const EdgeInsets.all(10),
      content: Center(
        child: Column(
          children: [
            Text(subtitle ?? ''),
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
      middleTextStyle: const TextStyle(color: Colors.black),
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
