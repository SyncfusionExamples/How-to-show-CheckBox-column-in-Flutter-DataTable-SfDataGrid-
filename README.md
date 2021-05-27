# How to show CheckBox column in Flutter DataTable SfDataGrid

The Flutter DataTable widget provides support to load any type of widget in each cell. Show the checkbox column by returning the Checkbox widget for specific column which requires the Checkbox operation in DataGridSource.buildRow method.

## STEP 1: 

Create data source class extends with DataGridSource for mapping data to the SfDataGrid.  To update the underlying value of cell, use the Checkbox widget’s onChanged method. Then, call notifyDataSourceListeners() after updating the checkbox state value into a collection.

```xml
class ProductDataSource extends DataGridSource {
  ProductDataSource({required this.employeeData}) {
    updateDataGridRow();
  }

  void updateDataGridRow() {
    _dataGridRow = employeeData
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<int>(columnName: 'id', value: e.id),
              DataGridCell<String>(columnName: 'product', value: e.product),
              DataGridCell<int>(columnName: 'price', value: e.price),
              DataGridCell(columnName: 'isAvailable', value: e.isAvailable)
            ]))
        .toList();
  }

  List<DataGridRow> _dataGridRow = [];
  List<Product> employeeData = [];

  @override
  List<DataGridRow> get rows => _dataGridRow;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(cells: [
      Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Text(row.getCells()[0].value.toString()),
      ),
      Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Text(row.getCells()[1].value),
      ),
      Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Text(row.getCells()[2].value.toString()),
      ),
      Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Checkbox(
            value: row.getCells()[3].value,
            onChanged: (value) {
              final index = _dataGridRow.indexOf(row);
              employeeData[index].isAvailable = value!;
              row.getCells()[3] =
                  DataGridCell(value: value, columnName: 'isAvailable');
              notifyDataSourceListeners(
                  rowColumnIndex: RowColumnIndex(index, 3));
             },
          ))
    ]);
  }
}
```

## STEP 2: 

Initialize the SfDataGrid with all the required properties.

```xml
@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Syncfusion Flutter DataGrid'),
      ),
      body: SfDataGrid(
        source: productDataSource,
        columns: <GridColumn>[
          GridTextColumn(
              columnName: 'id',
              width: 80,
              label: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  alignment: Alignment.center,
                  child: Text(
                    'ID',
                  ))),
          GridTextColumn(
              columnName: 'product',
              width: 120,
              label: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  alignment: Alignment.center,
                  child: Text('Product'))),
          GridTextColumn(
              columnName: 'price',
              width: 75,
              label: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  alignment: Alignment.center,
                  child: Text('Price'))),
          GridTextColumn(
              columnName: 'isAvailble',
              width: 150,
              label: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                alignment: Alignment.center,
                child: Text('Is Available'),
              ))
        ],
      ),
    );
  }
```

<img alt="Show check box column to flutter DataTable "  src="https://www.syncfusion.com/uploads/user/kb/flut/flut-4715/flut-4715_img1.png" width="300" height="400" />
 
**[View document in Syncfusion Flutter Knowledge base](https://www.syncfusion.com/kb/12636/how-to-show-checkbox-column-in-flutter-datatable-sfdatagrid)**