import 'package:admin/routes/rt_routers.dart';
import 'package:admin/widgets/wg_appbar.dart';
import 'package:admin/widgets/wg_drawer.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'dart:html' as html;

import 'package:get/get.dart';

class PlantScreen extends StatelessWidget {
  const PlantScreen({super.key});

  @override
  Widget build(BuildContext context) {
    html.document.title = 'Naturemedix | Plants';
    return Scaffold(
      drawer: customDrawer(),
      appBar: customAppBar(
        context,
        title: 'Plants',
        isPrimary: true,
        actions: [
          InkWell(
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            onTap: () {},
            child: const CircleAvatar(
              radius: 18,
              child: Icon(
                Icons.notifications,
                color: Color(0xFF007E62),
              ),
            ),
          ),
          const Gap(10),
          Builder(
            builder: (BuildContext context) {
              return InkWell(
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                onTap: () {
                  Scaffold.of(context).openDrawer();
                },
                child: const CircleAvatar(
                  radius: 18,
                  child: Icon(
                    Icons.menu_sharp,
                    color: Color(0xFF007E62),
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: LayoutBuilder(builder: (context, constraint) {
        return _buildBody(constraint);
      }),
    );
  }

  Widget _buildBody(constraint) {
    return Container(
      width: constraint.maxWidth,
      height: constraint.maxHeight,
      color: const Color(0xFFEFEFEF),
      child: Center(
        child: _buildRequestOption(),
      ),
    );
  }

  Widget _buildRequestOption() {
    //
    return LayoutBuilder(builder: (context, constraints) {
      return Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            optionButton(
              imagePath: 'assets/sys_image/ast_request_hero.png',
              title: 'List of Plants',
              subtitle: 'Explore the list of plants based on your perspective.',
              isNew: true,
              onTap: () {
                Get.toNamed(CustomRoute.path.plantsTable);
              },
            ),
            const Gap(4),
            optionButton(
              imagePath: 'assets/sys_image/ast_request_hero2.png',
              title: 'List of Remedy',
              subtitle:
                  'Explore the list of remedies based on your perspective.',
              isNew: true,
              onTap: () {
                Get.toNamed(CustomRoute.path.remediesTable);
              },
            ),
          ],
        ),
      );
    });
  }

  Widget optionButton({
    Function()? onTap,
    String? imagePath,
    String? title,
    String? subtitle,
    bool isNew = false,
  }) {
    return InkWell(
      onTap: onTap,
      child: Card(
        elevation: 3,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              _buildImage(imagePath),
              const Gap(30),
              _buildTitles(title, subtitle),
              const Spacer(),
              _buildBanner(isNew),
              const Gap(30),
              _buildIcon()
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImage(imagePath) {
    return Image.asset(
      imagePath ?? 'assets/images/image5.png',
      height: 100,
    );
  }

  Widget _buildTitles(title, subtitle) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title ?? 'Title',
          style: const TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          subtitle ?? 'Subtitle',
          style: const TextStyle(
            color: Colors.black,
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }

  Widget _buildIcon() {
    return const Icon(
      Icons.arrow_right,
      size: 30,
    );
  }

  Widget _buildBanner(bool isNew) {
    return Visibility(
      visible: isNew,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.red, borderRadius: BorderRadius.circular(10)),
        padding: const EdgeInsets.symmetric(
          vertical: 6,
          horizontal: 26,
        ),
        child: const Text(
          'New',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
