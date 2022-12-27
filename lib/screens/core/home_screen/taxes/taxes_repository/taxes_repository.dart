// ignore_for_file: public_member_api_docs, sort_constructors_first
//

import 'package:dartz/dartz.dart';

import 'package:rest_list_pos/screens/core/home_screen/taxes/taxes_service/taxes_service.dart';

import '../../../../../models/failure.dart';
import '../../../../../models/tax.dart';

abstract class TaxesRepository {
  Future<Either<Failure, List<Tax>>> getTaxes(int resturantId);
}

class TaxesRepositoryImpl implements TaxesRepository {
  final TaxesService service;

  TaxesRepositoryImpl({
    required this.service,
  });

  @override
  Future<Either<Failure, List<Tax>>> getTaxes(int resturantId) {
    return service.getTaxes(resturantId);
  }
}
