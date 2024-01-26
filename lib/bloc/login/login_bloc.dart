import 'package:fashiondome/data/datasource/auth_remote_datasource.dart';
import 'package:fashiondome/data/models/request/login_request_model.dart';
import 'package:fashiondome/data/models/response/auth_response_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRemoteDatasource datasource;
  LoginBloc(
    this.datasource,
  ) : super(LoginInitial()) {
    on<DoLoginEvent>((event, emit) async {
      emit(LoginLoading());
      final result = await datasource.login(event.model);
      result.fold(
        (l) => emit(LoginError()),
        (r) => emit(LoginLoaded(model: r)),
      );
    });
  }
}
