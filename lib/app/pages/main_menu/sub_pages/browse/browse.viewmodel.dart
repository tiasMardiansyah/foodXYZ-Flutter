import 'package:food_xyz_project/repositories.dart';

class BrowseViewModel extends ViewModel {
  final searchController = TextEditingController();

  List<ProdukModel> masterData = DummyMasterData().dummyData;

  List<TextEditingController> controllers = [];

  //untuk menampilkan data, untuk update akan langsung ke masterData
  List<ProdukModel> _filteredData = [];
  List<ProdukModel> get filteredData => _filteredData;
  set filteredData(List<ProdukModel> value) {
    _filteredData = value;
    controllers = List.generate(
      filteredData.length,
      (index) => TextEditingController(
        text: '0',
      ),
    );
    notifyListeners();
  }

  List<Cart> _cart = [];
  List<Cart> get cart => _cart;

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

  void onTambahJumlahProduk(TextEditingController controller) {
    int qty = int.parse(controller.text);
    qty++;
    controller.text = qty.toString();
  }

  void onJumlahProdukDikurang(String itemId, TextEditingController controller) {
    int qty = int.parse(controller.text);
    Cart? itemToUpdate =
        cart.firstWhereOrNull((element) => element.produk.idProduk == itemId);

    if (itemToUpdate != null) {
      if (qty <= 0 && (-qty) >= itemToUpdate.qty) {
        return; //kembali apabila qty di list menu melebihi jumlah qty di keranjang
      }
    } else if (qty <= 0) {
      return; // kemabli apabila qty di list menu 0
    }

    qty--;
    controller.text = qty.toString();
  }

  void getProdukName(int) {

  }

  void countTotal() {
    int total = 0;
    cart.forEach((element) {
      total += element.produk.hargaProduk * element.qty;
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
        List<ProdukModel> temp = [];
        for (var element in masterData) {
          if (element.namaProduk.toLowerCase().contains(searchValue)) {
            temp.add(element);
          }
        }

        filteredData = temp;
      },
    );
  }

  void addToCart(String itemId, TextEditingController controller) {
    if (controller.text != '0') {
      ProdukModel? itemToAdded =
          masterData.firstWhereOrNull((element) => element.idProduk == itemId);

      Cart? currentItemOnCart =
          cart.firstWhereOrNull((element) => element.produk == itemToAdded);

      if (itemToAdded != null) {
        if (currentItemOnCart != null) {
          currentItemOnCart.qty += int.parse(controller.text);

          if (currentItemOnCart.qty == 0) {
            cart.remove(currentItemOnCart);
          }
        } else {
          cart.add(Cart(itemToAdded, int.parse(controller.text)));
        }

        //lakukan penghitungan keseluruhan
        countTotal();
        controller.text = '0';
        Get.snackbar('Notifikasi keranjang', 'Produk Berhasil Di masukkan');
      }
    }
  }

  String convertToRupiah(int value) {
    var format = NumberFormat.currency(locale: 'id_IDR', symbol: 'Rp');
    return format.format(value);
  }

  String getItemQty(String itemId) {
    Cart? currentItemOnCart =
        cart.firstWhereOrNull((element) => element.produk.idProduk == itemId);

    if (currentItemOnCart != null && currentItemOnCart.qty > 0) {
      String quantity = currentItemOnCart.qty.toString();
      return 'Dikeranjang : $quantity';
    }
    return '';
  }

  void goToInvoice() {
    if (_total > 0) {
      Get.toNamed(Routes.invoice);
    } else {
      Get.snackbar(
        "Tidak Bisa Ke Invoice",
        'Total transaksi masih kosong, coba tambah Produk',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
