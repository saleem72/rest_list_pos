// ignore_for_file: public_member_api_docs, sort_constructors_first
//

import 'package:rest_list_pos/models/apis_related/api_reponse.dart';
import 'package:rest_list_pos/models/apis_related/paginate.dart';
import 'package:rest_list_pos/models/order.dart';

class GetOrderDetailsResponse implements ApiReponse<AppOrder> {
  @override
  int code;

  @override
  AppOrder? data;

  @override
  String? message;

  @override
  Paginate? paginate;

  @override
  bool status;

  @override
  String? whatsappMessage;
  GetOrderDetailsResponse({
    required this.code,
    this.data,
    this.message,
    this.paginate,
    required this.status,
    this.whatsappMessage,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'data': data == null ? null : data!.toMap(),
      'code': code,
      'message': message,
      'paginate': paginate,
      'status': status,
      'whatsappMessage': whatsappMessage,
    };
  }

  factory GetOrderDetailsResponse.fromMap(Map<String, dynamic> map) {
    final proList = map['data'];
    return GetOrderDetailsResponse(
      data: proList != null
          ? AppOrder.fromMap(proList as Map<String, dynamic>)
          : null,
      code: map['code'] as int,
      message: map['message'] as String?,
      paginate:
          map['paginate'] != null ? Paginate.fromJson(map['paginate']) : null,
      status: map['status'] as bool,
      whatsappMessage: map['whatsappMessage'] != null
          ? map['whatsappMessage'] as String
          : null,
    );
  }
}
