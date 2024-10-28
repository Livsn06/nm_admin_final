import 'package:admin/models/workplace/md_workplace.dart';
import 'package:admin/models/workplace/md_workplace_table.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

// ----------------------------------------------------------------------------
// REQUEST DATA SOURCE
class WorkplaceDataSource extends DataGridSource with WorkplaceTableContents {
  WorkplaceDataSource({this.workplaceData});

  static final instance = WorkplaceDataSource();

  List<WorkplaceModel>? workplaceData;
  List<GridColumn> get columns => workplaceColumns();

  //
  @override
  List<DataGridRow> get rows => generateRows(source: workplaceData ?? []);

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
mixin WorkplaceTableContents {
  var workplaceTableModel = WorkplaceTableModel();
  //
  List<GridColumn> workplaceColumns() {
    return workplaceTableModel
        .toColumns()
        .map((columnName) => GridColumn(
              maximumWidth: 145,
              columnWidthMode: ColumnWidthMode.auto,
              allowSorting: _disableSort(columnName),
              sortIconPosition: ColumnHeaderIconPosition.end,
              visible: hideColumn(columnName),
              columnName: columnName,
              label: _header_Style(columnName),
            ))
        .toList();
  }

  List<DataGridRow> generateRows({required List<WorkplaceModel> source}) {
    //
    return source
        .map(
          (WorkplaceModel data) => DataGridRow(cells: [
            DataGridCell<int>(
              columnName: workplaceTableModel.id!,
              value: data.id,
            ),
            DataGridCell<String>(
              columnName: workplaceTableModel.plantName!,
              value: data.plantName,
            ),
            DataGridCell<String>(
              columnName: workplaceTableModel.scientificName!,
              value: data.scientificName,
            ),
            DataGridCell<String>(
              columnName: workplaceTableModel.description!,
              value: data.description,
            ),
            DataGridCell<String>(
              columnName: workplaceTableModel.image!,
              value: data.images![0],
            ),
            DataGridCell<String>(
              columnName: workplaceTableModel.user!,
              value: data.user!.name,
            ),
            DataGridCell<dynamic>(
              columnName: workplaceTableModel.admin!,
              value: data.admin!.name,
            ),
            DataGridCell<String>(
              columnName: workplaceTableModel.status!,
              value: data.status,
            ),
            DataGridCell<DateTime>(
              columnName: workplaceTableModel.updatedAt!,
              value: DateTime.parse(data.updatedAt!),
            ),
            DataGridCell<DateTime>(
              columnName: workplaceTableModel.createdAt!,
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

    if (workplaceTableModel.updatedAt == columnName ||
        workplaceTableModel.createdAt == columnName) {
      return Text(formatDate(value),
          textWidthBasis: TextWidthBasis.longestLine);
    }

    return Text(value);
  }

  bool hideColumn(String columnName) {
    if (workplaceTableModel.description == columnName ||
        workplaceTableModel.createdAt == columnName ||
        workplaceTableModel.id == columnName ||
        workplaceTableModel.admin == columnName) {
      return false;
    }
    return true;
  }

  //FILTERS
  bool _disableSort(String columnName) {
    if (workplaceTableModel.description == columnName ||
        workplaceTableModel.image == columnName) {
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
