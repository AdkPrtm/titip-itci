part of 'resi_bloc.dart';

abstract class ResiState {}

class ResiInitial extends ResiState {}

class ResiBelumDiTerimaLoaded extends ResiState {
  final List<ResiModel> items;
  final bool hasReachedMax;
  final int page;

  int get nextPage => page + 1;

  ResiBelumDiTerimaLoaded({
    this.page = 2,
    this.items = const [],
    this.hasReachedMax = false,
  });

  ResiBelumDiTerimaLoaded copyWith({
    List<ResiModel>? item,
    bool? hasReachedMax,
    int? nextPage,
  }) {
    return ResiBelumDiTerimaLoaded(
        items: item ?? this.items,
        hasReachedMax: hasReachedMax ?? this.hasReachedMax,
        page: nextPage ?? this.nextPage);
  }
}

class ResiSudahDiTerimaLoaded extends ResiState {
  final List<ResiModel> items;
  final bool hasReachedMax;
  final int page;

  int get nextPage => page + 1;

  ResiSudahDiTerimaLoaded({
    this.page = 2,
    this.items = const [],
    this.hasReachedMax = false,
  });

  ResiSudahDiTerimaLoaded copyWith({
    List<ResiModel>? item,
    bool? hasReachedMax,
    int? nextPage,
  }) {
    return ResiSudahDiTerimaLoaded(
        items: item ?? this.items,
        hasReachedMax: hasReachedMax ?? this.hasReachedMax,
        page: nextPage ?? this.nextPage);
  }
}

class ResiLoading extends ResiState {}

class ResiFailedCRUD extends ResiState {
  final String? msg;
  ResiFailedCRUD({this.msg});
}

class ResiSuccessCRUD extends ResiState {
  final String? msg;
  ResiSuccessCRUD({this.msg});
}

class GetResiSuccess extends ResiState {
  final List<ResiModel>? resiModel;
  final String profit;
  final String jumlahPaket;
  GetResiSuccess({this.resiModel, required this.profit, required this.jumlahPaket});
}

class SearchResiSuccess extends ResiState {
  final ResiModel? resiModel;

  SearchResiSuccess({this.resiModel});
}
