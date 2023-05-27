part of 'infinite_list_bloc.dart';

// TRIAL INFITE LIST
enum ResiStatus { initial, success, failed, empty }

class InfiniteListState {
  final int page;
  final bool hasReachedMax;
  final List<ResiModel> resiItems;
  final ResiStatus status;

  int get count => resiItems.length;
  int get nextPage => page + 1;

  ResiModel item(int index) => resiItems[index];
  List<ResiModel> belumDiTerima({String? keyword}) {
    if (keyword == null) {
      return resiItems.where((element) => element.status == 'Belum diambil').toList();
    } else {
      return resiItems
          .where((element) => element.resi.contains(keyword.toUpperCase()))
          .where((element) => element.status == 'Belum diambil')
          .toList();
    }
  }

  InfiniteListState({
    this.page = 1,
    this.resiItems = const [],
    this.hasReachedMax = false,
    this.status = ResiStatus.initial,
  });

  InfiniteListState failed() => copyWith(status: ResiStatus.failed);
  InfiniteListState empty() =>
      copyWith(status: ResiStatus.empty, hasReachedMax: true);
  InfiniteListState reachedMax() => copyWith(hasReachedMax: true);

  InfiniteListState append(List<ResiModel> items) => copyWith(
        status: ResiStatus.success,
        resiItems: [...this.resiItems, ...items],
        page: nextPage,
        hasReachedMax: false,
      );

  InfiniteListState replace(List<ResiModel> items) => copyWith(
        status: ResiStatus.success,
        resiItems: items,
        page: 2,
        hasReachedMax: false,
      );

  InfiniteListState copyWith({
    ResiStatus? status,
    List<ResiModel>? resiItems,
    int? page,
    bool? hasReachedMax,
  }) {
    return InfiniteListState(
      status: status ?? this.status,
      resiItems: resiItems ?? this.resiItems,
      page: page ?? this.page,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }
}
