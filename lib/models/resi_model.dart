part of 'models.dart';

class ResiModel {
  final String id, nama, resi, posisi, status, pembayaran;
  final String hargaCod, fee, totalHarga;
  final DateTime createdAt, updateAt;

  ResiModel({
    required this.id,
    required this.nama,
    required this.resi,
    required this.posisi,
    required this.status,
    required this.pembayaran,
    required this.hargaCod,
    required this.fee,
    required this.totalHarga,
    required this.createdAt,
    required this.updateAt,
  });

  factory ResiModel.fromJson(Map<String, dynamic> json) => ResiModel(
        id: json['id'],
        nama: json['nama'],
        resi: json['resi'],
        posisi: json['posisi'],
        status: json['status'],
        pembayaran: json['pembayaran'],
        hargaCod: json['harga_cod'],
        fee: json['fee'],
        totalHarga: json['total_harga'],
        createdAt: DateTime.parse(json['createdAt']),
        updateAt: DateTime.parse(json['updateAt']),
      );

  Map<String, dynamic> json() {
    return {
      'nama': this.nama,
      'resi': this.resi,
      'posisi': this.posisi,
      'status': this.status,
      'pembayaran': this.pembayaran,
      'harga_cod': this.hargaCod,
      'fee': this.fee,
      'total_harga': this.totalHarga,
      'createdAt': this.createdAt,
      'updateAt': this.updateAt,
    };
  }
}
