//

import 'package:flutter/material.dart';
import 'package:rest_list_pos/helpers/formmaters.dart';
import 'package:rest_list_pos/helpers/styling/pallet.dart';
import 'package:rest_list_pos/models/order.dart';
import 'package:rest_list_pos/screens/core/home_screen/pages/home_orders_page.dart';

import '../../../../models/order/order_sub_status.dart';
import 'dashed_line.dart';

class OrderDetailsSectionView extends StatefulWidget {
  const OrderDetailsSectionView({
    Key? key,
    required this.label,
    required this.child,
  }) : super(key: key);
  final String label;
  final Widget child;

  @override
  State<OrderDetailsSectionView> createState() =>
      _OrderDetailsSectionViewState();
}

class _OrderDetailsSectionViewState extends State<OrderDetailsSectionView> {
  bool showChild = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          constraints: const BoxConstraints(minHeight: 40),
          child: Column(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                // decoration: showChild
                //     ? BoxDecoration(
                //         color: const Color(0xFFF2F2F2),
                //         borderRadius: BorderRadius.circular(8),
                //       )
                //     : null,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.label,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          showChild = !showChild;
                        });
                      },
                      icon: Icon(
                        showChild
                            ? Icons.keyboard_arrow_down
                            : Icons.keyboard_arrow_up,
                      ),
                    )
                  ],
                ),
              ),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                transitionBuilder: (Widget child, Animation<double> animation) {
                  return ScaleTransition(scale: animation, child: child);
                },
                child: _animatedChild(),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        const DashedLine(),
      ],
    );
  }

  Widget _animatedChild() {
    if (showChild) {
      return Container(
        key: const ValueKey<String>('Details_Child_Full'),
        child: widget.child,
      );
    } else {
      return const SizedBox.shrink(
        key: ValueKey<String>('Details_Child_Empty'),
      );
    }
  }
}
