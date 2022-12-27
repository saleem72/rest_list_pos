// ignore_for_file: public_member_api_docs, sort_constructors_first
//

import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:rest_list_pos/models/failure.dart';

import 'paginate.dart';

class BaseResponse<T> {
  T? data;
  bool status;
  String? message;
  int code;
  Paginate? paginate;
  String? whatsappMessage;
  BaseResponse({
    this.data,
    required this.status,
    this.message,
    required this.code,
    this.paginate,
    this.whatsappMessage,
  });

  factory BaseResponse.fromMap(
      Map<String, dynamic> map, Function(Map<String, dynamic> data) build) {
    return BaseResponse<T>(
      data: map['data'] != null ? build(map['data']) : null,
      status: map['status'] as bool,
      message: map['message'] != null ? map['message'] as String : null,
      code: map['code'] as int,
      paginate: map['paginate'] != null
          ? Paginate.fromJson(map['paginate'] as Map<String, dynamic>)
          : null,
      whatsappMessage: map['whatsappMessage'] != null
          ? map['whatsappMessage'] as String
          : null,
    );
  }

  Either<Failure, T> result() {
    if (data != null) {
      return Right(data as T);
    } else {
      return Left(Failure(message: message ?? 'BaseResponse Error'));
    }
  }
}

class BaseListResponse<T> {
  List<T>? data;
  bool status;
  String? message;
  int code;
  Paginate? paginate;
  String? whatsappMessage;
  BaseListResponse({
    this.data,
    required this.status,
    this.message,
    required this.code,
    this.paginate,
    this.whatsappMessage,
  });

  factory BaseListResponse.fromMap(
      Map<String, dynamic> map, Function(List<dynamic> data) build) {
    return BaseListResponse<T>(
      data: map['data'] != null ? build(map['data']) : null,
      status: map['status'] as bool,
      message: map['message'] != null ? map['message'] as String : null,
      code: map['code'] as int,
      paginate: map['paginate'] != null
          ? Paginate.fromJson(map['paginate'] as Map<String, dynamic>)
          : null,
      whatsappMessage: map['whatsappMessage'] != null
          ? map['whatsappMessage'] as String
          : null,
    );
  }

  Either<Failure, List<T>> result() {
    if (data != null) {
      return Right(data!);
    } else {
      return Left(Failure(message: message ?? 'unKnown Error'));
    }
  }
}
