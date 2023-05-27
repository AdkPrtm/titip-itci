import 'package:bloc/bloc.dart';
import 'package:titip_itci/models/models.dart';
import 'package:titip_itci/service/service.dart';

part 'resi_event.dart';
part 'resi_state.dart';

class ResiBloc extends Bloc<ResiEvent, ResiState> {
  ResiBloc() : super(ResiInitial()) {
    on<ResiBelumDiTerimaFetch>((event, emit) async {
      emit(await _mapResiBelumDiTerimaFetchedToState(state));
    });

    on<ResiBelumDiTerimaRefresh>((event, emit) async {
      emit(ResiInitial());
      emit(await _mapResiBelumDiTerimaFetchedToState(state));
    });

    on<ResiSudahDiTerimaFetch>((event, emit) async {
      emit(await _mapResiSudahDiTerimaFetchedToState(state));
    });

    on<ResiSudahDiTerimaRefresh>((event, emit) async {
      emit(ResiInitial());
      emit(await _mapResiSudahDiTerimaFetchedToState(state));
    });

    on<LoadResiEvent>((event, emit) async {
      emit(ResiLoading());
      ResultServiceResi resiModel = await ResiService().getResi(page: 1);
      List<String> profit = await ResiService().getProfit(
          tipe: event.tipe!,
          month: DateTime.now().month,
          year: DateTime.now().year);
      if (resiModel.resiModel != null && profit.isNotEmpty) {
        emit(GetResiSuccess(
            resiModel: resiModel.resiModel,
            profit: profit[0],
            jumlahPaket: profit[1]));
      } else {
        emit(ResiFailedCRUD(msg: resiModel.msg));
      }
    });

    on<InputResiEvent>((event, emit) async {
      emit(ResiLoading());
      ResultServiceResi resiModel = await ResiService().inputResi(
          nama: event.nama,
          resi: event.resi,
          posisi: event.posisi,
          status: event.status,
          pembayaran: event.pembayaran,
          hargaCod: event.hargaCod);
      emit(ResiFailedCRUD(msg: resiModel.msg));
    });

    on<EditPosisiResiEvent>((event, emit) async {
      emit(ResiLoading());
      String result = await ResiService()
          .updatePosisiResi(resi: event.resi, posisi: event.posisi);
      if (result == 'Data telah terupdate') {
        emit(ResiFailedCRUD(msg: result));
      } else {
        emit(ResiFailedCRUD(msg: result));
      }
    });

    on<EditPengambilanResiEvent>((event, emit) async {
      emit(ResiLoading());
      String result = await ResiService().updateStatusResi(
          resi: event.resi,
          status: event.status,
          hargaCod: event.hargaCod,
          fee: event.fee);
      if (result == 'Data telah terupdate') {
        emit(ResiFailedCRUD(msg: result));
      } else {
        emit(ResiFailedCRUD(msg: result));
      }
    });

    on<DeleteResiEvent>((event, emit) async {
      emit(ResiLoading());
      String result = await ResiService().deleteResi(event.resi);
      if (result == 'Data Berhasil dihapus') {
        emit(ResiFailedCRUD(msg: result));
      } else {
        emit(ResiFailedCRUD(msg: result));
      }
    });

    on<SearchResiEvent>((event, emit) async {
      emit(ResiLoading());
      ResultServiceResi resiModel =
          await ResiService().searchResi(resi: event.resi);
      if (resiModel.satuResi != null) {
        emit(SearchResiSuccess(resiModel: resiModel.satuResi));
      } else {
        emit(ResiFailedCRUD(msg: resiModel.msg));
      }
    });
  }

  Future<ResiState> _mapResiBelumDiTerimaFetchedToState(ResiState state) async {
    List<ResiModel>? resiItems;
    try {
      if (state is ResiInitial) {
        final items =
            await ResiService().getResi(page: 1, status: 'Belum diambil');
        if (items.resiModel != null) {
          resiItems = items.resiModel!;
          return ResiBelumDiTerimaLoaded(items: resiItems, hasReachedMax: true);
        }
      }
      ResiBelumDiTerimaLoaded resiLoaded = state as ResiBelumDiTerimaLoaded;
      final items = await ResiService()
          .getResi(page: resiLoaded.page, status: 'Belum diambil');
      if (items.resiModel != null) {
        resiItems = items.resiModel!;
      }
      return resiItems!.isEmpty
          ? resiLoaded.copyWith(hasReachedMax: true)
          : resiLoaded.copyWith(item: resiLoaded.items + resiItems);
    } on Exception {
      return ResiFailedCRUD();
    }
  }

  Future<ResiState> _mapResiSudahDiTerimaFetchedToState(ResiState state) async {
    List<ResiModel>? resiItems;
    try {
      if (state is ResiInitial) {
        final items =
            await ResiService().getResi(page: 1, status: 'Sudah diambil');
        if (items.resiModel != null) {
          resiItems = items.resiModel!;
          return ResiSudahDiTerimaLoaded(items: resiItems, hasReachedMax: true);
        }
      }
      ResiSudahDiTerimaLoaded resiLoaded = state as ResiSudahDiTerimaLoaded;
      final items = await ResiService()
          .getResi(page: resiLoaded.page, status: 'Sudah diambil');
      if (items.resiModel != null) {
        resiItems = items.resiModel!;
      }
      return resiItems!.isEmpty
          ? resiLoaded.copyWith(hasReachedMax: true)
          : resiLoaded.copyWith(item: resiLoaded.items + resiItems);
    } on Exception {
      return ResiFailedCRUD();
    }
  }
}
