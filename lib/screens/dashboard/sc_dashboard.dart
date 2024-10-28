import 'package:admin/controllers/ct_requestplant.dart';
import 'package:admin/controllers/ct_workplace.dart';
import 'package:admin/data/table/dt_workplace.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'dart:html' as html;

import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../widgets/wg_drawer.dart';

class DashboardScreen extends StatelessWidget {
  DashboardScreen({super.key});
  final workplaceController = Get.put(WorkplaceController());
  final requestplantController = Get.put(RequestPlantController());
  //
  @override
  Widget build(BuildContext context) {
    html.document.title = 'Naturemedix | Dashboard';
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
          _buildTitle('Data Analysis'),
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
          _buildTitle('Current Working'),
          const Gap(20),
          _buildWorkplaceTable(constraint)
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

  Widget _buildWorkplaceTable(constraint) {
    return Container(
      color: const Color.fromARGB(255, 246, 246, 246),
      width: constraint.maxWidth,
      height: constraint.maxHeight - 450,
      alignment: Alignment.center,
      child: SfDataGrid(
        sortingGestureType: SortingGestureType.tap,
        allowSorting: true,
        columnWidthMode: ColumnWidthMode.auto,
        headerGridLinesVisibility: GridLinesVisibility.horizontal,
        gridLinesVisibility: GridLinesVisibility.horizontal,
        loadMoreViewBuilder: (context, loadMoreRows) {
          print('loadmore');
          return null;
        },
        shrinkWrapColumns: true,
        source: WorkplaceDataSource(
          workplaceData: workplaceController.filterByStatus('In progress'),
        ),
        columns: WorkplaceDataSource.instance.columns,
      ),
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: _buildTitle('New Requests')),
            Expanded(
              flex: 14,
              child: Container(
                color: const Color.fromARGB(0, 0, 0, 0),
                child: ListView.builder(
                  itemCount: requestplantController.getPendingStatus.length,
                  itemBuilder: (context, index) {
                    var data = requestplantController.getPendingStatus[index];
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
                          leading: CircleAvatar(
                            backgroundColor: Colors.transparent,
                            radius: 20,
                            child: Image.asset(
                              'assets/sys_image/ast_landing_hero.png',
                            ),
                          ),
                          title: Text('${data.plantName}'),
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

  Widget _buildTitle(String title) {
    return Text(
      title.toUpperCase(),
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
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
          return Stack(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: _buildTitleCard(key: 1, constraint2, 'Plants'),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: _buildBarGraph(key: 1, constraint2),
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: _buildData(data: '1,400', 'Total Plants'),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: _buildLogo(key: 1, Icons.local_florist),
              ),
              Align(
                alignment: Alignment.topRight,
                child: _buildActive(data: '1,250', 'Active'),
              )
            ],
          );
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
          return Stack(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: _buildTitleCard(key: 2, constraint2, 'Users'),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: _buildBarGraph(key: 2, constraint2),
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: _buildData(data: '2,350', 'Total Users'),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: _buildLogo(key: 2, Icons.person_pin),
              ),
              Align(
                alignment: Alignment.topRight,
                child: _buildActive(data: '2,100', 'Active'),
              )
            ],
          );
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
          return Stack(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: _buildTitleCard(key: 3, constraint2, 'Workplace'),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: _buildBarGraph(key: 3, constraint2),
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: _buildData(data: '1,400', 'Total Uploads'),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: _buildLogo(key: 3, Icons.wysiwyg_outlined),
              ),
              Align(
                alignment: Alignment.topRight,
                child: _buildActive(data: '10', 'Inprogress'),
              )
            ],
          );
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

  Widget _buildBarGraph(constraint, {required int key}) {
    return Container(
      width: 200,
      height: 10,
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Stack(
        children: [
          Container(
            width: 120,
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
