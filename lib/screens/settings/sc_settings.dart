import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'dart:html' as html;

import 'package:get/get.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    html.document.title = 'Naturemedix | Plants';
    return Scaffold(
      drawer: _buildDrawer(),
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

  Widget _buildDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(),
            child: Center(
              child: RichText(
                text: const TextSpan(
                  children: [
                    TextSpan(
                      text: 'Nature',
                      style: TextStyle(
                        color: Color(0xFF007E62),
                        fontSize: 24,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    TextSpan(
                      text: ' Medix',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFF000000),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const ListTile(
            titleAlignment: ListTileTitleAlignment.center,
            leading: Icon(
              Icons.dashboard,
              color: Colors.black,
            ),
            textColor: Colors.black,
            tileColor: null,
            title: Text('Dashboard'),
          ),
          const ListTile(
            titleAlignment: ListTileTitleAlignment.center,
            leading: Icon(
              Icons.event_note,
              color: Colors.black,
            ),
            textColor: Colors.black,
            tileColor: null,
            title: Text('Requests'),
          ),
          const ListTile(
            titleAlignment: ListTileTitleAlignment.center,
            leading: Icon(
              Icons.local_florist,
              color: Colors.black,
            ),
            textColor: Colors.black,
            tileColor: null,
            title: Text('Plants'),
          ),
          const ListTile(
            titleAlignment: ListTileTitleAlignment.center,
            leading: Icon(
              Icons.person_search,
              color: Colors.black,
            ),
            textColor: Colors.black,
            tileColor: null,
            title: Text('Users'),
          ),
          const ListTile(
            titleAlignment: ListTileTitleAlignment.center,
            leading: Icon(Icons.settings, color: Colors.white),
            textColor: Colors.white,
            tileColor: Color(0xFF007E62),
            title: Text('Settigs'),
          ),
        ],
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
            'Settings',
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
          'Settings',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
