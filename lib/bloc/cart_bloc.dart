import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:titip_itci/models/models.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitial()) {
    List<ResiModel> resiCart = [];
    on<AddToCart>((event, emit) {
      if (resiCart
              .where((element) => element.resi == event.resiModel.resi)
              .length <
          1) {
        resiCart.add(event.resiModel);
        emit(CartLoaded(resiModel: resiCart));
      } else {
        emit(CartLoaded(resiModel: resiCart));
      }
      // resiCart.add(event.resiModel);
      // emit(CartLoaded(resiModel: resiCart));
    });
    on<DeleteResiFromCart>((event, emit) {
      resiCart.remove(event.resiModel);
      emit(CartLoaded(resiModel: resiCart));
    });
    on<ClearCart>((event, emit) {
      resiCart = [];
      emit(CartLoaded(resiModel: resiCart));
    });
  }
}
