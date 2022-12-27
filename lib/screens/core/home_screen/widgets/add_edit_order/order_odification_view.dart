//

import 'package:flutter/material.dart';

import '../../../../../models/order.dart';
import 'add_edit_order_butttons.dart';
import 'add_edit_order_finance.dart';
import 'add_edit_order_sloth.dart';
import 'add_edit_order_summary.dart';
import 'add_new_order_view.dart';

class OrderModificationView extends StatelessWidget {
  const OrderModificationView({
    super.key,
    required this.order,
  });
  final AppOrder order;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: const [
        // Select Table
        AddEditOrderSummary(),
        Expanded(
          child: AddEditOrderBody(),
        ),
        // finance Section
        AddEditOrderFinance(),
        SizedBox(height: 8),
        AddEditOrderButttons(),
      ],
    );
  }
}
