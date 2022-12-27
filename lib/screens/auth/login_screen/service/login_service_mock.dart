//

import 'package:dartz/dartz.dart';
import 'package:rest_list_pos/models/apis_related/api_reponse.dart';

import '../../../../helpers/jsons.dart';
import '../../../../models/failure.dart';
import '../models/login_data.dart';
import 'login_service.dart';

class LoginServiceMock implements LoginService {
  @override
  Future<Either<Failure, LoginData>> login(
      {required String email, required String password}) async {
    await Future<void>.delayed(const Duration(seconds: 1));
    if (email == 'logical9447@gmail.com' && password == 'logical9447') {
      final jsonResponse = await JsonApiResponse.loadJsonData(
          JsonApiResponse.loginSuccessResponse);
      final BaseResponse<LoginData> baseResponse = BaseResponse.fromMap(
        jsonResponse,
        (data) => LoginData.fromMap(data),
      );
      return baseResponse.result();
    } else {
      return left(const Failure(message: 'invalid user name or password'));
    }
  }
}
