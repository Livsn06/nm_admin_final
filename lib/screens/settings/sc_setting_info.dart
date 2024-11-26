import 'package:admin/api/image/api_image.dart';
import 'package:admin/models/user/md_user.dart';
import 'package:admin/sessions/sn_access.dart';
import 'package:admin/widgets/wg_drawer.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'dart:html' as html;

import '../../api/auth/api_logout.dart';
import '../../routes/rt_routers.dart';
import '../../widgets/wg_appbar.dart';

class MyProfileScreen extends StatefulWidget {
  const MyProfileScreen({super.key});

  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

late UserModel user;

class _MyProfileScreenState extends State<MyProfileScreen> {
  @override
  Widget build(BuildContext context) {
    html.document.title = 'Naturemedix | My Profile';

    return Scaffold(
      drawer: customDrawer(),
      appBar: customAppBar(
        context,
        title: 'My Profile',
        onBackTap: () {
          Get.offNamed(CustomRoute.path.settings);
        },
      ),
      body: LayoutBuilder(builder: (context, constraint) {
        return FutureBuilder(
            future: SessionAccess.instance.getSessionData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (snapshot.hasError || !snapshot.hasData) {
                return Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(snapshot.error.toString()),
                      const Gap(8),
                      MaterialButton(
                        color: Colors.red,
                        textColor: Colors.white,
                        child: const Text('Refresh'),
                        onPressed: () {
                          setState(() {});
                        },
                      )
                    ],
                  ),
                );
              }

              user = snapshot.data!;
              return _buildBody(constraint);
            });
      }),
    );
  }

  Widget _buildBody(constraint) {
    return Container(
        width: constraint.maxWidth,
        height: constraint.maxHeight,
        color: const Color(0xFFEFEFEF),
        child: Center(
          child: _buildProfileInformation(),
        ));
  }

  Widget _buildProfileInformation() {
    return Container(
      width: double.maxFinite,
      height: double.maxFinite,
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Color(0xFFEFEFEF),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(88, 0, 0, 0),
            blurRadius: 3,
            offset: Offset(0, 0),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.topRight,
            child: IconButton(
              icon: const Icon(
                Icons.edit,
                color: Colors.black,
              ),
              onPressed: () {},
            ),
          ),
          const Gap(10),
          Center(
            child: CircleAvatar(
              radius: 60,
              child: user.avatar == null
                  ? Image.asset(
                      'assets/placeholder/user_avata1.png',
                      fit: BoxFit.cover,
                    )
                  : _loadingImage(user.avatar!),
            ),
          ),
          const Gap(18),
          Center(
            child: Text(
              '${user.firstname} ${user.lastname}',
              style: const TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Gap(4),
          Center(
            child: Text(
              '${user.type}',
              style: const TextStyle(
                color: Colors.black,
                fontSize: 13,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          const Gap(8),
          Center(
            child: Text(
              '${user.email}',
              style: const TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 150),
            child: Divider(
              color: Color(0x939E9E9E),
              thickness: 0.6,
            ),
          ),
          const Gap(12),
          Center(
            child: Text(
              'Work Information:'.toUpperCase(),
              style: const TextStyle(
                color: Color(0x9D000000),
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Gap(10),
          Center(
            child: Text(
              '${user.total_create ?? 0} total plant created',
              style: const TextStyle(
                color: Color.fromARGB(87, 0, 158, 32),
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const Gap(6),
          Center(
            child: Text(
              '${user.total_update ?? 0} total plant updated',
              style: const TextStyle(
                color: Color.fromRGBO(149, 114, 0, 0.523),
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const Gap(6),
          Center(
            child: Text(
              '${user.total_delete ?? 0} total plant  deleted',
              style: const TextStyle(
                color: Color(0x6FFF0303),
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const Spacer(),
          Center(
            child: MaterialButton(
              color: Colors.red,
              textColor: Colors.white,
              onPressed: () async {
                _askLogout();
              },
              child: const Text('Logout'),
            ),
          ),
        ],
      ),
    );
  }

  void _askLogout() {
    Get.defaultDialog(
      title: 'Logout',
      content: const Text('Are you sure to logout?'),
      confirmTextColor: Colors.red,
      cancelTextColor: Colors.black,
      textCancel: 'Cancel',
      textConfirm: 'Logout',
      onCancel: () => Get.close(1),
      onConfirm: () {
        _logout();
        Get.close(1);
      },
    );
  }

  void _logout() async {
    await LogoutApi.auth.logoutAccount();
    SessionAccess.instance.destroySession();
    Get.showSnackbar(const GetSnackBar(
      message: 'Logout successfully',
      duration: Duration(seconds: 3),
    ));
    html.window.location.reload();
  }

  Widget _loadingImage(path) {
    return FutureBuilder(
      future: ApiImage.getImage(path),
      builder: (context, snapshot) {
        if (snapshot.hasError || !snapshot.hasData) {
          return Image.asset('assets/placeholder/plant_image1.jpg',
              fit: BoxFit.cover);
        }
        if (snapshot.hasData) {
          return Image.memory(
            snapshot.data!.image_data!,
            fit: BoxFit.cover,
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
