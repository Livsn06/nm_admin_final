import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'dart:html' as html;

import '../../routes/rt_routers.dart';

class LandingScreen extends StatelessWidget {
  LandingScreen({super.key});

  var size;
  var width;
  var height;

  @override
  Widget build(BuildContext context) {
    html.document.title = 'Naturemedix';
    size = MediaQuery.of(Get.context!).size;
    width = size.width * 0.78;
    height = size.height;

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
            return SingleChildScrollView(
              child: Center(
                child: SizedBox(
                  width: width,
                  height: constraint.maxHeight,
                  child: LayoutBuilder(builder: (context, constraint2) {
                    return Stack(
                      children: [
                        Positioned(
                          top: 80,
                          left: 0,
                          child: _buildBody(constraint2),
                        ),
                        Positioned(
                          top: 0,
                          left: 0,
                          child: _buildNavigation(constraint2),
                        ),
                      ],
                    );
                  }),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget _buildNavigation(constraint) {
    return SizedBox(
      width: constraint.maxWidth,
      height: height * 0.14,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          RichText(
            text: const TextSpan(
              children: [
                TextSpan(
                  text: 'Nature',
                  style: TextStyle(
                    color: Color(0xFF007E62),
                    fontSize: 32,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                TextSpan(
                  text: ' Medix',
                  style: TextStyle(
                    fontSize: 18,
                    color: Color(0xFF000000),
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  print('About us');
                },
                child: Text(
                  'About us',
                  style: _linkStyle(),
                ),
              ),
              const Gap(20),
              GestureDetector(
                onTap: () {
                  print('Contact us');
                },
                child: Text(
                  'Contact us',
                  style: _linkStyle(),
                ),
              ),
              const Gap(20),
              GestureDetector(
                onTap: () {
                  Get.toNamed('/login', preventDuplicates: true);
                },
                child: Text(
                  'Login',
                  style: _linkStyle(),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  TextStyle _linkStyle() {
    return const TextStyle(fontSize: 14, fontWeight: FontWeight.w600);
  }

  Widget _buildBody(constraint) {
    return SizedBox(
      width: constraint.maxWidth,
      height: constraint.maxHeight,
      child: Stack(
        children: [
          Positioned(
            top: 60,
            right: 0,
            child: _buildImage(),
          ),
          Positioned(
            top: 110,
            left: 0,
            child: _buildText(),
          ),
        ],
      ),
    );
  }

  Widget _buildImage() {
    return Container(
        width: 488,
        height: 388,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/sys_image/ast_landing_hero.png'),
            fit: BoxFit.fill,
          ),
        ));
  }

  Widget _buildText() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Empowering \nNurture Natural Health',
          textAlign: TextAlign.left,
          style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.w900,
          ),
        ),
        const Gap(20),
        const Text(
          'Naturemedix comprehensive platform empowers you to make herbal plant \nremedies safe and efficacy of your herbal products.',
          textAlign: TextAlign.left,
          style: TextStyle(
            fontSize: 16,
          ),
        ),
        const Gap(30),
        MaterialButton(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
          color: const Color(0xFF007E62),
          onPressed: () {
            Get.toNamed('/signup', preventDuplicates: true);
          },
          child: const Text(
            'Get Started',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        )
      ],
    );
  }
}
