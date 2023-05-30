import 'package:food_xyz_project/repositories.dart';

class BrowseViewModel extends ViewModel {
  final searchController = TextEditingController();

  List<Barang> masterData = [
    Barang('BR-1', 'Teh Jus', 20000, 4.5, 0),
    Barang('BR-2', 'Baso', 30000, 3.5, 0),
    Barang('BR-3', 'Nasi Goreng', 35000, 4.0, 0),
    Barang('BR-4', 'Ice Cream', 10000, 4.5, 0),
    Barang('BR-5', 'Daging Ayam', 20000, 4.2, 0),
    Barang('BR-6', 'Daging Sapi', 45000, 5.0, 0),
    Barang('BR-7', 'Daging Domba', 60000, 5.0, 0),
    Barang('BR-8', 'Susus Sapi', 15000, 5.0, 0),
    Barang('BR-9', 'Susu Kambing', 10000, 3.0, 0),
    Barang('BR-10', 'Susu Domba', 12500, 3.2, 0),
  ];

  //untuk menampilkan data, untuk update akan langsung ke masterData
  List<Barang> _filteredData = [];
  List<Barang> get filteredData => _filteredData;
  List<TextEditingController> controllers = [];

  set filteredData(List<Barang> value) {
    _filteredData = value;
    controllers = List.generate(
        filteredData.length,
        (index) => TextEditingController(
              text: filteredData[index].qty.toString(),
            ));
    notifyListeners();
  }

  int _total = 0;
  int get total => _total;
  set total(int value) {
    _total = value;
    notifyListeners();
  }

  Timer? _debounceTimerSearch;
  Timer? _debounceTimerItem;

  @override
  void dispose() {
    for (var controller in controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  void init() {
    //tampilkan seluruh menu pada awal tampilan menu browsing
    filteredData = masterData;
    countTotal();
  }

  void onTambahJumlahBarang(TextEditingController controller) {
    int qty = int.parse(controller.text);
    qty++;
    controller.text = qty.toString();
  }

  void onJumlahBarangDikurang(String itemId, TextEditingController controller) {
    int qty = int.parse(controller.text);
    Barang? itemToUpdate =
        masterData.firstWhereOrNull((element) => element.idBarang == itemId);

    if (itemToUpdate != null) {
      if (qty <= 0 && (-qty) >= itemToUpdate.qty) {
        return;
      } 

      qty--;
      controller.text = qty.toString();
    }
  }

  void countTotal() {
    int total = 0;
    masterData.forEach((element) {
      total += element.hargaBarang * element.qty;
    });
    this.total = total;
  }

  void onTotalItemKeywordChanged(
      String value, TextEditingController controller) {
    if (_debounceTimerItem?.isActive ?? false) {
      _debounceTimerItem?.cancel();
    }

    _debounceTimerItem = Timer(
      const Duration(milliseconds: 400),
      () {
        if (value.isBlank ?? false) {
          controller.text = '0';
        } else {
          controller.text = value;
          // update TextField
        }
      },
    );
  }

  void onSearchKeywordChanged(String value) {
    if (_debounceTimerSearch != null && _debounceTimerSearch!.isActive) {
      _debounceTimerSearch!.cancel();
    }

    _debounceTimerSearch = Timer(
      const Duration(milliseconds: 500),
      () {
        String searchValue = value.toLowerCase();
        List<Barang> temp = [];
        for (var element in masterData) {
          if (element.namaBarang.toLowerCase().contains(searchValue)) {
            temp.add(element);
          }
        }

        filteredData = temp;
      },
    );
  }

  void addToCart(String itemId, TextEditingController controller) {
    Barang? barangDiUpdate =
        masterData.firstWhereOrNull((element) => element.idBarang == itemId);

    if (barangDiUpdate != null) {
      //update quantitas barang di masterData
      barangDiUpdate.qty += int.parse(controller.text);

      //lakukan penghitungan keseluruhan
      countTotal();
      controller.text = '0';
      Get.snackbar('Notifikasi keranjang', 'barang Berhasil Di masukkan');
    }
  }

  String convertToRupiah(int value) {
    var format = NumberFormat.currency(locale: 'id_IDR', symbol: 'Rp');
    return format.format(value);
  }

  String getItemQty(String itemId) {
    Barang? searchedItem =
        masterData.firstWhereOrNull((element) => element.idBarang == itemId);

    if (searchedItem != null && searchedItem.qty > 0) {
      String quantity = searchedItem.qty.toString();
      return 'Dikeranjang : $quantity';
    }
    return '';
  }

  void goToInvoice() => Get.toNamed(Routes.invoice);
}
