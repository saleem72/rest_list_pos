// ignore_for_file: public_member_api_docs, sort_constructors_first
//

import 'package:dartz/dartz.dart';
import 'package:rest_list_pos/models/apis_related/api_reponse.dart';
import 'package:rest_list_pos/models/order.dart';
import 'package:rest_list_pos/models/restaurant_table.dart';
import 'package:rest_list_pos/models/tax.dart';
import 'package:rest_list_pos/models/waiter.dart';

import '../../../../helpers/jsons.dart';
import '../../../../models/app_user/app_user.dart';
import '../../../../models/failure.dart';
import '../../../../models/product.dart';
import '../../../../models/product_category.dart';
import '../../../../models/requests_bodies/get_product_body.dart';
import 'dashboard_service.dart';

class DashboardServiceMock implements DashboardService {
  @override
  Future<Either<Failure, AppUser>> getData() async {
    await Future<void>.delayed(const Duration(seconds: 1));
    try {
      final jsonResponse = await JsonApiResponse.loadJsonData(
          JsonApiResponse.getUserSuccessResponse);
      final baseResponse = BaseResponse<AppUser>.fromMap(
          jsonResponse, (data) => AppUser.fromJson(data));

      return baseResponse.result();
      // final loginResponse = GetUserResponse.fromMap(jsonResponse);
      // final result = BaseService.handleResponse<AppUser>(loginResponse);
      // return result;

    } catch (ex) {
      return left(Failure(message: ex.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ProductCategory>>> getCategories(
      int restaurantId) async {
    await Future<void>.delayed(const Duration(seconds: 1));
    try {
      final jsonResponse = await JsonApiResponse.loadJsonData(
          JsonApiResponse.getCategoriesResponse);

      final BaseListResponse<ProductCategory> baseListResponse =
          BaseListResponse.fromMap(jsonResponse,
              (data) => data.map((e) => ProductCategory.fromJson(e)).toList());

      return baseListResponse.result();
    } catch (ex) {
      return left(Failure(message: ex.toString()));
    }
  }

  @override
  Future<Either<Failure, ProductsList>> getProduct(GetProductBody model) async {
    await Future<void>.delayed(const Duration(seconds: 1));
    try {
      final jsonResponse = await JsonApiResponse.loadJsonData(
          JsonApiResponse.getProductsResponse);

      final baseListResponse = BaseListResponse<Product>.fromMap(
        jsonResponse,
        (data) => data.map((e) => Product.fromJson(e)).toList(),
      );
      return baseListResponse.result();
    } catch (ex) {
      return left(Failure(message: ex.toString()));
    }
  }

  @override
  Future<Either<Failure, OredersList>> getOrders(int restaurantId) async {
    await Future<void>.delayed(const Duration(seconds: 3));
    try {
      final jsonResponse =
          await JsonApiResponse.loadJsonData(JsonApiResponse.getOrdersResponse);
      final baseListResponse = BaseListResponse<AppOrder>.fromMap(
        jsonResponse,
        (data) => data.map((e) => AppOrder.fromMap(e)).toList(),
      );
      return baseListResponse.result();
    } catch (ex) {
      return left(Failure(message: ex.toString()));
    }
  }

  @override
  Future<Either<Failure, TablesList>> getTables(int restaurantId) async {
    await Future<void>.delayed(const Duration(seconds: 2));
    try {
      final jsonResponse =
          await JsonApiResponse.loadJsonData(JsonApiResponse.getTablesResponse);

      final baseListResponse = BaseListResponse<RestaurantTable>.fromMap(
        jsonResponse,
        (data) => data.map((e) => RestaurantTable.fromMap(e)).toList(),
      );
      return baseListResponse.result();
    } catch (ex) {
      return left(Failure(message: ex.toString()));
    }
  }

  @override
  Future<Either<Failure, WaitersList>> getWaiters(int restaurantId) async {
    await Future<void>.delayed(const Duration(seconds: 1));
    try {
      final jsonResponse = await JsonApiResponse.loadJsonData(
          JsonApiResponse.getWaitersResponse);
      final baseListResponse = BaseListResponse<Waiter>.fromMap(
        jsonResponse,
        (data) => data.map((e) => Waiter.fromMap(e)).toList(),
      );
      return baseListResponse.result();
    } catch (ex) {
      return left(Failure(message: ex.toString()));
    }
  }

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
