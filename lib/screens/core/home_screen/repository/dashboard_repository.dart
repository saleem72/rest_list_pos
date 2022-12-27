//

import 'package:dartz/dartz.dart';
import 'package:rest_list_pos/models/product_category.dart';
import 'package:rest_list_pos/models/tax.dart';

import '../../../../models/app_user/app_user.dart';
import '../../../../models/failure.dart';
import '../../../../models/order.dart';
import '../../../../models/restaurant_table.dart';
import '../../../../models/waiter.dart';
import '../../../../models/requests_bodies/get_product_body.dart';
import '../../../../models/product.dart';
import '../service/dashboard_service.dart';

abstract class DashboardRepository {
  DashboardService get service;
  AppUser? get data;

  Future<Either<Failure, AppUser>> getData();
  Future<Either<Failure, List<ProductCategory>>> getCategories(
      int restaurantId);
  Future<Either<Failure, ProductsList>> getProduct(GetProductBody model);
  setUser(AppUser user);

  Future<Either<Failure, TablesList>> getTables(int restaurantId);
  Future<Either<Failure, WaitersList>> getWaiters(int restaurantId);
  Future<Either<Failure, OredersList>> getOrders(int restaurantId);
  Future<Either<Failure, List<Tax>>> getTaxes(int resturantId);
}

class DashboardRepositoryImpl implements DashboardRepository {
  DashboardRepositoryImpl({required this.service});

  @override
  AppUser? data;
  @override
  final DashboardService service;

  Failure? failure;
  bool isGettingData = false;
  bool dataHasBeenFetched = false;

  @override
  setUser(AppUser user) {
    data = user;
    dataHasBeenFetched = true;
  }

  @override
  Future<Either<Failure, AppUser>> getData() async {
    if (!dataHasBeenFetched) {
      isGettingData = true;
      final result = await service.getData();
      result.fold(
        (failure) => _handleFailure(failure),
        (getUserData) => _handleReturnedData(getUserData),
      );
      return result;
    } else {
      if (data != null) {
        return Right(data!);
      } else {
        return Left(failure ?? const Failure(message: 'unKnown Error'));
      }
    }
  }

  _handleReturnedData(AppUser returnedData) {
    data = returnedData;
    dataHasBeenFetched = true;
    isGettingData = false;
  }

  _handleFailure(Failure returnedFailure) {
    failure = returnedFailure;
  }

  @override
  Future<Either<Failure, List<ProductCategory>>> getCategories(
      int restaurantId) async {
    final result = service.getCategories(restaurantId);
    return result;
  }

  @override
  Future<Either<Failure, ProductsList>> getProduct(GetProductBody model) {
    final result = service.getProduct(model);
    return result;
  }

  @override
  Future<Either<Failure, TablesList>> getTables(int restaurantId) async {
    final tablesResult = await service.getTables(restaurantId);
    return tablesResult;
  }

  @override
  Future<Either<Failure, WaitersList>> getWaiters(int restaurantId) async {
    final waitersResult = await service.getWaiters(restaurantId);
    return waitersResult;
  }

  @override
  Future<Either<Failure, OredersList>> getOrders(int restaurantId) async {
    final orderssResult = await service.getOrders(restaurantId);
    return orderssResult;
  }

  @override
  Future<Either<Failure, List<Tax>>> getTaxes(int resturantId) async {
    final result = await service.getTaxes(resturantId);
    return result;
  }
}
