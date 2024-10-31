import 'package:admin/models/plant/md_plant.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

// ----------------------------------------------------------------------------
// REQUEST DATA SOURCE
class PlantDataSource extends DataGridSource with _TableContents {
  PlantDataSource({this.dataSource});

  static final instance = PlantDataSource();

  List<PlantModel>? dataSource;
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

  List<DataGridRow> generateRows({required List<PlantModel> source}) {
    //
    return source
        .map(
          (PlantModel data) => DataGridRow(cells: [
            DataGridCell<int>(
              columnName: tableModel.id!,
              value: data.id ?? 0,
            ),
            DataGridCell<String>(
              columnName: tableModel.name!,
              value: data.name ?? 'N/A',
            ),
            DataGridCell<String>(
              columnName: tableModel.scientific!,
              value: data.scientific ?? 'N/A',
            ),
            DataGridCell<String>(
              columnName: tableModel.description!,
              value: data.description ?? 'N/A',
            ),
            DataGridCell<String>(
              columnName: tableModel.cover!,
              value: data.cover ?? 'default image',
            ),
            DataGridCell<String>(
              columnName: tableModel.status!,
              value: data.status ?? 'N/A',
            ),
            DataGridCell<int>(
              columnName: tableModel.likes!,
              value: data.likes ?? 0,
            ),
            DataGridCell<String>(
              columnName: tableModel.updated_by!,
              value: data.user_update_by?.name ?? 'N/A',
            ),
            DataGridCell<String>(
              columnName: tableModel.created_by!,
              value: data.user_create_by?.name ?? 'N/A',
            ),
            DataGridCell<DateTime>(
              columnName: tableModel.updated_at!,
              value: DateTime.parse(data.updated_at!),
            ),
            DataGridCell<DateTime>(
              columnName: tableModel.created_at!,
              value: DateTime.parse(data.created_at!),
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

    if (tableModel.updated_at == columnName ||
        tableModel.created_at == columnName) {
      return Text(formatDate(value),
          textWidthBasis: TextWidthBasis.longestLine);
    }

    return Text(value);
  }

  bool hideColumn(String columnName) {
    if (tableModel.description == columnName ||
        tableModel.id == columnName ||
        tableModel.updated_at == columnName ||
        tableModel.created_by == columnName ||
        tableModel.created_by == columnName) {
      return false;
    }
    return true;
  }

  //FILTERS
  bool _disableSort(String columnName) {
    if (tableModel.status == columnName || tableModel.cover == columnName) {
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
