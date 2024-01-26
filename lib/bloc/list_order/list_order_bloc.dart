import 'package:fashiondome/data/datasource/order_remote_datasource.dart';
import 'package:fashiondome/data/models/response/list_order_response_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'list_order_event.dart';
part 'list_order_state.dart';
part 'list_order_bloc.freezed.dart';

class ListOrderBloc extends Bloc<ListOrderEvent, ListOrderState> {
  final OrderRemoteDatasource datasource;
  ListOrderBloc(
    this.datasource,
  ) : super(const _Initial()) {
    on<_Get>((event, emit) async {
      emit(const _Loading());
      final result = await datasource.listOrder();
      result.fold(
        (l) => emit(const _Error()),
        (r) => emit(_Loaded(r)),
      );
    });
  }
}
