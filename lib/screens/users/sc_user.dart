import 'package:admin/widgets/wg_appbar.dart';
import 'package:admin/widgets/wg_drawer.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'dart:html' as html;

class UserScreen extends StatelessWidget {
  const UserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    html.document.title = 'Naturemedix | Users';
    return Scaffold(
      drawer: customDrawer(),
      appBar: customAppBar(
        context,
        title: 'Users',
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
      body: Center(
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: LayoutBuilder(builder: (context, constraint) {
            return _buildBody(constraint);
          }),
        ),
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
          'Users',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
