import 'package:dartz/dartz.dart';
import 'package:fashiondome/data/models/request/login_request_model.dart';
import 'package:fashiondome/data/models/request/register_request_model.dart';
import 'package:fashiondome/data/models/response/auth_response_model.dart';
import 'package:http/http.dart' as http;

import '../../common/global_variables.dart';

class AuthRemoteDatasource {
  Future<Either<String, AuthResponseModel>> login(
      LoginRequestModel model) async {
    final response = await http.post(
      Uri.parse('${GlobalVariables.baseUrl}/api/auth/local'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: model.toJson(),
    );

    if (response.statusCode == 200) {
      return Right(AuthResponseModel.fromRawJson(response.body));
    } else {
      return const Left('server error');
    }
  }

  Future<Either<String, AuthResponseModel>> register(
      RegisterRequestModel model) async {
    final response = await http.post(
      Uri.parse('${GlobalVariables.baseUrl}/api/auth/local/register'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: model.toJson(),
    );

    if (response.statusCode == 200) {
      return Right(AuthResponseModel.fromRawJson(response.body));
    } else {
      return const Left('server error');
    }
  }
}
