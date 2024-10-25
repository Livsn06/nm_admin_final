import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'dart:html' as html;

class SignupScreen extends StatelessWidget {
  SignupScreen({super.key});
  var size;
  var width;
  var height;
  @override
  Widget build(BuildContext context) {
    html.document.title = 'Naturemedix | Signup';
    size = MediaQuery.of(Get.context!).size;
    width = size.width * 0.78;
    height = size.height;

    //
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: double.maxFinite,
          height: double.maxFinite,
          child: LayoutBuilder(builder: (context, constraint) {
            return Stack(
              children: [
                Positioned(
                  top: 60,
                  left: 180,
                  child: _buildBody(constraint),
                ),
                Positioned(
                  top: 20,
                  left: 30,
                  child: _buildLogo(),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: _buildImage(constraint),
                )
              ],
            );
          }),
        ),
      ),
    );
  }

  Widget _buildBody(constraint) {
    return SizedBox(
      height: constraint.maxHeight,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
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
            'Create an new account',
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
          const Gap(20),
          Form(
            child: Column(
              children: [
                TextFormField(
                  controller: TextEditingController(),
                  decoration: _buildFormDecoration('First Name'),
                ),
                const Gap(14),
                TextFormField(
                  controller: TextEditingController(),
                  decoration: _buildFormDecoration('Last Name'),
                ),
                const Gap(14),
                TextFormField(
                  controller: TextEditingController(),
                  decoration: _buildFormDecoration('Email Address'),
                ),
                const Gap(14),
                TextFormField(
                  controller: TextEditingController(),
                  decoration: _buildFormDecoration('Password'),
                ),
                const Gap(14),
                TextFormField(
                  controller: TextEditingController(),
                  decoration: _buildFormDecoration('Confirm Password'),
                ),
                const Gap(16),
                MaterialButton(
                  minWidth: 440,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                  color: const Color(0xFF007E62),
                  onPressed: () {},
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
                  Get.offNamed('/login', preventDuplicates: true);
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
  }

  InputDecoration _buildFormDecoration(label) {
    return InputDecoration(
      labelText: label,
      border: const OutlineInputBorder(),
      constraints: const BoxConstraints(
        maxWidth: 430,
      ),
    );
  }

  Widget _buildLogo() {
    return GestureDetector(
      onTap: () {
        Get.back(result: '/', closeOverlays: true);
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

  Widget _buildImage(constraint) {
    return Container(
      width: size.width / 3,
      height: constraint.maxHeight,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/sys_image/ast_auth_hero.jpg'),
          fit: BoxFit.cover,
          alignment: Alignment(-0.7, 0.0),
          opacity: 0.9,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black,
          )
        ],
      ),
    );
  }
}
