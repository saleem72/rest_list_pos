//

import 'package:flutter/material.dart';

import '../home_widgets.dart';

class HomeMenuPage extends StatelessWidget {
  const HomeMenuPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: _leftSection(context),
          ),
          const SizedBox(width: 16),
          const Expanded(
            flex: 1,
            child: AddEditOrderView(),
          ),
        ],
      ),
    );
  }

  Widget _leftSection(BuildContext context) {
    return Column(
      children: [
        const MainCategoriesView(),
        Expanded(
          child: Card(
            color: Colors.white,
            elevation: 4,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  SubCategoriesView(),
                  ProductsListView(),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
