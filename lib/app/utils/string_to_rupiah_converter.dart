import 'package:food_xyz_project/repositories.dart';

String intToRupiah(int value) {
  var format = NumberFormat.currency(locale: 'id_IDR', symbol: 'Rp');
  return format.format(value);
}
