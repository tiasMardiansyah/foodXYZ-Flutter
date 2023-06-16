class ApiEndPoint {
  static const String login = '/user/login';
  static const String daftar = '/user/register';
  static const String profile = '/user/profile';
  static const String produk = '/products';

  static const String logTransaksi = '/invoices';
  static String getLogTransaksi({required String id}) => "/invoices/$id";
}
