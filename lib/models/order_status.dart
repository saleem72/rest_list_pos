//

import 'package:flutter/material.dart';

import '../helpers/styling/pallet.dart';

enum OrderStatus {
  closed,
  preparing,
  delivered,
  canceled;

  String get title {
    switch (this) {
      case OrderStatus.closed:
        return 'Closed';
      case OrderStatus.preparing:
        return 'Preparing';
      case OrderStatus.delivered:
        return 'Delivered';
      case OrderStatus.canceled:
        return 'Canceled';
    }
  }

  Color get color {
    switch (this) {
      case OrderStatus.closed:
        return Pallet.red;
      case OrderStatus.preparing:
        return Pallet.grey;
      case OrderStatus.delivered:
        return Pallet.green;
      case OrderStatus.canceled:
        return Pallet.darkAppBar;
    }
  }

  static OrderStatus fromString(String title) {
    switch (title) {
      case 'closed':
        return OrderStatus.closed;
      case 'preparing':
        return OrderStatus.preparing;
      case 'delivered':
        return OrderStatus.delivered;
      case 'canceled':
        return OrderStatus.canceled;
      default:
        return OrderStatus.preparing;
    }
  }
}
