part of 'resi_bloc.dart';

abstract class ResiEvent {}

class LoadResiEvent extends ResiEvent {
  String? tipe;
  LoadResiEvent({this.tipe = 'Bersih'});
}

class InputResiEvent extends ResiEvent {
  final String nama, resi, posisi, status, pembayaran, hargaCod;

  InputResiEvent({
    required this.nama,
    required this.resi,
    required this.posisi,
    required this.status,
    required this.pembayaran,
    required this.hargaCod,
  });
}

class EditPosisiResiEvent extends ResiEvent {
  final String resi, posisi;

  EditPosisiResiEvent({required this.resi, required this.posisi});
}

class EditPengambilanResiEvent extends ResiEvent {
  final String resi, status;
  final int hargaCod, fee;

  EditPengambilanResiEvent({
    required this.resi,
    required this.status,
    required this.hargaCod,
    required this.fee,
  });
}

class DeleteResiEvent extends ResiEvent {
  final String resi;

  DeleteResiEvent({required this.resi});
}

class SearchResiEvent extends ResiEvent {
  final String resi;

  SearchResiEvent({required this.resi});
}

class ResiBelumDiTerimaRefresh extends ResiEvent {}

class ResiBelumDiTerimaFetch extends ResiEvent {}

class ResiSudahDiTerimaRefresh extends ResiEvent {}

class ResiSudahDiTerimaFetch extends ResiEvent {}