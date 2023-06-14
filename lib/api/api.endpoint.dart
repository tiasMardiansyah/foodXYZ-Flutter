class ApiEndPoint {
  //untuk sementara
  //static const String login = 'http://192.168.18.25/user/login';
  //static const String daftar = 'http://192.168.18.25/user/register';
  //static const String produk = 'http://192.168.18.25/products';

  static const String login = '/user/login';
  static const String daftar = '/user/register';
  static const String profile = '/user/profile';
  static const String produk = '/products';

  static const String logTransaksi = '/invoices';
  static String getLogTransaksi({required String id}) => "/invoices/$id";
}
