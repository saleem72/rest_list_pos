//

import 'package:equatable/equatable.dart';

typedef TablesList = List<RestaurantTable>;

enum RestaurantTableStatus { busy, free }

class RestaurantTableParent extends Equatable {
  final int id;
  final String name;
  const RestaurantTableParent({
    required this.id,
    required this.name,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
    };
  }

  factory RestaurantTableParent.fromMap(Map<String, dynamic> map) {
    return RestaurantTableParent(
      id: map['id'] as int,
      name: map['name'] as String,
    );
  }

  @override
  List<Object?> get props => [id];
}

class RestaurantTable {
  final int id;
  final String name;
  final int minSeats;
  final int maxSeats;
  final String status;
  final String qr;
  final String qrCode;
  final String qrUrl;
  final DateTime createdAt;
  final DateTime updatedAt;
  final RestaurantTableParent restaurant;
  final int? waiter;
  final bool isSupervised;

  RestaurantTable({
    required this.id,
    required this.name,
    required this.minSeats,
    required this.maxSeats,
    required this.status,
    required this.qr,
    required this.qrCode,
    required this.qrUrl,
    required this.createdAt,
    required this.updatedAt,
    required this.restaurant,
    this.waiter,
    required this.isSupervised,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'min_seats': minSeats,
      'max_seats': maxSeats,
      'status': status,
      'qr': qr,
      'qr_code': qrCode,
      'qr_url': qrUrl,
      'created_at': createdAt.millisecondsSinceEpoch,
      'updated_at': updatedAt.millisecondsSinceEpoch,
      'restaurant': restaurant.toMap(),
      'waiter': waiter,
      'is_supervised': isSupervised,
    };
  }

  factory RestaurantTable.fromMap(Map<String, dynamic> map) {
    return RestaurantTable(
      id: map['id'] as int,
      name: map['name'] as String,
      minSeats: map['min_seats'] as int,
      maxSeats: map['max_seats'] as int,
      status: map['status'] as String,
      qr: map['qr'] as String,
      qrCode: map['qr_code'] as String,
      qrUrl: map['qr_url'] as String,
      createdAt: DateTime.parse(map['created_at'] as String),
      updatedAt: DateTime.parse(map['updated_at'] as String),
      restaurant: RestaurantTableParent.fromMap(
          map['restaurant'] as Map<String, dynamic>),
      waiter: map['waiter'] != null ? map['waiter'] as int : null,
      isSupervised: map['is_supervised'] as bool,
    );
  }
}

/*
"id": 31,
            "name": "r",
            "min_seats": 1,
            "max_seats": 1,
            "status": "busy",
            "qr": "https://restlist.app/api_dev/storage/table/qrs/1670764935f54tO5WV22.svg",
            "qr_code": "rEeNUj",
            "qr_url": "http://97.74.86.234:8080/items?code=pizza-hutCFYqc&table_code=31",
            "created_at": "2022-12-11T13:22:15.000000Z",
            "updated_at": "2022-12-13T12:15:23.000000Z",
            "restaurant": {
                "id": 18,
                "name": "Pizza Hut"
            },
            "waiter": null,
            "is_supervised": false
*/
