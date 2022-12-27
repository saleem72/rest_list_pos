//

import 'package:dartz/dartz.dart';

import '../../../../../helpers/jsons.dart';
import '../../../../../models/apis_related/api_reponse.dart';
import '../../../../../models/failure.dart';
import '../../../../../models/tax.dart';
import 'taxes_service.dart';

class TaxesServiceMock implements TaxesService {
  @override
  Future<Either<Failure, List<Tax>>> getTaxes(int resturantId) async {
    await Future<void>.delayed(const Duration(seconds: 1));
    try {
      final jsonResponse =
          await JsonApiResponse.loadJsonData(JsonApiResponse.getTaxesResponse);
      final baseListResponse = BaseListResponse<Tax>.fromMap(
        jsonResponse,
        (data) => data.map((e) => Tax.fromMap(e)).toList(),
      );
      return baseListResponse.result();
    } catch (ex) {
      return left(Failure(message: ex.toString()));
    }
  }
}
