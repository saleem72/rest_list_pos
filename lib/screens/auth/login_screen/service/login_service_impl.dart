//

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import '../../../../helpers/constants.dart';
import '../../../../models/apis_related/api_reponse.dart';
import '../../../../models/failure.dart';
import '../models/login_data.dart';
import 'login_service.dart';

class LoginServiceImpl implements LoginService {
  @override
  Future<Either<Failure, LoginData>> login(
      {required String email, required String password}) async {
    final client = http.Client();
    final uri = Uri.parse('${Constants.baseURL}restaurant/login');
    final data = {
      "email": email,
      "password": password,
    };

    try {
      final response = await client.post(uri, body: data);
      var jsonResponse =
          convert.jsonDecode(response.body) as Map<String, dynamic>;
      final BaseResponse<LoginData> baseResponse = BaseResponse.fromMap(
        jsonResponse,
        (data) => LoginData.fromMap(data),
      );
      return baseResponse.result();
    } catch (ex) {
      return left(Failure(message: ex.toString()));
    }
  }
}
