import 'package:food_xyz_project/repositories.dart';

class BrowseViewModel extends ViewModel {
  final searchController = TextEditingController();
  //seluruh produk akan disimpan di variabel dibawah
  List<ProdukModel> masterData = [];

  final tokenStorage = const FlutterSecureStorage();
  late ApiProvider apiCall;

  //filter
  int selectedFoodCategory = 0;
  Map<String, String> foodCategory = {
    'Main Course': 'main_courses',
    'Drinks': 'drinks',
    'Desserts': 'desserts',
    'Snacks': 'snacks',
  };

    Map<String, String> foodCategoryImage = {
    'Main Course': 'assets/images/roasted_chicken.png',
    'Drinks': 'assets/images/water.png',
    'Desserts': 'assets/images/cake.png',
    'Snacks': 'assets/images/nuggets.png',
  };

  //untuk effect carousel filter produk
  PageController pageController = PageController(viewportFraction: 0.85);

  //controller disini dibuat agar setiap jumlah item dipilih di ListView bisa diubah
  List<TextEditingController> controllers = [];

  //ketimbang mengambil produk langsung dari master data, variabel ini dibuat untuk mengambil produk yang sesuai dengan pencarian
  List<ProdukModel> _filteredData = [];
  List<ProdukModel> get filteredData => _filteredData;

  set filteredData(List<ProdukModel> value) {
    _filteredData = value;
    controllers = List.generate(
        _filteredData.length, (index) => TextEditingController(text: '0'));
    notifyListeners();
  }

  String getNamaProduk(int index) => _filteredData[index].namaProduk;
  String getRatingProduk(int index) => _filteredData[index].rating.toString();
  String getHargaProduk(int index) =>
      intToRupiah(_filteredData[index].hargaProduk);
  String getFotoProduk(int index) => _filteredData[index].fotoProduk;

  String getIdProduk(int index) => _filteredData[index].idProduk;

  final List<CartModel> _cart = [];
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
  Timer? _debounceTimerChangeFilter;
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
  }

  Future<void> getMasterData() async {
    try {
      isBusy = true;
      final token = await tokenStorage.read(key: 'accessToken');
      if (token == null) {
        throw AppError.tokenNotFound;
      }

      if (masterData.isNotEmpty) {
        masterData.removeRange(0, masterData.length);
      }

      final result = await apiCall.getProduk(token);
      for (var n = 0; n < result.length; n++) {
        masterData.add(ProdukModel.fromJson(result[n]));
      }

      filterProduk(selectedFoodCategory);
    } catch (e) {
      errorHandler(e);
    } finally {
      isBusy = false;
    }
  }

  void onPageChange(int currentPage) {
    if (_debounceTimerChangeFilter != null &&
        _debounceTimerChangeFilter!.isActive) {
      _debounceTimerChangeFilter!.cancel();
    }

    _debounceTimerChangeFilter = Timer(
        const Duration(milliseconds: 900), () => filterProduk(currentPage));
  }

  void onSearchKeywordChanged(String value) {
    if (_debounceTimerSearch != null && _debounceTimerSearch!.isActive) {
      _debounceTimerSearch!.cancel();
    }

    _debounceTimerSearch = Timer(const Duration(milliseconds: 500),
        () => filterProduk(selectedFoodCategory));
  }

  void filterProduk(int currentPage) {
    String namaKategori = foodCategory.keys.elementAt(currentPage);
    String searchValue = searchController.text.toLowerCase();
    List<ProdukModel> temp = masterData
        .where((element) =>
            element.jenis == foodCategory[namaKategori] &&
            (searchValue.isEmpty ||
                element.namaProduk.toLowerCase().contains(searchValue)))
        .toList();

    selectedFoodCategory = currentPage;
    filteredData = temp;
  }

  void onTambahJumlahProduk(TextEditingController controller) {
    if (controller.text.isNotEmpty) {
      int qty = int.parse(controller.text);
      qty++;
      controller.text = qty.toString();
    }
  }

  void onJumlahProdukDikurang(String itemId, TextEditingController controller) {
    if (controller.text.isNotEmpty) {
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
  }

  void countTotal() {
    int total = 0;
    for (var element in cart) {
      total += element.produk.hargaProduk * element.qty;
    }
    this.total = total;
  }

  void totalItemFocusChange(bool hasFocus, TextEditingController controller) {
    hasFocus == true  
      ? { if (controller.text == '0') controller.text = '';}
      : { if (controller.text.isBlank ?? false) controller.text = '0';}
    }
  }

  void addToCart(String itemId, TextEditingController controller) {
    if (controller.text.isNotEmpty && controller.text != '0') {
      ProdukModel? itemToAdded =
          masterData.firstWhereOrNull((element) => element.idProduk == itemId);

      CartModel? currentItemOnCart = cart.firstWhereOrNull(
          (element) => element.produk.idProduk == itemToAdded?.idProduk);

      if (itemToAdded != null) {
        if (currentItemOnCart != null) {
          currentItemOnCart.qty += int.parse(controller.text);

          if (currentItemOnCart.qty <= 0) {
            cart.removeWhere((element) =>
                element.produk.idProduk == currentItemOnCart.produk.idProduk);
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
