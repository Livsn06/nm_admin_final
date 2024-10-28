import 'package:admin/controllers/ct_plant.dart';
import 'package:admin/data/table/dt_plant.dart';
import 'package:admin/routes/rt_routers.dart';
import 'package:admin/widgets/wg_appbar.dart';
import 'package:admin/widgets/wg_drawer.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class RemedyTableScreen extends StatelessWidget {
  RemedyTableScreen({super.key});
  var plantController = Get.put(PlantController());

  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: customDrawer(),
      appBar: customAppBar(
        context,
        isPrimary: true,
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
              _buildSmallNavigation('Go To Remedies'),
              const Gap(20),
              _buildTable(constraint),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildSmallNavigation(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
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
    );
  }

  Widget _buildTable(constraint) {
    return Expanded(
      child: SfDataGrid(
        columnWidthMode: ColumnWidthMode.fill,
        sortingGestureType: SortingGestureType.tap,
        allowSorting: true,
        headerGridLinesVisibility: GridLinesVisibility.horizontal,
        gridLinesVisibility: GridLinesVisibility.horizontal,
        shrinkWrapColumns: true,
        source: PlantDataSource(
          dataSource: plantController.getPlantData,
        ),
        columns: PlantDataSource.instance.columns,
      ),
    );
  }
}
