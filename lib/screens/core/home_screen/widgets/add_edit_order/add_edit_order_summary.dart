//

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rest_list_pos/screens/core/home_screen/orders_bloc/orders_bloc.dart';
import 'package:rest_list_pos/widgets/app_autocomplete.dart';

import '../../../../../helpers/dashboard_bloc/dashboard_bloc.dart';
import '../../../../../helpers/styling/styling.dart';

class AddEditOrderSummary extends StatelessWidget {
  const AddEditOrderSummary({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                const Expanded(
                  child: TablesAutoComplete(),
                ),
                const SizedBox(width: 20),
                const Expanded(
                  child: WaitersAutoComplete(),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                      foregroundColor: Colors.white,
                      minimumSize: const Size.fromHeight(44),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(9),
                      ),
                    ),
                    child: Text(
                      'Close & Print',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.caption?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            const AddEditOrderTitle(),
          ],
        ),
      ),
    );
  }
}

class AddEditOrderTitle extends StatelessWidget {
  const AddEditOrderTitle({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrdersBloc, OrdersState>(
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(
                  '# ${state.orderToEdit?.orderNumber ?? 'New order'}',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: Pallet.darkAppBar,
                      ),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  '# ${state.orderToEdit?.orderItems.length ?? 0} Item',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: Pallet.darkAppBar,
                      ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

class WaitersAutoComplete extends StatelessWidget {
  const WaitersAutoComplete({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardBloc, DashboardState>(
      builder: (context, state) {
        return Container(
          constraints: const BoxConstraints(
            minHeight: 36,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(9),
            border: Border.all(
              color: Pallet.primary,
            ),
          ),
          child: state.waiters.isNotEmpty
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: AppAutoComplete(
                      initialValue: context
                              .read<OrdersBloc>()
                              .state
                              .orderToEdit
                              ?.waiterName ??
                          '',
                      hint: 'Waiter',
                      objectsList: state.waiters
                          .map((e) => ObjectTitle(id: e.id, title: e.fullName))
                          .toList(),
                      onSelected: (waiter) {},
                    ),
                  ),
                )
              : const Center(
                  child: SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      color: Pallet.primary,
                    ),
                  ),
                ),
        );
      },
    );
  }
}

class TablesAutoComplete extends StatelessWidget {
  const TablesAutoComplete({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardBloc, DashboardState>(
      builder: (context, state) {
        return Container(
          constraints: const BoxConstraints(
            minHeight: 36,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(9),
            border: Border.all(
              color: Pallet.primary,
            ),
          ),
          child: state.tables.isNotEmpty
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: AppAutoComplete(
                      initialValue: context
                              .read<OrdersBloc>()
                              .state
                              .orderToEdit
                              ?.tableName ??
                          '',
                      hint: 'Table',
                      objectsList: state.tables
                          .map((e) => ObjectTitle(id: e.id, title: e.name))
                          .toList(),
                      onSelected: (table) {},
                    ),
                  ),
                )
              : const Center(
                  child: SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      color: Pallet.primary,
                    ),
                  ),
                ),
        );
      },
    );
  }
}
