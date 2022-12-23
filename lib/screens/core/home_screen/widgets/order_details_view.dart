//

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rest_list_pos/helpers/dashboard_bloc/dashboard_bloc.dart';

import '../../../../helpers/styling/styling.dart';
import '../../../../models/order.dart';
import '../orders_bloc/orders_bloc.dart';
import 'categories_add_button.dart';
import 'order_details_details_section_child.dart';
import 'order_details_finance_section.dart';
import 'order_details_items_section_child.dart';
import 'order_details_notes_section_child.dart';
import 'order_details_section_view.dart';

class PossibleOrderDetailsView extends StatelessWidget {
  const PossibleOrderDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrdersBloc, OrdersState>(
      builder: (context, state) {
        if (state.selctedOrder != null) {
          return OrderDetailsView(order: state.selctedOrder!);
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}

class OrderDetailsView extends StatefulWidget {
  const OrderDetailsView({
    Key? key,
    required this.order,
  }) : super(key: key);
  final AppOrder order;

  @override
  State<OrderDetailsView> createState() => _OrderDetailsViewState();
}

class _OrderDetailsViewState extends State<OrderDetailsView>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late CurvedAnimation _curve;
  // late Animation<double> _fadeAnimation;
  late Animation<Offset> _offsetAnimation;
  bool gotoAddItem = false;
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
      duration: const Duration(milliseconds: 250),
    )..addStatusListener((status) {
        if (status == AnimationStatus.dismissed) {
          context.read<OrdersBloc>().add(OrdersBlocClearActiveOrder());
          if (gotoAddItem) {
            context
                .read<DashboardBloc>()
                .add(DashboardAddNewItem(order: widget.order));
          }
        }
      });

    _curve = CurvedAnimation(parent: _controller, curve: Curves.easeIn);

    // _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(_controller);
    _offsetAnimation =
        Tween<Offset>(begin: const Offset(1, 0), end: const Offset(0, 0))
            .animate(_controller);

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _background(),
        Row(
          children: [
            _leftSection(context),
            AnimatedBuilder(
              animation: _curve,
              builder: (context, child) {
                return SlideTransition(
                  position: _offsetAnimation,
                  child: child,
                );
              },
              child: _content(context),
            ),
          ],
        ),
      ],
    );
  }

  SizedBox _content(BuildContext context) {
    return SizedBox(
      width: 460,
      height: double.infinity,
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
        child: Column(
          children: [
            _header(widget.order, context),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    OrderDetailsSectionView(
                      label: 'Details',
                      visibility: OrderVisibility.details,
                      hasNew: false,
                      child:
                          OrderDetailsDetailsSectionChild(order: widget.order),
                    ),
                    OrderDetailsSectionView(
                      label: widget.order.itemsTitle,
                      visibility: OrderVisibility.items,
                      hasNew: widget.order.hasNewItems,
                      child: OrderDetailsItemsSectionChild(
                        order: widget.order,
                      ),
                    ),
                    OrderDetailsSectionView(
                      label: widget.order.notesTitle,
                      visibility: OrderVisibility.notes,
                      hasNew: widget.order.hasNewNotes,
                      child: OrderDetailsNotesSectionChild(order: widget.order),
                    ),
                    const SizedBox(height: 16),
                    OrderDetailsFinanceSection(order: widget.order),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
            _addNewItemButton(context),
            const SizedBox(height: 56),
          ],
        ),
      ),
    );
  }

  Expanded _leftSection(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () =>
            context.read<OrdersBloc>().add(OrdersBlocClearActiveOrder()),
        child: Container(),
      ),
    );
  }

  Widget _background() {
    return GestureDetector(
      onTap: () => _controller.reverse(),
      child: Container(
        color: Colors.black.withOpacity(0.2),
      ),
    );
  }

  Row _addNewItemButton(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 38),
            child: TextButton(
              onPressed: () {
                gotoAddItem = true;
                _controller.reverse();
              },
              style: TextButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                foregroundColor: Colors.white,
                minimumSize: const Size.fromHeight(44),
              ),
              child: const Text('Add New Item'),
            ),
          ),
        ),
      ],
    );
  }

  Row _header(AppOrder order, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            CategoriesAddButton(
              icon: Icons.close,
              onTap: () => _controller.reverse(),
            ),
            const SizedBox(width: 16),
            Text(
              '#${order.orderNumber}',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
        Row(
          children: [
            IconButton(
                onPressed: () {},
                icon: SizedBox(
                  height: 24,
                  width: 24,
                  child: Image.asset(Assets.callWaiter),
                ))
          ],
        ),
      ],
    );
  }
}
