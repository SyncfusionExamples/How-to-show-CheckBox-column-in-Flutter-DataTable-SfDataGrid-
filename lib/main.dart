import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:syncfusion_flutter_core/theme.dart';

void main() {
  runApp(MyApp());
}

/// The application that contains datagrid on it.
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Syncfusion DataGrid Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MyHomePage(),
    );
  }
}

/// The home page of the application which hosts the datagrid.
class MyHomePage extends StatefulWidget {
  /// Creates the home page.
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late ProductDataSource productDataSource;
  List<Product> employees = <Product>[];

  @override
  void initState() {
    super.initState();
    employees = getEmployeeData();
    productDataSource = ProductDataSource(employeeData: employees);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Syncfusion Flutter DataGrid'),
      ),
      body: SfDataGrid(
        source: productDataSource,
        columns: <GridColumn>[
          GridColumn(
              columnName: 'id',
              width: 80,
              label: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  alignment: Alignment.center,
                  child: Text(
                    'ID',
                  ))),
          GridColumn(
              columnName: 'product',
              width: 120,
              label: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  alignment: Alignment.center,
                  child: Text('Product'))),
          GridColumn(
              columnName: 'price',
              width: 75,
              label: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  alignment: Alignment.center,
                  child: Text('Price'))),
          GridColumn(
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

  List<Product> getEmployeeData() {
    return [
      Product(10001, 'James', 'Syrub', 20000, true),
      Product(10002, 'Kathryn', 'Lax', 30000, true),
      Product(10003, 'Lara', 'Chocolate', 15000, false),
      Product(10004, 'Michael', 'Chai', 15000, true),
      Product(10005, 'Martin', 'Bags', 15000, false),
      Product(10006, 'Gable', 'Meats', 15000, false),
      Product(10007, 'Balnc', 'Cashew', 15000, true),
      Product(10008, 'Perry', 'Filo', 15000, false),
      Product(10009, 'Gable', 'Crab', 15000, true),
      Product(10010, 'Grimes', 'Gum', 15000, false),
      Product(10001, 'James', 'Nuts', 20000, false),
      Product(10002, 'Kathryn', 'Note Book', 30000, true),
      Product(10003, 'Lara', 'Cajun', 15000, false),
      Product(10004, 'Michael', 'Geitost', 15000, true),
      Product(10005, 'Martin', 'ChangCote de', 15000, false),
      Product(10006, 'Gable', 'Bags', 15000, true),
    ];
  }
}

/// Custom business object class which contains properties to hold the detailed
/// information about the employee which will be rendered in datagrid.
class Product {
  /// Creates the employee class with required details.
  Product(this.id, this.name, this.product, this.price, this.isAvailable);

  /// Id of an employee.
  final int id;

  /// Name of an employee.
  final String name;

  /// Designation of an employee.
  final String product;

  /// Salary of an employee.
  final int price;

  bool isAvailable;
}

/// An object to set the employee collection data source to the datagrid. This
/// is used to map the employee data to the datagrid widget.
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
