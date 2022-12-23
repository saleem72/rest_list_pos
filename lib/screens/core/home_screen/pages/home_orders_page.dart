//

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rest_list_pos/helpers/formmaters.dart';
import 'package:rest_list_pos/screens/core/home_screen/models/get_order_details_response.dart';
import 'package:rest_list_pos/screens/core/home_screen/orders_bloc/orders_bloc.dart';

import '../../../../helpers/jsons.dart';
import '../../../../helpers/styling/styling.dart';
import '../../../../models/apis_related/base_service.dart';
import '../../../../models/order.dart';
import '../../../../models/order_status.dart';
import '../models/get_orders_response.dart';

class HomeOrdersPage extends StatelessWidget {
  const HomeOrdersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _content(context);
  }

  Column _content(BuildContext context) {
    return Column(
      children: [
        _header(context),
        Expanded(
          child: Container(
            width: double.infinity,
            height: double.infinity,
            margin: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
            child: OrdersTable(
                orders: OrderDummyData.dummyData()
                  ..addAll(OrderDummyData.dummyData())),
          ),
        ),
      ],
    );
  }

  Widget _header(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: _sreachTextField(context),
          ),
          Expanded(
            flex: 5,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: () => _callWaiter(context),
                  icon: SizedBox(
                    width: 24,
                    height: 24,
                    child: Image.asset(Assets.callWaiter),
                  ),
                ),
                // grey_settings
                TextButton.icon(
                  onPressed: () {},
                  icon: SizedBox(
                    width: 24,
                    height: 24,
                    child: Image.asset(Assets.greySettings),
                  ),
                  label: Text(
                    'Settings',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Pallet.meduimDarkText,
                        ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _callWaiter(BuildContext context) async {
    try {
      final jsonResponse =
          await JsonApiResponse.loadJsonData(JsonApiResponse.getOrdersResponse);
      final loginResponse = GetOrdersResponse.fromMap(jsonResponse);
      final result = BaseService.handleResponse<OredersList>(loginResponse);
      result.fold(
        (failure) {
          print(failure);
        },
        (list) {
          print(list);
        },
      );

      final jsonDetailsResponse = await JsonApiResponse.loadJsonData(
          JsonApiResponse.getOrdersDetailsResponse);
      final detailsResponse =
          GetOrderDetailsResponse.fromMap(jsonDetailsResponse);
      final detailsResult =
          BaseService.handleResponse<AppOrder>(detailsResponse);
      detailsResult.fold(
        (failure) {
          print(failure);
        },
        (list) {
          print(list);
        },
      );
    } catch (ex) {
      print(ex.toString());
    }
  }

  Container _sreachTextField(BuildContext context) {
    return Container(
      width: 210,
      height: 32,
      padding: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
          color: Pallet.secondBackground,
          borderRadius: BorderRadius.circular(9)),
      alignment: Alignment.center,
      child: Row(
        children: [
          SizedBox(
            width: 24,
            height: 24,
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Image.asset(Assets.search),
            ),
          ),
          const SizedBox(width: 4),
          Expanded(
            child: TextField(
              style: Theme.of(context).textTheme.bodySmall,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(),
                hintText: 'Search',
                // filled: true,
                // fillColor: Colors.pink,
                isCollapsed: true,
                hintStyle: Theme.of(context).textTheme.bodySmall,
                border: InputBorder.none,
              ),
            ),
          ),
          const SizedBox(width: 4),
          SizedBox(
            width: 24,
            height: 24,
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Image.asset(Assets.filter),
            ),
          ),
        ],
      ),
    );
  }
}

class OrdersTableHeaderTitle extends StatelessWidget {
  const OrdersTableHeaderTitle({
    Key? key,
    required this.label,
    this.isLeading = false,
    this.isTrailing = false,
  }) : super(key: key);
  final String label;
  final bool isLeading;
  final bool isTrailing;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: 8,
          bottom: 8,
          left: isLeading ? 24 : 8,
          right: isTrailing ? 24 : 8),
      child: Center(
        child: Text(
          label,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
      ),
    );
  }
}

class OrderStatusCell extends StatelessWidget {
  const OrderStatusCell({
    super.key,
    required this.status,
  });
  final OrderStatus status;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 8, left: 8, right: 8),
      child: Center(
        child: Text(
          status.title,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: status.color,
              ),
        ),
      ),
    );
  }
}

class OrdersTableCellTitle extends StatelessWidget {
  const OrdersTableCellTitle({
    Key? key,
    required this.label,
    this.isLeading = false,
    this.isTrailing = false,
  }) : super(key: key);
  final String label;
  final bool isLeading;
  final bool isTrailing;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: 8,
          bottom: 8,
          left: isLeading ? 24 : 8,
          right: isTrailing ? 24 : 8),
      child: Center(
        child: Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ),
    );
  }
}

class OrdersTableActionCell extends StatelessWidget {
  const OrdersTableActionCell({
    super.key,
    required this.order,
  });
  final AppOrder order;
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => context
          .read<OrdersBloc>()
          .add(OrdersBlocSetActiveOrder(order: order)),
      splashRadius: 22,
      icon: SizedBox(
        height: 24,
        width: 24,
        child: Image.asset(Assets.edit),
      ),
    );
  }
}

class OrdersTable extends StatelessWidget {
  const OrdersTable({super.key, required this.orders});

  final List<AppOrder> orders;
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Table(
            // border: TableBorder.all(),
            columnWidths: const <int, TableColumnWidth>{
              0: IntrinsicColumnWidth(),
              1: FlexColumnWidth(),
              2: FlexColumnWidth(),
              3: FlexColumnWidth(),
              4: FlexColumnWidth(),
              5: FlexColumnWidth(),
              6: FlexColumnWidth(),
            },
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            // children:
            //     Order.dummyData().map((e) => rowForOrder(e)).toList()
            //       ..insert(0, tableHeader()),
            children: (List.generate(orders.length, (index) {
              return [
                rowForOrder(orders[index]),
                ordersTableSpacer,
              ];
            }).toList()
                  ..insert(0, [tableHeader(), ordersTableSpacer]))
                .expand((element) => element)
                .toList(),
            // ..insert(0, tableHeader()),
          ),
        ),
      ),
    );
  }

  TableRow tableHeader() {
    return const TableRow(
      children: <Widget>[
        OrdersTableHeaderTitle(label: 'ID', isLeading: true),
        OrdersTableHeaderTitle(label: 'Table Name'),
        OrdersTableHeaderTitle(label: 'Waiter'),
        OrdersTableHeaderTitle(label: 'Date & Time'),
        OrdersTableHeaderTitle(label: 'Total Price'),
        OrdersTableHeaderTitle(label: 'Status'),
        OrdersTableHeaderTitle(label: 'Actions', isTrailing: true),
      ],
    );
  }

  TableRow rowForOrder(AppOrder order) {
    return TableRow(
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(10),
      ),
      children: <Widget>[
        OrdersTableCellTitle(
            label: order.orderNumber.toString(), isLeading: true),
        OrdersTableCellTitle(label: order.tableName),
        OrdersTableCellTitle(label: order.staffName ?? '-'),
        OrdersTableCellTitle(label: order.updatedAt),
        OrdersTableCellTitle(
            label: Formatters.currencyFormater.format(order.total)),
        OrderStatusCell(status: order.status),
        OrdersTableActionCell(order: order),
      ],
    );
  }
}

TableRow ordersTableSpacer = TableRow(children: [
  for (int i = 0; i < 7; i++)
    const SizedBox(
      height: 8,
    ),
]);
