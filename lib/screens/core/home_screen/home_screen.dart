//

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rest_list_pos/models/tax_view_model.dart';
import 'package:rest_list_pos/screens/core/home_screen/taxes/taxes_repository/taxes_repository.dart';
import 'package:rest_list_pos/screens/core/home_screen/taxes/taxes_service/taxes_service_mock.dart';

import '../../../helpers/dashboard_bloc/dashboard_bloc.dart';
import '../../../helpers/styling/styling.dart';
import 'home_widgets.dart';
import 'orders_bloc/orders_bloc.dart';
import 'pages.dart';
import 'pages/home_orders_page.dart';
import 'taxes/taxes_bloc/taxes_bloc.dart';

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
            const HomeFailureView(),
            const PossibleOrderDetailsView(),
            const PossibleTaxesDialog(),
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
                context.read<DashboardBloc>().add(DashboardGoToOrdersPage());
              },
            ),
          ],
        ),
      ),
    );
  }
}

class PossibleTaxesDialog extends StatelessWidget {
  const PossibleTaxesDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardBloc, DashboardState>(
      builder: (context, state) {
        return state.showTaxDialog
            ? BlocProvider(
                create: (context) => TaxesBloc(
                  resturantId: state.activeRestaurant?.id ?? 0,
                  repository: TaxesRepositoryImpl(
                    service: TaxesServiceMock(),
                  ),
                )..add(TaxesGetData()),
                child: const TaxesDialog(),
              )
            : const SizedBox.shrink();
      },
    );
  }
}

class TaxesDialog extends StatelessWidget {
  const TaxesDialog({super.key});
  // final List<Tax> taxes;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaxesBloc, TaxesState>(
      builder: (context, state) {
        return _content(context, state);
      },
    );
  }

  Widget _content(BuildContext context, TaxesState state) {
    return Stack(
      fit: StackFit.loose,
      children: [
        GestureDetector(
          onTap: () =>
              context.read<DashboardBloc>().add(DashboardHideTaxDialog()),
          child: Container(
            color: Colors.black.withOpacity(0.2),
          ),
        ),
        Center(
          child: Container(
            alignment: Alignment.center,
            constraints: const BoxConstraints(
              minHeight: 400,
            ),
            width: 800,
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: Container(
                padding: const EdgeInsets.all(16),
                width: double.infinity,
                child: state.isFetching
                    ? Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: Container(
                              height: 100,
                              alignment: Alignment.center,
                              child: const SizedBox(
                                height: 40,
                                width: 40,
                                child: CircularProgressIndicator(),
                              ),
                            ),
                          ),
                        ],
                      )
                    : _mainContents(context, state.taxes),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Column _mainContents(BuildContext context, List<TaxViewModel> taxes) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _header(context),
        const SizedBox(height: 16),
        _taxesList(taxes),
        const SizedBox(height: 16),
        _addNewTax(context),
        const SizedBox(height: 16),
        _formsButtons(context),
      ],
    );
  }

  Column _header(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Tax Settings',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        const SizedBox(height: 8),
        Text(
          'Manage your restaurant taxes here',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }

  Widget _taxesList(List<TaxViewModel> taxes) {
    return taxes.isNotEmpty
        ? Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              for (int i = 0; i < taxes.length; i++)
                TaxFillForm(
                  tax: taxes[i],
                  index: i,
                )
            ],
          )
        : const SizedBox.shrink();
  }

  Row _formsButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton(
          onPressed: () {},
          child: Text(
            'Close',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Pallet.darkAppBar,
                ),
          ),
        ),
        const SizedBox(width: 24),
        TextButton(
          onPressed: () => context.read<TaxesBloc>().add(TaxesApplyChanges()),
          style: TextButton.styleFrom(
            backgroundColor: Theme.of(context).primaryColor,
            foregroundColor: Colors.white,
          ),
          child: Text(
            'Apply',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Colors.white,
                ),
          ),
        ),
      ],
    );
  }

  Row _addNewTax(BuildContext context) {
    return Row(
      children: [
        TextButton(
          onPressed: () => context.read<TaxesBloc>().add(TaxesAddNewTax()),
          style: TextButton.styleFrom(
            backgroundColor: Theme.of(context).primaryColor,
            foregroundColor: Colors.white,
          ),
          child: Text(
            'Add new tax',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Colors.white,
                ),
          ),
        ),
      ],
    );
  }
}

class TaxFillForm extends StatelessWidget {
  const TaxFillForm({
    Key? key,
    required this.tax,
    required this.index,
  }) : super(key: key);
  final TaxViewModel tax;
  final int index;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 64,
      child: Row(
        children: [
          Expanded(
            child: TaxInputField(
              label: 'Title',
              hint: 'Enter title',
              initialValue: tax.name,
              onChange: (value) => context
                  .read<TaxesBloc>()
                  .add(TaxesUpdateTitle(index: index, value: value)),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: TaxInputField(
              label: tax.type.title,
              hint: 'Enter ${tax.type.title}',
              initialValue: tax.value.toString(),
              onChange: (value) => context
                  .read<TaxesBloc>()
                  .add(TaxesUpdateValue(index: index, value: value)),
              showIcon: true,
              onFlip: () =>
                  context.read<TaxesBloc>().add(TaxesFlipKind(tax: tax)),
            ),
          ),
          _deleteTax(context),
        ],
      ),
    );
  }

  TextButton _deleteTax(BuildContext context) {
    return TextButton(
      onPressed: () =>
          context.read<TaxesBloc>().add(TaxesDeleteTax(index: index)),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFBE4B49).withOpacity(0.4),
          borderRadius: BorderRadius.circular(6),
        ),
        height: 24,
        width: 24,
        alignment: Alignment.center,
        child: const Icon(
          Icons.remove,
          size: 16,
          color: Color(0xFFBE4B49),
        ),
      ),
    );
  }
}

class TaxInputField extends StatefulWidget {
  const TaxInputField({
    Key? key,
    required this.label,
    required this.hint,
    required this.initialValue,
    this.showIcon = false,
    required this.onChange,
    this.onFlip,
  }) : super(key: key);
  final String label;
  final String hint;
  final String initialValue;
  final bool showIcon;
  final Function? onFlip;
  final Function(String) onChange;

  @override
  State<TaxInputField> createState() => _TaxInputFieldState();
}

class _TaxInputFieldState extends State<TaxInputField> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant TaxInputField oldWidget) {
    super.didUpdateWidget(oldWidget);
    _controller.text = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Pallet.darkAppBar,
              ),
        ),
        TextField(
          controller: _controller,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Pallet.darkAppBar,
              ),
          decoration: InputDecoration(
            suffixIcon: widget.showIcon ? _chnageTypeButton() : null,
            hintText: widget.hint,
            hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Pallet.darkAppBar.withOpacity(0.2),
                ),
          ),
          onChanged: (value) => widget.onChange(value),
          // onEditingComplete: () => widget.onChange(_controller.text),
          // onSubmitted: (value) => widget.onChange(_controller.text),
        ),
      ],
    );
  }

  Widget _chnageTypeButton() {
    return TextButton(
      onPressed: () {
        if (widget.onFlip != null) {
          widget.onFlip!();
        }
      },
      child: Container(
        height: 24,
        width: 24,
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          color: Pallet.primary,
          shape: BoxShape.circle,
        ),
        child: const Icon(
          Icons.recycling,
          size: 12,
          color: Colors.white,
        ),
      ),
    );
  }
}
