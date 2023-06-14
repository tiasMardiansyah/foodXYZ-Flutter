import 'package:food_xyz_project/repositories.dart';

class BrowseViewModel extends ViewModel {
  final searchController = TextEditingController();

  //seluruh produk akan disimpan di variabel dibawah
  List<ProdukModel> masterData = [];

  final tokenStorage = const FlutterSecureStorage();
  late ApiProvider apiCall;

  //controller disini dibuat agar setiap jumlah item dipilih di ListView bisa diubah
  List<TextEditingController> controllers = [];

  //ketimbang mengambil produk langsung dari master data, variabel ini dibuat untuk mengambil produk yang sesuai dengan pencarian
  List<ProdukModel> _filteredData = [];
  List<ProdukModel> get filteredData => _filteredData;
  set filteredData(List<ProdukModel> value) {
    _filteredData = value;
    controllers = List.generate(
        filteredData.length, (index) => TextEditingController(text: '0'));
    notifyListeners();
  }

  List<CartModel> _cart = [];
  List<CartModel> get cart => _cart;

  //total harga keseluruhan produk yang dipilih
  int _total = 0;
  int get total => _total;
  set total(int value) {
    _total = value;
    notifyListeners();
  }

  //flag untuk mengecek apakah aplikasi sedang sibuk, biasanya untuk mengambil data dan lain nya
  bool _isBusy = false;
  bool get isBusy => _isBusy;
  set isBusy(bool value) {
    _isBusy = value;
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
  void init() async {
    //ambil data dari luar terlebih dahulu
    apiCall = Get.find<ApiProvider>();
    await getMasterData();

    //tampilkan seluruh menu pada awal tampilan menu browsing
    filteredData = masterData;
    countTotal();
  }

  Future<void> getMasterData() async {
    try {
      isBusy = true;
      final token = await tokenStorage.read(key: 'accessToken');
      if (token == null) {
        final error = {
          'statusCode': 404,
          'statusText': 'Token tidak ditemukan'
        };
        throw error;
      }

      final result = await apiCall.getProduk(token);
      for (var n = 0; n < result.length; n++) {
        masterData.add(ProdukModel.fromJson(result[n]));
      }

    } catch (e) {
      if (e is Map<String, dynamic>) {
        switch (e['statusCode']) {
          case 401:
            {
              await showWarningDialog(
                title: 'Token sudah kadaluarsa',
                icon: Image.asset('assets/images/not_found.png'),
                texts: ['Harap login kembali'],
              );
              Get.offNamed(Routes.login);
            }
            break;

          case 404:
            {
              await showWarningDialog(
                title: 'Kredensial akun tidak ditemukan',
                icon: Image.asset('assets/images/not_found.png'),
                texts: ['Harap login kembali'],
              );
              Get.offNamed(Routes.login);
            }
            break;
        }
      } else {
        showWarningDialog(
          title: 'Error Besar',
          icon: Image.asset('assets/images/warning_sign.png'),
          texts: ['Hubungi developer apabila anda melihat pesan ini'],
        );
      }
    } finally {
      isBusy = false;
    }
  }

  void onTambahJumlahProduk(TextEditingController controller) {
    int qty = int.parse(controller.text);
    qty++;
    controller.text = qty.toString();
  }

  void onJumlahProdukDikurang(String itemId, TextEditingController controller) {
    int qty = int.parse(controller.text);

    //ambil produk di keranjang menggunakan id
    CartModel? itemToUpdate =
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

  void countTotal() {
    int total = 0;
    for (var element in cart) {
      total += element.produk.hargaProduk * element.qty;
    }
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

      CartModel? currentItemOnCart =
          cart.firstWhereOrNull((element) => element.produk == itemToAdded);

      if (itemToAdded != null) {
        if (currentItemOnCart != null) {
          currentItemOnCart.qty += int.parse(controller.text);

          if (currentItemOnCart.qty <= 0) {
            cart.remove(currentItemOnCart);
          }
        } else {
          cart.add(
            CartModel(
              itemToAdded,
              int.parse(controller.text),
            ),
          );
        }

        //lakukan penghitungan keseluruhan
        countTotal();
        controller.text = '0';
      }
    }
  }

  String getItemQty(String itemId) {
    CartModel? currentItemOnCart =
        cart.firstWhereOrNull((element) => element.produk.idProduk == itemId);

    if (currentItemOnCart != null && currentItemOnCart.qty > 0) {
      String quantity = currentItemOnCart.qty.toString();
      return 'Dikeranjang : $quantity';
    }
    return '';
  }

  void goToCart() async {
    if (cart.isNotEmpty) {
      //akan mengembalikan boolean yang akan di cek apabila pengguna berhasil menyimpan invoice
      final invoiceSaved = await Get.toNamed(
            Routes.cart,
            arguments: [cart, total],
          ) ??
          false;

      if (invoiceSaved) {
        final cartLen = cart.length;
        cart.removeRange(0, cartLen);
        _total = 0;
        notifyListeners();
      }
    } else {
      Get.snackbar(
        "Tidak Bisa Ke Invoice",
        'Total transaksi masih kosong, coba tambah Produk',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
