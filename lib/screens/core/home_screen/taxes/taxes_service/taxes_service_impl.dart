//

import 'package:dartz/dartz.dart';

import '../../../../../models/failure.dart';
import '../../../../../models/tax.dart';
import 'taxes_service.dart';

class TaxesServiceImpl implements TaxesService {
  @override
  Future<Either<Failure, List<Tax>>> getTaxes(int resturantId) async {
    return const Left(Failure(message: 'not implemented yet'));
  }
}
