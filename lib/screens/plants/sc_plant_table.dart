import 'dart:typed_data';

import 'package:admin/api/image/api_image.dart';
import 'package:admin/api/plant/api_plant.dart';

import 'package:admin/controllers/ct_plant.dart';
import 'package:admin/routes/rt_routers.dart';
import 'package:admin/sessions/sn_plant.dart';
import 'package:admin/widgets/wg_appbar.dart';
import 'package:admin/widgets/wg_drawer.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'dart:html' as html;

import 'package:image_network/image_network.dart';

class PlantTableScreen extends StatefulWidget with OtherFunctionality {
  const PlantTableScreen({super.key});

  @override
  State<PlantTableScreen> createState() => _PlantTableScreenState();
}

class _PlantTableScreenState extends State<PlantTableScreen> {
  var plantController = Get.put(PlantController());
  var searchTextController = TextEditingController();
  //
  @override
  Widget build(BuildContext context) {
    html.document.title = 'Naturemedix | Plants';
    return Scaffold(
      drawer: customDrawer(),
      appBar: customAppBar(
        context,
        onBackTap: () {
          Get.offNamed(CustomRoute.path.plants);
        },
        title: 'Plants Table',
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
      body: LayoutBuilder(builder: (context, constraint) {
        return Container(
          color: Colors.white,
          alignment: Alignment.center,
          padding: const EdgeInsets.all(10),
          width: constraint.maxWidth,
          height: constraint.maxHeight,
          child: Column(
            children: [
              _buildSmallNavigation('Go To Remedy Table'),
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
                controller: searchTextController,
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
                onChanged: (value) {
                  plantController.plantData.value =
                      plantController.filterByPlantName(value);
                },
              ),
              MaterialButton(
                color: const Color(0xFF007E62),
                textColor: Colors.white,
                onPressed: () {
                  Get.toNamed(CustomRoute.path.plantsCreate);
                },
                child: const Text(
                  'Add Plant',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
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
            itemCount: plantController.plantData.value.length,
            itemBuilder: (context, index) {
              var plant = plantController.plantData.value[index];
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
                  onTap: () async {
                    await SessionPlant.addEditPlant(plant);
                    Get.toNamed(
                      CustomRoute.path.plantsCreate,
                      preventDuplicates: true,
                    );
                  },
                  tileColor: Colors.white,
                  style: ListTileStyle.list,
                  leading: SizedBox(
                    width: 60,
                    height: 60,
                    child: plant.images!.isEmpty
                        ? Image.asset('assets/placeholder/plant_image1.jpg')
                        : ImageNetwork(
                            image: Uri.encodeFull(plant.images![0]),
                            width: 60,
                            height: 60,
                          ),
                  ),
                  title: Text(
                    '${plant.name}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text('${plant.scientific_name}'),
                  trailing: InkWell(
                    child: _buildStatusContainer('${plant.status}'),
                    onTap: () async {
                      var status = plant.status;
                      status = status == 'active' ? 'inactive' : 'Active';
                      var isUpdate = await widget.changeStatusModal(status);
                      if (isUpdate) {
                        plant.status = status;
                        await ApiPlant.updateStatus(plant: plant);
                      }
                      setState(() {});
                    },
                  ),
                ),
              );
            });
      }),
    );
  }

  Widget _buildStatusContainer(String status) {
    return Container(
      color: status == 'active'
          ? Colors.green
          : status == 'inactive'
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
            plantController.loadPlantData();
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
