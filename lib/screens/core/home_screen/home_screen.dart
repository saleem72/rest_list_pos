//

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../helpers/dashboard_bloc/dashboard_bloc.dart';
import '../../../helpers/styling/styling.dart';
import '../../../widgets/main_widgets.dart';
import 'home_widgets.dart';
import 'orders_bloc/orders_bloc.dart';
import 'pages.dart';
import 'pages/home_orders_page.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OrdersBloc(
        dashboard: context.read<DashboardBloc>(),
      ),
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
              children: const [
                HomeScreenHeader(),
                // if (_selectedPage == 0) const Expanded(child: HomeMenuPage()),
                // if (_selectedPage == 1) const Expanded(child: HomeOrdersPage()),
                HomeActivePage(),
              ],
            ),
            LoadingView(isVisible: state.isLoading),
            const HomeFailureView(),
            const PossibleOrderDetailsView(),
          ],
        ),
      ),
    );
  }

  Widget _header(BuildContext context) {
    return BlocBuilder<DashboardBloc, DashboardState>(
      builder: (context, state) => Container(
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
              isActive: state.selectedPage == HomeSelectedPage.menu,
              onPressed: () =>
                  context.read<DashboardBloc>().add(DashboardGoToMenuPage()),
            ),
            NavBarButton(
              icon: Assets.orders,
              label: 'Orders ',
              isActive: state.selectedPage == HomeSelectedPage.orders,
              onPressed: () =>
                  context.read<DashboardBloc>().add(DashboardGoToOrdersPage()),
            ),
          ],
        ),
      ),
    );
  }
}

class HomeActivePage extends StatelessWidget {
  const HomeActivePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<DashboardBloc, DashboardState>(
        builder: (context, state) {
          return AnimatedSwitcher(
            duration: const Duration(milliseconds: 250),
            switchInCurve: Curves.easeIn,
            switchOutCurve: Curves.easeOut,
            transitionBuilder: (child, animation) {
              return SlideTransition(
                position: Tween<Offset>(
                        begin: const Offset(1.4, 0), end: const Offset(0, 0))
                    .animate(animation),
                child: child,
              );
            },
            child: _buildChild(state.selectedPage),
          );
        },
      ),
    );
  }

  Widget _buildChild(HomeSelectedPage selection) {
    switch (selection) {
      case HomeSelectedPage.menu:
        return const HomeMenuPage(key: ValueKey<String>('Menu_Page'));
      case HomeSelectedPage.orders:
        return const HomeOrdersPage(key: ValueKey('Orders_Page'));
    }
  }
}

class HomeScreenHeader extends StatelessWidget {
  const HomeScreenHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardBloc, DashboardState>(
      builder: (context, state) => Container(
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
              isActive: state.selectedPage == HomeSelectedPage.menu,
              onPressed: () =>
                  context.read<DashboardBloc>().add(DashboardGoToMenuPage()),
            ),
            NavBarButton(
              icon: Assets.orders,
              label: 'Orders ',
              isActive: state.selectedPage == HomeSelectedPage.orders,
              onPressed: () {
                print('I am here');
                context.read<DashboardBloc>().add(DashboardGoToOrdersPage());
              },
            ),
          ],
        ),
      ),
    );
  }
}
