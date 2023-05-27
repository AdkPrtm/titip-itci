import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:titip_itci/models/models.dart';
import 'package:titip_itci/service/service.dart';
import 'package:rxdart/rxdart.dart';

part 'infinite_list_event.dart';
part 'infinite_list_state.dart';

class InfiniteListBloc extends Bloc<InfiniteListEvent, InfiniteListState> {
  InfiniteListBloc() : super(InfiniteListState()) {
    on<ResiFetched>((event, emit) async {
      emit(await _mapResiFetchedToState(state));
    });

    on<ResiRefreshed>((event, emit) async {
      emit(await _mapResiRefreshedToState(state));
    });
  }

  //TRIAL INFITE LIST
  ItemScrollController itemScrollController = ItemScrollController();
  ItemPositionsListener itemPositionsListener = ItemPositionsListener.create();

  void init() {
    add(ResiFetched());
    trigger();
  }

  void scrollToTop() {
    itemScrollController.scrollTo(
      index: 0,
      duration: Duration(milliseconds: 300),
    );
  }

  void trigger() {
    itemPositionsListener.itemPositions.addListener(() {
      final pos = itemPositionsListener.itemPositions.value;
      final lastIndex = state.count - 1;

      final isAtBottom = pos.last.index == lastIndex;
      final isLoadMore = isAtBottom && !state.hasReachedMax;

      // load data from the next page
      if (isLoadMore) {
        add(ResiFetched());
      }
    });
  }

  Future<void> refresh() async {
    add(ResiRefreshed());
  }

  EventTransformer<ResiEvent> throttle<ResiEvent>() {
    return (events, mapper) =>
        events.throttleTime(Duration(milliseconds: 100)).flatMap(mapper);
  }

  Future<InfiniteListState> _mapResiFetchedToState(
      InfiniteListState state) async {
    if (state.hasReachedMax) {
      return state;
    }

    final items = await ResiService().getResi(page: state.page);

    if (items.resiModel == null) {
      if (state.status == ResiStatus.initial) {
        return state.failed();
      } else {
        return state;
      }
    }

    if (items.resiModel!.isEmpty) {
      if (state.status == ResiStatus.initial) {
        return state.empty();
      } else {
        return state.reachedMax();
      }
    }

    return state.append(items.resiModel!);
  }

  Future<InfiniteListState> _mapResiRefreshedToState(
      InfiniteListState state) async {
    final items = await ResiService().getResi(page: 1);

    if (items.resiModel == null) {
      return state;
    }
    return state.replace(items.resiModel!.toList());
  }
}
