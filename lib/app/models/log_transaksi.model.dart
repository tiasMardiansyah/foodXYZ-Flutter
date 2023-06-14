import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

@JsonSerializable()
class LogTransaksiModel {

  LogTransaksiModel({
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

  factory LogTransaksiModel.fromJson(Map<String, dynamic> jsonValue) {
    return LogTransaksiModel(
      invoiceId: jsonValue['invoice_id'] as String,
      userId: jsonValue['user_id'] as String,
      invoiceDetail: json.decode(jsonValue['invoice_detail']),
      totalBayar: int.parse(jsonValue['total_bayar']),
      createdAt: jsonValue['created_at'] as String,
    );
  }
}
