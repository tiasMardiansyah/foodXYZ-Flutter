import 'package:food_xyz_project/repositories.dart';

class InvoiceViewModel extends ViewModel {
  void close() => Get.back();

  List<DataRow> createDummyData(int total) {
    List<DataRow> dummyData = [];

    for (int n = 0; n < total; n++) {
      dummyData.add(
        const DataRow(
          cells: <DataCell>[
            DataCell(Text("Test 1", softWrap: true,)),
            DataCell(Text("Test 2")),
            DataCell(Text("Test 3")),
            DataCell(Text("Test 4")),
          ],
        ),
      );
    }

    return dummyData;
  }

  void shareInvoice() {
    //TODO implementasi sharing invoice
  }

  void saveInvoice() {
    //TODO implementasi save invoice
  }
}
