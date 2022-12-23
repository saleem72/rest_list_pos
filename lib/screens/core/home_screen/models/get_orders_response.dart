// ignore_for_file: public_member_api_docs, sort_constructors_first
//

import 'package:rest_list_pos/models/apis_related/paginate.dart';

import '../../../../models/apis_related/api_reponse.dart';
import '../../../../models/order.dart';

class GetOrdersResponse implements ApiReponse<OredersList> {
  @override
  int code;

  @override
  List<AppOrder>? data;

  @override
  String? message;

  @override
  Paginate? paginate;

  @override
  bool status;

  @override
  String? whatsappMessage;
  GetOrdersResponse({
    required this.code,
    this.data,
    this.message,
    this.paginate,
    required this.status,
    this.whatsappMessage,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'data': data == null
          ? null
          : List<dynamic>.from(data!.map((x) => x.toJson())),
      'code': code,
      'message': message,
      'paginate': paginate,
      'status': status,
      'whatsappMessage': whatsappMessage,
    };
  }

  factory GetOrdersResponse.fromMap(Map<String, dynamic> map) {
    final proList = map['data'];
    return GetOrdersResponse(
      data: proList != null
          ? List<AppOrder>.from(proList.map((x) => AppOrder.fromMap(x)))
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

  @override
  String toString() {
    return 'GetOrdersResponse(code: $code, data: $data, message: $message, paginate: $paginate, status: $status, whatsappMessage: $whatsappMessage)';
  }
}
