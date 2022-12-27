//

import 'package:dartz/dartz.dart';

import '../../../../../models/failure.dart';
import '../../../../../models/tax.dart';

abstract class TaxesService {
  Future<Either<Failure, List<Tax>>> getTaxes(int resturantId);
}
