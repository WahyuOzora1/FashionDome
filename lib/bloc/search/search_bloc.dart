import 'package:fashiondome/data/datasource/product_remote_datasource.dart';
import 'package:fashiondome/data/models/response/list_product_response_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'search_event.dart';
part 'search_state.dart';
part 'search_bloc.freezed.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final ProductRemoteDatasource datasource;
  SearchBloc(
    this.datasource,
  ) : super(const _Initial()) {
    on<_Search>((event, emit) async {
      emit(const _Loading());
      final result = await datasource.search(event.name);
      result.fold(
        (l) => emit(const _Error()),
        (r) => emit(_Loaded(r)),
      );
    });
  }
}
