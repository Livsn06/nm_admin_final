import 'package:admin/widgets/wg_drawer.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'dart:html' as html;

import 'package:get/get.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    html.document.title = 'Naturemedix | Notifications';
    return Scaffold(
      drawer: customDrawer(),
      body: Center(
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: LayoutBuilder(builder: (context, constraint) {
            return Stack(
              children: [
                Positioned(
                  top: 60,
                  left: 0,
                  child: _buildBody(constraint),
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  child: _buildNavigation(context, constraint),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }

  Widget _buildNavigation(context, constraint) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      width: constraint.maxWidth,
      height: 60,
      decoration: const BoxDecoration(
        color: Color(0xFF007E62),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Notifications',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
          Row(
            children: [
              GestureDetector(
                onTap: () {},
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.notifications,
                    color: Color(0xFF007E62),
                  ),
                ),
              ),
              const Gap(10),
              GestureDetector(
                onTap: () {
                  Scaffold.of(context).openDrawer();
                },
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.menu_sharp,
                    color: Color(0xFF007E62),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildBody(constraint) {
    return Container(
      width: constraint.maxWidth,
      height: constraint.maxHeight,
      color: const Color(0xFFEFEFEF),
      child: const Center(
        child: Text(
          'Notifications',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
