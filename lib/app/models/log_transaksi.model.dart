import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

@JsonSerializable()
class LogTransaksi {
  LogTransaksi({
    required this.invoiceId,
    required this.userId,
    required this.invoiceDetail,
    required this.totalBayar,
    required this.createdAt,
  });

  @JsonKey(name: 'invoice_id')
  final String invoiceId;

  @JsonKey(name: 'user_id')
  final String userId;

  @JsonKey(name: 'invoice_detail')
  final List<dynamic> invoiceDetail;

  @JsonKey(name: 'total_bayar')
  final int totalBayar;

  @JsonKey(name: 'created_at')
  final String createdAt;

  factory LogTransaksi.fromJson(Map<String, dynamic> jsonValue) {
    return LogTransaksi(
      invoiceId: jsonValue['invoice_id'] as String,
      userId: jsonValue['user_id'] as String,
      invoiceDetail: json.decode(jsonValue['invoice_detail']),
      totalBayar: int.parse(jsonValue['total_bayar']),
      createdAt: jsonValue['created_at'] as String,
    );
  }
}
