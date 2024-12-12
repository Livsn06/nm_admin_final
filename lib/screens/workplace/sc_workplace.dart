import 'package:admin/routes/rt_routers.dart';
import 'package:admin/widgets/wg_appbar.dart';
import 'package:admin/widgets/wg_drawer.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';

import '../../controllers/const.dart';
import '../../controllers/ct_workplace.dart';

class WorkplaceScreen extends StatelessWidget {
  WorkplaceScreen({super.key});
  final workplaceController = Get.put(WorkplaceController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: customDrawer(),
      appBar: customAppBar(
        context,
        title: 'Workplace',
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
      body: LayoutBuilder(
        builder: (context, constraint) {
          return _buildBodyContents(constraint);
        },
      ),
    );
  }

  Widget _buildBodyContents(constraint) {
    return Container(
      padding: const EdgeInsets.all(20),
      width: constraint.maxWidth,
      height: constraint.maxHeight,
      child: DefaultTabController(
        initialIndex: 0,
        length: 3,
        child: Column(
          children: [
            _buildSmallNavigation('Requests Table'),
            const Gap(20),
            TabBar(
              controller: workplaceController.tabController,
              indicatorColor: const Color(0xFF007E62),
              tabAlignment: TabAlignment.start,
              isScrollable: true,
              labelColor: const Color(0xFF007E62),
              labelStyle: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
              unselectedLabelColor: Colors.grey,
              unselectedLabelStyle: const TextStyle(
                fontWeight: FontWeight.normal,
              ),
              tabs: const [
                Tab(text: 'All'),
                Tab(text: 'In progress'),
                Tab(text: 'Completed'),
              ],
            ),
            Expanded(
              child: TabBarView(
                controller: workplaceController.tabController,
                children: [
                  TabBody(
                    controller: workplaceController,
                    statusFilter: 'All',
                  ),
                  TabBody(
                    controller: workplaceController,
                    statusFilter: 'In Progress',
                  ),
                  TabBody(
                    controller: workplaceController,
                    statusFilter: 'Completed',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSmallNavigation(String title) {
    return Row(
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
            Get.offAndToNamed(CustomRoute.path.requestsTable);
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
    );
  }
}

class TabBody extends StatelessWidget {
  TabBody({super.key, required this.controller, required this.statusFilter});
  String statusFilter;
  WorkplaceController controller;
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      var filteredPlants = controller.workplaceData.value
          .where(
              (plant) => statusFilter == 'All' || plant.status == statusFilter)
          .toList();

      return GridView.builder(
        padding: const EdgeInsets.all(8),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 5,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        itemCount: ACCEPTED_REQUESTS.value.length + 1,
        itemBuilder: (context, index) {
          if (index - 1 == -1) {
            return CreateNewButton(
              ontap: () {
                Get.toNamed(CustomRoute.path.plantsCreate);
              },
            );
          }
          var plant = ACCEPTED_REQUESTS.value[index - 1];
          return PlantCard(
            plantname: plant.scientific_name!,
            status: 'Pending',
            date: '12/13/2024',
            plantimage:
                '${plant.images == null || plant.images!.isEmpty ? 'https://coffective.com/wp-content/uploads/2018/06/default-featured-image.png.jpg' : plant.images![0]}',
            ontap: () {
              SELECTED_REQUESTS.value = plant;
              Get.toNamed(CustomRoute.path.plantsCreate);
            },
          );
        },
      );
    });
  }
}

class CreateNewButton extends StatelessWidget {
  CreateNewButton({super.key, required this.ontap});
  Function()? ontap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Container(
          width: 150,
          height: 150,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.green[700]!, Colors.green[300]!],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: BorderRadius.circular(15),
          ),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // "Create New" Text
              Text(
                'Create New',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 8),
              // Plus Icon
              Icon(
                Icons.add_box_outlined,
                size: 40,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PlantCard extends StatelessWidget {
  PlantCard({
    super.key,
    required this.plantname,
    required this.status,
    required this.date,
    required this.plantimage,
    required this.ontap,
  });
  String plantname;
  String plantimage;
  String status;
  String date;
  Function()? ontap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // New Tag
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: getStatusColor(status),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  status,
                  style: TextStyle(
                    color:
                        (status == 'Completed') ? Colors.white : Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              // Plant Image (Placeholder for now)
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                      image: NetworkImage(plantimage),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              // Plant Name
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: Text(
                  plantname,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              // Date
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                child: Text(
                  date,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color getStatusColor(String status) {
    switch (status) {
      case 'New':
        return const Color(0xFF93F396);
      case 'Ongoing':
        return const Color(0xFFF8D093);
      case 'Completed':
        return const Color(0xFF00A308);
      default:
        return const Color(0xFFD8D8D8);
    }
  }
}
