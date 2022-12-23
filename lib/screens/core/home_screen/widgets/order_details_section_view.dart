//

import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rest_list_pos/helpers/formmaters.dart';
import 'package:rest_list_pos/helpers/styling/pallet.dart';
import 'package:rest_list_pos/models/order.dart';
import 'package:rest_list_pos/screens/core/home_screen/orders_bloc/orders_bloc.dart';
import 'package:rest_list_pos/screens/core/home_screen/pages/home_orders_page.dart';

import '../../../../models/order/order_sub_status.dart';
import 'dashed_line.dart';

class OrderDetailsSectionView extends StatefulWidget {
  const OrderDetailsSectionView({
    Key? key,
    required this.label,
    required this.child,
    required this.hasNew,
    required this.visibility,
  }) : super(key: key);
  final String label;
  final Widget child;
  final bool hasNew;
  final OrderVisibility visibility;
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        if (widget.hasNew)
                          Container(
                            width: 9,
                            height: 9,
                            decoration: const BoxDecoration(
                              color: Pallet.cyan,
                              shape: BoxShape.circle,
                            ),
                          ),
                        if (widget.hasNew) const SizedBox(width: 8),
                        Text(
                          widget.label,
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                        ),
                      ],
                    ),
                    AnimatedButton(
                      visibility: widget.visibility,
                      onChange: () => _updateVisibility(),
                    ),
                  ],
                ),
              ),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                switchInCurve: Curves.easeIn,
                switchOutCurve: Curves.easeOut,
                transitionBuilder: (Widget child, Animation<double> animation) {
                  return SizeTransition(
                    sizeFactor: animation,
                    axis: Axis.vertical,
                    axisAlignment: -1,
                    child: child,
                  );
                  // return ScaleTransition(scale: animation, child: child);
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

  _updateVisibility() {
    setState(() {
      showChild = !showChild;
    });
    print('${widget.visibility.toString()}, $showChild');
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

class AnimatedButton extends StatefulWidget {
  const AnimatedButton({
    super.key,
    required this.visibility,
    required this.onChange,
  });
  final OrderVisibility visibility;
  final Function onChange;
  @override
  State<AnimatedButton> createState() => _AnimatedButtonState();
}

class _AnimatedButtonState extends State<AnimatedButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late CurvedAnimation _curve;
  late Animation<double> _rotation;

  @override
  void initState() {
    super.initState();
    _initAnimationController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  _initAnimationController() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed ||
            status == AnimationStatus.dismissed) {
          widget.onChange();
        }
      });

    _curve = CurvedAnimation(parent: _controller, curve: Curves.easeIn);

    _rotation = Tween<double>(begin: 0, end: math.pi).animate(_curve);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<OrdersBloc, OrdersState>(
      listener: (context, state) {
        if (state.orderVisibility == widget.visibility) {
          _controller.forward();
        } else {
          _controller.reverse();
        }
      },
      child: GestureDetector(
        onTap: () => context.read<OrdersBloc>().add(
              OrdersBlocSetVisibility(
                visibility: widget.visibility,
              ),
            ),
        child: AnimatedBuilder(
          animation: _curve,
          builder: (context, child) {
            return Transform.rotate(
              angle: _rotation.value,
              child: child,
            );
          },
          child: const SizedBox(
            width: 44,
            height: 44,
            child: Icon(Icons.keyboard_arrow_down),
          ),
        ),
      ),
    );
  }
}
