//

import 'package:dartz/dartz.dart';
import 'package:rest_list_pos/models/order.dart';
import 'package:rest_list_pos/models/product_category.dart';
import 'package:rest_list_pos/models/restaurant_table.dart';
import 'package:rest_list_pos/models/waiter.dart';

import '../../../../models/failure.dart';
import '../../../../models/requests_bodies/get_product_body.dart';
import '../../../../models/app_user/app_user.dart';
import '../../../../models/product.dart';
import '../../../../models/tax.dart';

abstract class DashboardService {
  Future<Either<Failure, AppUser>> getData();
  Future<Either<Failure, List<ProductCategory>>> getCategories(
      int restaurantId);
  Future<Either<Failure, ProductsList>> getProduct(GetProductBody model);
  Future<Either<Failure, TablesList>> getTables(int restaurantId);
  Future<Either<Failure, WaitersList>> getWaiters(int restaurantId);
  Future<Either<Failure, OredersList>> getOrders(int restaurantId);
  Future<Either<Failure, List<Tax>>> getTaxes(int resturantId);
}
