import 'package:admin/controllers/ct_user.dart';
import 'package:admin/widgets/wg_appbar.dart';
import 'package:admin/widgets/wg_drawer.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'dart:html' as html;

import 'package:get/get.dart';

import '../../api/image/api_image.dart';
import '../../routes/rt_routers.dart';

class UserTableScreen extends StatefulWidget with OtherFunctionality {
  const UserTableScreen({super.key});

  @override
  State<UserTableScreen> createState() => _UserTableScreenState();
}

class _UserTableScreenState extends State<UserTableScreen> {
  var userController = Get.put(UserController());

  //
  @override
  Widget build(BuildContext context) {
    html.document.title = 'Naturemedix | Users';
    return Scaffold(
      drawer: customDrawer(),
      appBar: customAppBar(
        context,
        onBackTap: () {
          Get.offNamed(CustomRoute.path.plants);
        },
        title: 'Users Table',
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
        return Container(
          color: Colors.white,
          alignment: Alignment.center,
          padding: const EdgeInsets.all(10),
          width: constraint.maxWidth,
          height: constraint.maxHeight,
          child: Column(
            children: [
              _buildSmallNavigation('Go To My Profile'),
              const Gap(10),
              _buildTable(constraint),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildSmallNavigation(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Wrap(
            spacing: 20,
            alignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              TextField(
                controller: TextEditingController(),
                style: const TextStyle(color: Colors.black, fontSize: 16),
                decoration: InputDecoration(
                  labelText: 'Search',
                  prefixIcon: const Icon(Icons.search),
                  constraints:
                      const BoxConstraints(maxWidth: 240, maxHeight: 40),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              // MaterialButton(
              //   color: const Color(0xFF007E62),
              //   textColor: Colors.white,
              //   onPressed: () {
              //     Get.toNamed(CustomRoute.path.plantsCreate);
              //   },
              //   child: const Text(
              //     'Add Plant',
              //     style: TextStyle(
              //       fontWeight: FontWeight.bold,
              //     ),
              //   ),
              // ),
            ],
          ),
          TextButton(
            onPressed: () {
              Get.offAndToNamed(CustomRoute.path.remediesTable);
            },
            child: Text(
              title,
              style: const TextStyle(
                decoration: TextDecoration.underline,
                decorationColor: Color(0xFF007E62),
                color: Color(0xFF007E62),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTable(constraint) {
    return Container(
      color: const Color(0xFFE4FFF2),
      width: constraint.maxWidth,
      height: constraint.maxHeight - 115,
      child: Obx(() {
        return ListView.builder(
            itemCount: userController.usersRoleUser.value.length,
            itemBuilder: (context, index) {
              var user = userController.usersRoleUser.value[index];
              return Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  border: Border.symmetric(
                    horizontal: BorderSide(
                      color: Color.fromARGB(255, 231, 231, 231),
                    ),
                  ),
                ),
                child: ListTile(
                  onTap: () {},
                  tileColor: Colors.white,
                  style: ListTileStyle.list,
                  leading: SizedBox(
                    width: 60,
                    height: 60,
                    child: user.avatar == null
                        ? Image.asset('assets/placeholder/user_avata1.png')
                        : _loadingImage(user.avatar!),
                  ),
                  title: Text(
                    '${user.firstname} ${user.lastname}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text('${user.email}'),
                  trailing: InkWell(
                    child: _buildStatusContainer('${user.status}'),
                    onTap: () {},
                  ),
                ),
              );
            });
      }),
    );
  }

  Widget _loadingImage(path) {
    return FutureBuilder(
      future: ApiImage.getImage(path),
      builder: (context, snapshot) {
        if (snapshot.hasError || !snapshot.hasData) {
          return Image.asset('assets/placeholder/user_avata1.png');
        }
        if (snapshot.hasData) {
          var data = snapshot.data;
          return Image.memory(
            data!.image_data!,
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _buildStatusContainer(String status) {
    return Container(
      color: status == 'Active'
          ? Colors.green
          : status == 'Inactive'
              ? const Color(0xFFD3A21A)
              : Colors.grey,
      width: 80,
      height: 20,
      child: Center(
          child: Text(status, style: const TextStyle(color: Colors.white))),
    );
  }

  //
  Widget _buildLoading(constraint) {
    return SizedBox(
      // color: Colors.green,
      width: constraint.maxWidth,
      height: constraint.maxHeight,
      child: const Center(child: Center(child: CircularProgressIndicator())),
    );
  }

  Widget _buildError(constraint) {
    return SizedBox(
      // color: Colors.red,
      width: constraint.maxWidth,
      height: constraint.maxHeight,
      child: Center(
        child: MaterialButton(
          color: Colors.blue,
          textColor: Colors.white,
          onPressed: () {
            userController.loadAllData();
          },
          child: const Text('Retry'),
        ),
      ),
    );
  }
}

mixin OtherFunctionality {
  //
  Future<bool> changeStatusModal(String status) async {
    bool isChange = false;
    await Get.dialog(
      AlertDialog(
        insetPadding: const EdgeInsets.all(20),
        content: Text('Make $status?'),
        contentTextStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
        actions: [
          MaterialButton(
            onPressed: () {
              isChange = false;
              Get.back();
            },
            child: const Text('No'),
          ),
          MaterialButton(
            color: const Color(0xFF007E62),
            textColor: Colors.white,
            onPressed: () {
              isChange = true;
              Get.back();
            },
            child: const Text('Yes'),
          ),
        ],
      ),
    );
    return isChange;
  }
}
