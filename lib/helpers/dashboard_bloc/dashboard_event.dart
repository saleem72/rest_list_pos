// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'dashboard_bloc.dart';

abstract class DashboardEvent extends Equatable {
  const DashboardEvent();

  @override
  List<Object> get props => [];
}

class DashboardGetData extends DashboardEvent {}

class DashboardUserLoggedIn extends DashboardEvent {
  final AppUser user;

  const DashboardUserLoggedIn({required this.user});

  @override
  List<Object> get props => [user];
}

class DashboardSetActiveRestaurant extends DashboardEvent {
  final Restaurant restaurant;

  const DashboardSetActiveRestaurant({required this.restaurant});

  @override
  List<Object> get props => [restaurant];
}

class DashboardSetCategories extends DashboardEvent {
  final List<ProductCategory> categories;
  const DashboardSetCategories({
    required this.categories,
  });

  @override
  List<Object> get props => [categories];
}

class DashboardAddFailure extends DashboardEvent {
  final Failure failure;
  const DashboardAddFailure({
    required this.failure,
  });

  @override
  List<Object> get props => [failure];
}

class DashBoardSetActiveCategory extends DashboardEvent {
  final ProductCategory category;

  const DashBoardSetActiveCategory({
    required this.category,
  });

  @override
  List<Object> get props => [category];
}

class DashBoardSetActiveSubCategory extends DashboardEvent {
  final ProductCategory category;

  const DashBoardSetActiveSubCategory({
    required this.category,
  });

  @override
  List<Object> get props => [category];
}

class DashboardGetProductForCategory extends DashboardEvent {
  final int restaurantId;
  final int categoryId;
  final int page;
  final int perPage;

  const DashboardGetProductForCategory({
    required this.restaurantId,
    required this.categoryId,
    required this.page,
    required this.perPage,
  });

  @override
  List<Object> get props => [restaurantId, categoryId, page, perPage];
}

class DashboardSetActiveProduct extends DashboardEvent {
  final Product product;
  const DashboardSetActiveProduct({
    required this.product,
  });

  @override
  List<Object> get props => [product];
}

class DashboardClearActiveProduct extends DashboardEvent {}

class DashboardClearError extends DashboardEvent {}

class DashboardNextMainCategory extends DashboardEvent {}

class DashboardPreviousMainCategory extends DashboardEvent {}

class DashboardNextSubCategory extends DashboardEvent {}

class DashboardPreviousSubCategory extends DashboardEvent {}

class DashboardGoToMenuPage extends DashboardEvent {}

class DashboardGoToOrdersPage extends DashboardEvent {}

class DashboardAddNewItem extends DashboardEvent {
  final AppOrder order;
  const DashboardAddNewItem({
    required this.order,
  });

  @override
  List<Object> get props => [order];
}

class DashboardAddOrders extends DashboardEvent {
  final List<AppOrder> orders;

  const DashboardAddOrders({
    required this.orders,
  });

  @override
  List<Object> get props => [orders];
}

class DashboardAddTables extends DashboardEvent {
  final List<RestaurantTable> tables;

  const DashboardAddTables({
    required this.tables,
  });

  @override
  List<Object> get props => [tables];
}

class DashboardAddWaiters extends DashboardEvent {
  final List<Waiter> waiters;

  const DashboardAddWaiters({
    required this.waiters,
  });

  @override
  List<Object> get props => [waiters];
}

// class DashboardGetTaxes extends DashboardEvent {}

class DashboardShowTaxDialog extends DashboardEvent {}

class DashboardHideTaxDialog extends DashboardEvent {}
