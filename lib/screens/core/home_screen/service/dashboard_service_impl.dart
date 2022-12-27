//

import 'dart:convert' as convert;

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:rest_list_pos/models/order.dart';
import 'package:rest_list_pos/models/restaurant_table.dart';
import 'package:rest_list_pos/models/tax.dart';
import 'package:rest_list_pos/models/waiter.dart';

import '../../../../helpers/constants.dart';
import '../../../../models/apis_related/api_reponse.dart';
import '../../../../models/apis_related/apis_headers.dart';
import '../../../../models/failure.dart';
import '../../../../models/product_category.dart';
import '../../../../models/requests_bodies/get_product_body.dart';
import '../../../../models/product.dart';
import '../../../../models/app_user/app_user.dart';
import 'dashboard_service.dart';

class DashboardServiceImpl implements DashboardService {
  @override
  Future<Either<Failure, AppUser>> getData() async {
    try {
      const url = '${Constants.baseURL}current-user';
      final uri = Uri.parse(url);
      final client = http.Client();
      final response = await client.get(uri, headers: ApisHeaders.authHeaders);
      var jsonResponse =
          convert.jsonDecode(response.body) as Map<String, dynamic>;
      final baseResponse = BaseResponse<AppUser>.fromMap(
        jsonResponse,
        (data) => AppUser.fromJson(data),
      );

      return baseResponse.result();
    } catch (ex) {
      return left(Failure(message: ex.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ProductCategory>>> getCategories(
      int restaurantId) async {
    try {
      const url = '${Constants.baseURL}restaurant/categories';
      final Map<String, dynamic> queryParameters = {
        "restaurant_id": restaurantId.toString()
      };
      final uri = Uri.parse(url).replace(queryParameters: queryParameters);
      final client = http.Client();
      final response = await client.get(uri, headers: ApisHeaders.authHeaders);

      var jsonResponse =
          convert.jsonDecode(response.body) as Map<String, dynamic>;
      final BaseListResponse<ProductCategory> baseListResponse =
          BaseListResponse.fromMap(
        jsonResponse,
        (data) => data.map((e) => ProductCategory.fromJson(e)).toList(),
      );

      return baseListResponse.result();
    } catch (ex) {
      return left(Failure(message: ex.toString()));
    }
  }

  @override
  Future<Either<Failure, ProductsList>> getProduct(GetProductBody model) async {
    try {
      const url = '${Constants.baseURL}restaurant/products';
      final Map<String, dynamic> queryParameters = model.toMap();
      final uri = Uri.parse(url).replace(queryParameters: queryParameters);
      final client = http.Client();
      final response = await client.get(uri, headers: ApisHeaders.authHeaders);

      var jsonResponse =
          convert.jsonDecode(response.body) as Map<String, dynamic>;
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
    return left(const Failure(message: 'Unimplemented yet'));
  }

  @override
  Future<Either<Failure, TablesList>> getTables(int restaurantId) async {
    return left(const Failure(message: 'Unimplemented yet'));
  }

  @override
  Future<Either<Failure, WaitersList>> getWaiters(int restaurantId) async {
    return left(const Failure(message: 'Unimplemented yet'));
  }

  @override
  Future<Either<Failure, List<Tax>>> getTaxes(int resturantId) async {
    return left(const Failure(message: 'Unimplemented yet'));
  }
}
