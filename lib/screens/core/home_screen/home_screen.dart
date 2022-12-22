//

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../helpers/dashboard_bloc/dashboard_bloc.dart';
import '../../../helpers/settings_cubit/settings_cubit.dart';
import '../../../helpers/styling/styling.dart';
import '../../../widgets/main_widgets.dart';
import 'home_widgets.dart';
import 'pages.dart';
import 'pages/home_orders_page.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SettingsCubit(),
      child: const HomeScreenContent(),
    );

    //  child: const HomeScreenContent(),
  }
}

class HomeScreenContent extends StatefulWidget {
  const HomeScreenContent({Key? key}) : super(key: key);

  @override
  State<HomeScreenContent> createState() => _HomeScreenContentState();
}

class _HomeScreenContentState extends State<HomeScreenContent> {
  int _selectedPage = 0;
  @override
  void initState() {
    super.initState();
    _getData();
  }

  _getData() {
    context.read<DashboardBloc>().add(DashboardGetData());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardBloc, DashboardState>(
      builder: (context, state) => Scaffold(
        backgroundColor: Pallet.background,
        body: Stack(
          children: [
            Column(
              children: [
                _header(context),
                if (_selectedPage == 0) const Expanded(child: HomeMenuPage()),
                if (_selectedPage == 1) const Expanded(child: HomeOrdersPage()),
              ],
            ),
            LoadingView(isVisible: state.isLoading),
            const HomeFailureView(),
            const OrderDetailsView(),
          ],
        ),
      ),
    );
  }

  Container _header(BuildContext context) {
    return Container(
      height: 86,
      // padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: const BoxDecoration(
        color: Pallet.darkAppBar,
      ),
      child: Row(
        children: [
          NavBarButton(
            label: 'POS',
            icon: Assets.pos,
            isActive: _selectedPage == 0,
            onPressed: () => _updateSelected(0),
          ),
          NavBarButton(
            icon: Assets.orders,
            label: 'Orders ',
            isActive: _selectedPage == 1,
            onPressed: () => _updateSelected(1),
          ),
        ],
      ),
    );
  }

  _updateSelected(int newValue) {
    setState(() {
      _selectedPage = newValue;
    });
    print('view $_selectedPage, $newValue');
  }
}
