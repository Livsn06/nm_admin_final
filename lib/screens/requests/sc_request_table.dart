import 'package:admin/controllers/ct_requestplant.dart';

import 'package:admin/routes/rt_routers.dart';
import 'package:admin/widgets/wg_appbar.dart';
import 'package:admin/widgets/wg_drawer.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class RequestTableScreen extends StatelessWidget {
  RequestTableScreen({super.key});
  var requestPlantController = Get.put(RequestPlantController());

  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: customDrawer(),
      appBar: customAppBar(
        context,
        title: 'Requests Table',
        onBackTap: () {
          Get.offNamed(CustomRoute.path.requests);
        },
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
              _buildSmallNavigation('Go To Workplace'),
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
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextField(
            controller: TextEditingController(),
            style: const TextStyle(color: Colors.black, fontSize: 16),
            decoration: InputDecoration(
              labelText: 'Search',
              prefixIcon: const Icon(Icons.search),
              constraints: const BoxConstraints(maxWidth: 240, maxHeight: 40),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Get.offAndToNamed(CustomRoute.path.workplace);
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
    return Card(
      color: const Color(0xFFDDDDDD),
      child: Container(
        width: constraint.maxWidth,
        height: constraint.maxHeight - 130,
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: const Color(0xFFF1F1F1),
          border:
              Border.all(color: const Color.fromARGB(255, 0, 0, 0), width: 0.1),
        ),
        child: Obx(() {
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              crossAxisSpacing: 10,
              mainAxisSpacing: 5,
              childAspectRatio: 30 / 2,
            ),
            itemCount: requestPlantController.requestPlantData.value.length,
            itemBuilder: (context, index) {
              var request =
                  requestPlantController.requestPlantData.value[index];

              return Card(
                color: Colors.white,
                child: ListTile(
                  leading: Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                          '${request.images?[0].name}',
                        ),
                      ),
                    ),
                  ),
                  title: Text('${request.plantName}'),
                  subtitle: Text('${request.scientific_name}'),
                  trailing: colorIndicator('${request.status}'),
                ),
              );
            },
          );
        }),
      ),
    );
  }

  Widget colorIndicator(String status) {
    return Container(
      width: 80,
      height: 20,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: status == 'In Progress'
            ? const Color(0xFF9E8E00)
            : status == 'Completed'
                ? Colors.green
                : Colors.red,
        borderRadius: BorderRadius.circular(50),
      ),
      child: Text(status, style: const TextStyle(color: Colors.white)),
    );
  }
}
