import 'dart:typed_data';

import 'package:admin/controllers/ct_plant.dart';
import 'package:admin/controllers/ct_requestplant.dart';
import 'package:admin/controllers/ct_user.dart';
import 'package:admin/controllers/ct_workplace.dart';
import 'package:admin/routes/rt_routers.dart';
import 'package:admin/widgets/wg_appbar.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:image_network/image_network.dart';
import 'dart:html' as html;

import '../../controllers/const.dart';
import '../../widgets/wg_drawer.dart';

class DashboardScreen extends StatelessWidget {
  DashboardScreen({super.key});
  final plantController = Get.put(PlantController());
  final workplaceController = Get.put(WorkplaceController());
  var requestplantController = Get.put(RequestPlantController());
  final userController = Get.put(UserController());

  //
  @override
  Widget build(BuildContext context) {
    requestplantController = Get.put(RequestPlantController());
    html.document.title = 'Naturemedix | Dashboard';
    return Scaffold(
      drawer: customDrawer(),
      appBar: customAppBar(
        context,
        title: 'Dashboard',
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
          const Gap(20),
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
            'Dashboard',
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
    return SizedBox(
      width: constraint.maxWidth,
      height: constraint.maxHeight,
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(15),
          color: Colors.white,
          width: constraint.maxWidth,
          height: constraint.maxHeight + 240,
          child: LayoutBuilder(builder: (context, constraint2) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildMainBody(constraint2),
                _buildNewRequestBody(constraint2),
              ],
            );
          }),
        ),
      ),
    );
  }

  Widget _buildMainBody(constraint) {
    return Container(
      padding: const EdgeInsets.all(30),
      height: constraint.maxHeight - 60,
      width: constraint.maxWidth * 0.74,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          colors: [
            Color.fromARGB(255, 255, 255, 255),
            Color.fromARGB(255, 255, 255, 255),
          ],
        ),
        borderRadius: BorderRadius.all(Radius.circular(10)),
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(88, 0, 0, 0),
            blurRadius: 3,
            offset: Offset(0, 0),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: _buildTitle('Data Analysis')),
          const Gap(20),
          Wrap(
            spacing: constraint.maxWidth * 0.0078,
            children: [
              _buildPlantGraph(constraint),
              _buildUserGraph(constraint),
              _buildWorkplaceGraph(constraint),
            ],
          ),
          const Gap(40),
          divider(),
          const Gap(40),

          //
          Expanded(
              child: _buildTitle(
            'Currently Working',
            isView: true,
            viewAll: () {
              Get.toNamed(CustomRoute.path.workplace);
            },
          )),
          const Gap(20),
          _buildDataView(constraint)
        ],
      ),
    );
  }

  Widget divider() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 220),
      child: Divider(
        color: Colors.grey.shade400,
      ),
    );
  }

  Widget _buildDataView(constraint) {
    return Container(
      color: const Color.fromARGB(255, 246, 246, 246),
      width: constraint.maxWidth,
      height: constraint.maxHeight - 450,
      alignment: Alignment.center,
      child: Obx(() {
        return ListView.builder(
          itemCount: workplaceController.getInprogressStatus.length,
          itemBuilder: (context, index) {
            var workplace = workplaceController.getInprogressStatus[index];
            return Card(
                color: Colors.white,
                child: ListTile(
                  leading: Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                          '${workplace.images?[0]}',
                        ),
                      ),
                    ),
                  ),
                  title: Text('${workplace.plantName}'),
                  subtitle: Text('${workplace.scientific_name}'),
                  trailing: Text('${workplace.updated_at}'),
                ));
          },
        );
      }),
    );
  }

  Widget _buildNewRequestBody(constraint) {
    return Container(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
        height: constraint.maxHeight - 260,
        width: constraint.maxWidth * 0.25,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            colors: [
              Color.fromARGB(255, 255, 255, 255),
              Color.fromARGB(255, 255, 255, 255),
            ],
          ),
          borderRadius: BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              color: Color.fromARGB(88, 0, 0, 0),
              blurRadius: 3,
              offset: Offset(0, 0),
            ),
          ],
        ),
        child: Column(
          children: [
            Expanded(
                child: _buildTitle(
              'New Requests',
              isView: true,
              viewAll: () {
                Get.toNamed(CustomRoute.path.requestsTable);
              },
            )),
            Expanded(
              flex: 14,
              child: Container(
                color: const Color.fromARGB(0, 0, 0, 0),
                child: ListView.builder(
                  itemCount: REQUESTS.value.length,
                  itemBuilder: (context, index) {
                    if (REQUESTS.value.isEmpty) {
                      return const Center(
                          child: Text(
                        'No Data Found',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ));
                    }
                    var data = REQUESTS.value[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 0.02),
                      child: Card(
                        color: const Color.fromARGB(255, 255, 255, 255),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(
                            color: Color.fromARGB(255, 210, 210, 210),
                          ),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: ListTile(
                          title: Text('${data.scientific_name}'),
                          leading: ImageNetwork(
                            image: data.images?[0],
                            height: 50,
                            width: 50,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ));
  }

  Widget _buildTitle(String title, {bool isView = false, Function()? viewAll}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title.toUpperCase(),
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        if (isView)
          TextButton(
            onPressed: viewAll,
            child: const Text(
              'View All',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Color(0xFF007E62),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildPlantGraph(constraint) {
    return Container(
      padding: const EdgeInsets.all(15),
      constraints: const BoxConstraints(
        minWidth: 260,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        border:
            Border.all(color: const Color.fromARGB(255, 0, 0, 0), width: 0.1),
      ),
      width: constraint.maxWidth * 0.22,
      height: 140,
      child: LayoutBuilder(
        builder: (context, constraint2) {
          return Obx(() {
            var totalPlant = plantController.plantData.value.length.toDouble();
            var totalActive =
                plantController.plantActive.value.length.toDouble();
            return Stack(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: _buildTitleCard(key: 1, constraint2, 'Plants'),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: _buildBarGraph(
                      key: 1, constraint2, total: totalPlant, min: totalActive),
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: _buildData(data: '$totalPlant', 'Total Plants'),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: _buildLogo(key: 1, Icons.local_florist),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: _buildActive(data: '$totalActive', 'Active'),
                ),
              ],
            );
          });
        },
      ),
    );
  }

  Widget _buildUserGraph(constraint) {
    return Container(
      padding: const EdgeInsets.all(15),
      constraints: const BoxConstraints(
        minWidth: 260,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        border:
            Border.all(color: const Color.fromARGB(255, 0, 0, 0), width: 0.1),
      ),
      width: constraint.maxWidth * 0.22,
      height: 140,
      child: LayoutBuilder(
        builder: (context, constraint2) {
          return Obx(() {
            var totalUser =
                userController.usersRoleUser.value.length.toDouble();
            var totalActive =
                userController.usersRoleUserActive.length.toDouble();
            return Stack(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: _buildTitleCard(key: 2, constraint2, 'Users'),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: _buildBarGraph(
                      key: 2, constraint2, total: totalUser, min: totalActive),
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: _buildData(data: '$totalUser', 'Total Users'),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: _buildLogo(key: 2, Icons.person_pin),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: _buildActive(data: '$totalActive', 'Active'),
                )
              ],
            );
          });
        },
      ),
    );
  }

  Widget _buildWorkplaceGraph(constraint) {
    return Container(
      padding: const EdgeInsets.all(15),
      constraints: const BoxConstraints(
        minWidth: 260,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        border:
            Border.all(color: const Color.fromARGB(255, 0, 0, 0), width: 0.1),
      ),
      width: constraint.maxWidth * 0.22,
      height: 140,
      child: LayoutBuilder(
        builder: (context, constraint2) {
          return Obx(() {
            var totalWorkplace =
                workplaceController.workplaceData.value.length.toDouble();
            var totalInprogress =
                workplaceController.getInprogressStatus.length.toDouble();
            var totalCompleted =
                workplaceController.getCompletedStatus.length.toDouble();
            return Stack(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: _buildTitleCard(key: 3, constraint2, 'Workplace'),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: _buildBarGraph(
                    constraint2,
                    key: 3,
                    total: totalWorkplace,
                    min: totalCompleted,
                  ),
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: _buildData(data: '$totalWorkplace', 'Total Accepted'),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: _buildLogo(key: 3, Icons.wysiwyg_outlined),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: _buildActive(data: '$totalInprogress', 'Inprogress'),
                )
              ],
            );
          });
        },
      ),
    );
  }

  Widget _buildActive(String dataOf, {required String data}) {
    return RichText(
      text: TextSpan(children: [
        TextSpan(
          text: data,
          style: const TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.bold,
          ),
        ),
        TextSpan(
          text: ' $dataOf',
          style: const TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.bold,
          ),
        ),
      ]),
    );
  }

  Widget _buildLogo(IconData icon, {required int key}) {
    return Icon(
      icon,
      color: key == 1
          ? const Color(0xFF007E62)
          : key == 2
              ? const Color(0xFFDCAB09)
              : const Color(0xFF000000),
      size: 40,
    );
  }

  Widget _buildData(String dataOf, {required String data}) {
    return Container(
      child: RichText(
        text: TextSpan(children: [
          TextSpan(
              text: data,
              style: const TextStyle(
                fontSize: 28,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              )),
          TextSpan(
              text: ' $dataOf',
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              )),
        ]),
      ),
    );
  }

  Widget _buildBarGraph(
    constraint, {
    required int key,
    double min = 0.0,
    double total = 0.0,
  }) {
    double width = 200;
    var valueWith = _graphCalculate(min, total, width);
    return Container(
      width: width,
      height: 10,
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Stack(
        children: [
          Container(
            width: valueWith,
            height: 10,
            decoration: BoxDecoration(
              color: key == 1
                  ? const Color(0xFF007E62)
                  : key == 2
                      ? const Color(0xFFDCAB09)
                      : const Color(0xFF000000),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ],
      ),
    );
  }

  double _graphCalculate(double min, double total, double width) {
    if (min == 0 || total == 0) {
      return 0;
    }
    double value = (min / total);
    value = width * value;

    return value;
  }

  Widget _buildTitleCard(constraint, String title, {required int key}) {
    return Container(
      width: 100,
      height: 20,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(3),
        color: key == 1
            ? const Color.fromARGB(255, 0, 113, 68).withOpacity(0.2)
            : key == 2
                ? const Color.fromARGB(255, 193, 174, 0).withOpacity(0.2)
                : const Color.fromARGB(255, 0, 0, 0).withOpacity(0.2),
        // border: Border.all(color: const Color(0xFF007E62)),
      ),
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
