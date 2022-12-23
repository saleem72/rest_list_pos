//

import 'package:flutter/material.dart';

import '../../../../../helpers/styling/styling.dart';

class AddEditOrderButttons extends StatelessWidget {
  const AddEditOrderButttons({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(
              backgroundColor: Theme.of(context).primaryColor,
              foregroundColor: Colors.white,
              minimumSize: const Size.fromHeight(44),
            ),
            child: Text(
              'Add  General Note',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.caption?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(
              backgroundColor: Pallet.green,
              foregroundColor: Colors.white,
              minimumSize: const Size.fromHeight(44),
            ),
            child: Text(
              'Order Now',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.caption?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(
              backgroundColor: Pallet.red,
              foregroundColor: Colors.white,
              minimumSize: const Size.fromHeight(44),
            ),
            child: Text(
              'Cancel Order',
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
    );
  }
}
