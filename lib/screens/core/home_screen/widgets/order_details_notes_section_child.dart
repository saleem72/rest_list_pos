//

import 'package:flutter/material.dart';

import '../../../../helpers/styling/styling.dart';
import '../../../../models/order.dart';
import '../../../../models/order_note.dart';

class OrderDetailsNotesSectionChild extends StatelessWidget {
  const OrderDetailsNotesSectionChild({
    super.key,
    required this.order,
  });
  final AppOrder order;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: order.notes.map((e) => OrderDetailsNoteTile(note: e)).toList(),
    );
  }
}

class OrderDetailsNoteTile extends StatelessWidget {
  const OrderDetailsNoteTile({super.key, required this.note});
  final OrderNote note;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 16, right: 16, bottom: 8),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        color: Pallet.cardColors,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(note.note),
          ),
        ],
      ),
    );
  }
}
