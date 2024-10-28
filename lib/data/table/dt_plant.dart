import 'package:admin/models/plants/md_plant.dart';
import 'package:admin/models/plants/md_plant_table.dart';
import 'package:admin/models/request/md_request_plant.dart';
import 'package:admin/models/request/md_request_table.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

// ----------------------------------------------------------------------------
// REQUEST DATA SOURCE
class PlantDataSource extends DataGridSource with _TableContents {
  PlantDataSource({this.dataSource});

  static final instance = PlantDataSource();

  List<PlantsModel>? dataSource;
  List<GridColumn> get columns => customColumns();

  //
  @override
  List<DataGridRow> get rows => generateRows(source: dataSource ?? []);

  //GENERATE ROW DATA WITH CELL STYLES
  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
      color: Colors.white,
      cells: row
          .getCells()
          .map<Widget>((cell) =>
              cellStyle(columnName: cell.columnName, value: cell.value))
          .toList(),
    );
  }
}

// ----------------------------------------------------------------------------
mixin _TableContents {
  var tableModel = PlantsTableModel();
  //
  List<GridColumn> customColumns() {
    return tableModel
        .toColumns()
        .map((columnName) => GridColumn(
              minimumWidth: 170,
              columnWidthMode: ColumnWidthMode.auto,
              allowSorting: _disableSort(columnName),
              sortIconPosition: ColumnHeaderIconPosition.end,
              visible: hideColumn(columnName),
              columnName: columnName,
              label: _header_Style(columnName),
            ))
        .toList();
  }

  List<DataGridRow> generateRows({required List<PlantsModel> source}) {
    //
    return source
        .map(
          (PlantsModel data) => DataGridRow(cells: [
            DataGridCell<int>(
              columnName: tableModel.id!,
              value: data.id,
            ),
            DataGridCell<String>(
              columnName: tableModel.name!,
              value: data.name,
            ),
            DataGridCell<String>(
              columnName: tableModel.scientificName!,
              value: data.scientificName,
            ),
            DataGridCell<String>(
              columnName: tableModel.description!,
              value: data.description,
            ),
            DataGridCell<String>(
              columnName: tableModel.cover!,
              value: data.cover,
            ),
            DataGridCell<dynamic>(
              columnName: tableModel.admin!,
              value: data.admin?.name,
            ),
            DataGridCell<String>(
              columnName: tableModel.status!,
              value: data.status,
            ),
            DataGridCell<DateTime>(
              columnName: tableModel.updatedAt!,
              value: DateTime.parse(data.updatedAt!),
            ),
            DataGridCell<DateTime>(
              columnName: tableModel.createdAt!,
              value: DateTime.parse(data.createdAt!),
            ),
          ]),
        )
        .toList();
  }

  //SELECT WIDGETS BASED IN COLUMN
  Widget filterWidgetType(String value, String columnName) {
    // if (workplaceTableModel.image == columnName) {
    //   return Image.network(value);
    // }

    if (tableModel.updatedAt == columnName ||
        tableModel.createdAt == columnName) {
      return Text(formatDate(value),
          textWidthBasis: TextWidthBasis.longestLine);
    }

    return Text(value);
  }

  bool hideColumn(String columnName) {
    if (tableModel.description == columnName ||
        tableModel.id == columnName ||
        tableModel.updatedAt == columnName) {
      return false;
    }
    return true;
  }

  //FILTERS
  bool _disableSort(String columnName) {
    if (tableModel.description == columnName ||
        tableModel.image == columnName) {
      return false;
    }
    return true;
  }

  //STYLES
  Widget cellStyle({columnName, value}) {
    return LayoutBuilder(builder: (context, constraints) {
      return Container(
        width: constraints.maxWidth,
        alignment: Alignment.centerLeft,
        child: filterWidgetType(value.toString(), columnName),
      );
    });
  }

  Widget _header_Style(String label) {
    return LayoutBuilder(builder: (context, constraint) {
      return Container(
        width: constraint.maxWidth,
        alignment: Alignment.center,
        color: Colors.transparent,
        child: Text(
          textAlign: TextAlign.center,
          label,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      );
    });
  }

  String formatDate(String date) {
    var formattedDate = DateFormat('MMMM d, yyyy').format(DateTime.parse(date));
    return formattedDate;
  }
}
