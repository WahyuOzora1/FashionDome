import 'package:fashiondome/data/models/response/list_product_response_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'checkout_event.dart';
part 'checkout_state.dart';

class CheckoutBloc extends Bloc<CheckoutEvent, CheckoutState> {
  CheckoutBloc() : super(CheckoutLoaded(items: [])) {
    on<AddToCartEvent>((event, emit) {
      final currentState = state as CheckoutLoaded;

      emit(CheckoutLoading());
      emit(CheckoutLoaded(items: [...currentState.items, event.product]));
    });

    on<RemoveFromCartEvent>((event, emit) {
      final currentState = state as CheckoutLoaded;
      currentState.items.remove(event.product);
      emit(CheckoutLoading());
      emit(CheckoutLoaded(items: currentState.items));
    });
  }
}
