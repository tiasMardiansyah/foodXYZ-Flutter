import 'package:food_xyz_project/repositories.dart';

class ProfileViewModel extends ViewModel {
  UserModel? _userProfile;
  set userProfile(UserModel value) {
    _userProfile = value;
    notifyListeners();
  }

  String getName() =>
      _userProfile == null ? 'Loading' : _userProfile!.namaLengkap;

  String getAddress() =>
      _userProfile == null ? 'Loading' : _userProfile!.alamat;

  String getPhone() =>
      _userProfile == null ? 'Loading' : _userProfile!.noTelepon;

  final tokenStorage = const FlutterSecureStorage();
  late ApiProvider apiCall;

  @override
  void init() async {
    apiCall = Get.find<ApiProvider>();
    await getUserProfile();
  }

  Future<void> getUserProfile() async {
    try {
      String? token = await tokenStorage.read(key: 'accessToken');
      if (token == null) {
        throw AppError.tokenNotFound;
      }
      userProfile = UserModel.fromJson(await apiCall.getProfile(token));
      notifyListeners();
    } catch (e) {
      errorHandler(e);
    }
  }

  Future<void> logout() async {
    bool userConfirmed = await showConfirmDialog(texts: ['Yakin ingin Logout']);
    if (userConfirmed) {
      await tokenStorage.delete(key: 'accessToken');
      await tokenStorage.delete(key: 'refreshToken');
      Get.offNamed(Routes.login);
    }
  }

  void goToLogTransaksi() => Get.toNamed(Routes.logTransaksi);
}
