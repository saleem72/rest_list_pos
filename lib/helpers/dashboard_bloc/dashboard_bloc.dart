import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:collection/collection.dart';

import '../../../../models/product.dart';
import '../../../../models/product_category.dart';
import '../../../../models/app_user/app_user.dart';
import '../../../../models/restaurant/restaurant.dart';
import '../../models/failure.dart';
import '../../models/order.dart';
import '../../models/requests_bodies/get_product_body.dart';
import '../../models/restaurant_table.dart';
import '../../models/tax.dart';
import '../../models/waiter.dart';
import '../../screens/core/home_screen/repository/dashboard_repository.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc({
    required this.repository,
  }) : super(const DashboardState()) {
    on<DashboardUserLoggedIn>(_onUserLoggdIn);
    on<DashboardGetData>(_onGetData);
    on<DashboardSetActiveRestaurant>(_onSetActiveRestaurant);
    on<DashBoardSetActiveCategory>(_onSetActiveCategory);
    on<DashBoardSetActiveSubCategory>(_onSetActiveSubCategory);
    on<DashboardGetProductForCategory>(_onGetProductForCategory);
    // on<DashboardClearActiveProduct>(_onClearActiveProduct);
    // on<DashboardSetActiveProduct>(_onSetActiveProduct);
    on<DashboardClearError>(_onClearError);
    on<DashboardNextMainCategory>(_onNextMainCategory);
    on<DashboardPreviousMainCategory>(_onPreviousMainCategory);
    on<DashboardNextSubCategory>(_onNextSubCategory);
    on<DashboardPreviousSubCategory>(_onPreviousSubCategory);
    on<DashboardGoToMenuPage>(_onGoToMenuPage);
    on<DashboardGoToOrdersPage>(_onGoToOrdersPage);
    on<DashboardAddNewItem>(_onAddNewItem);
    on<DashboardAddFailure>(_onAddFailure);
    on<DashboardSetCategories>(_onSetCategories);
    on<DashboardAddOrders>(_onAddOrders);
    on<DashboardAddTables>(_onAddTables);
    on<DashboardAddWaiters>(_onAddWaiters);
    // on<DashboardGetTaxes>(_onGetTaxes);
    on<DashboardShowTaxDialog>(_onShowTaxDialog);
    on<DashboardHideTaxDialog>(_onHideTaxDialog);
  }

  final DashboardRepository repository;

  _onUserLoggdIn(DashboardUserLoggedIn event, Emitter<DashboardState> emit) {}

  _onGetData(DashboardGetData event, Emitter<DashboardState> emit) async {
    emit(state.copyWith(isLoading: true));
    final result = await repository.getData();
    result.fold(
      (failure) {
        emit(state.copyWith(isLoading: false, failure: failure));
      },
      (getUserData) => _handleUserData(emit, getUserData),
    );
  }

  _handleUserData(Emitter<DashboardState> emit, AppUser user) {
    if (user.restaurants.isNotEmpty) {
      final primaryRestaurant = user.restaurants
          .firstWhereOrNull((element) => element.isPrimary == 1);

      final Restaurant active = primaryRestaurant ?? user.restaurants[0];
      emit(state.copyWith(user: user, isLoading: false));
      add(DashboardSetActiveRestaurant(restaurant: active));
    } else {
      emit(state.copyWith(user: user, isLoading: false));
    }
  }

  _onAddFailure(DashboardAddFailure event, Emitter<DashboardState> emit) {
    emit(state.copyWith(failure: event.failure));
  }

  _onSetCategories(DashboardSetCategories event, Emitter<DashboardState> emit) {
    // add categories event
    final newState = state.copyWith(categories: event.categories);
    emit(newState);
    if (event.categories.isNotEmpty) {
      add(DashBoardSetActiveCategory(category: event.categories.first));
    }
  }

  _onSetActiveRestaurant(
      DashboardSetActiveRestaurant event, Emitter<DashboardState> emit) async {
    emit(state.copyWith(activeRestaurant: event.restaurant));
    _getCategories(event.restaurant.id);
    _getTables(event.restaurant.id);
    _getWaiters(event.restaurant.id);
    _getOrders(event.restaurant.id);
  }

  _getTables(int restaurantId) async {
    final tablesResult = await repository.getTables(restaurantId);
    tablesResult.fold(
      (failure) {
        add(DashboardAddFailure(failure: failure));
      },
      (list) {
        add(DashboardAddTables(tables: list));
      },
    );
  }

  _getWaiters(int restaurantId) async {
    final waitersResult = await repository.getWaiters(restaurantId);
    waitersResult.fold(
      (failure) {
        add(DashboardAddFailure(failure: failure));
      },
      (list) {
        add(DashboardAddWaiters(waiters: list));
      },
    );
  }

  _getOrders(int restaurantId) async {
    final ordersResult = await repository.getOrders(restaurantId);
    ordersResult.fold(
      (failure) {
        add(DashboardAddFailure(failure: failure));
      },
      (list) {
        add(DashboardAddOrders(orders: list));
      },
    );
  }

  _getCategories(int restaurantId) async {
    final categoriesResult = await repository.getCategories(restaurantId);
    categoriesResult.fold(
      (failure) {
        add(DashboardAddFailure(failure: failure));
      },
      (data) {
        add(DashboardSetCategories(categories: data));
      },
    );
  }

  _onSetActiveCategory(
      DashBoardSetActiveCategory event, Emitter<DashboardState> emit) {
    emit(state.copyWith(activeCatgory: event.category));
    if (event.category.subcategories.isNotEmpty) {
      add(DashBoardSetActiveSubCategory(
          category: event.category.subcategories.first));
    }
  }

  _onSetActiveSubCategory(
      DashBoardSetActiveSubCategory event, Emitter<DashboardState> emit) {
    emit(state.copyWith(activeSubCatgory: event.category, products: []));
    add(DashboardGetProductForCategory(
      restaurantId: state.activeRestaurant?.id ?? 0,
      categoryId: state.activeSubCatgory?.id ?? 0,
      page: 1,
      perPage: 25,
    ));
  }

  _onGetProductForCategory(DashboardGetProductForCategory event,
      Emitter<DashboardState> emit) async {
    final model = GetProductBody(
      restaurantId: event.restaurantId,
      categoryId: event.categoryId,
      page: event.page,
      perPage: event.perPage,
    );
    final result = await repository.getProduct(model);
    result.fold(
      (failure) {
        emit(state.copyWith(failure: failure));
      },
      (data) {
        emit(state.copyWith(products: data));
      },
    );
  }

  // _onClearActiveProduct(
  //     DashboardClearActiveProduct event, Emitter<DashboardState> emit) {
  //   emit(state.clearActiveProduct());
  // }

  // _onSetActiveProduct(
  //     DashboardSetActiveProduct event, Emitter<DashboardState> emit) {
  //   emit(state.copyWith(activeProduct: event.product));
  // }

  _onClearError(DashboardClearError event, Emitter<DashboardState> emit) {
    emit(state.clearError());
  }

  _onNextMainCategory(
      DashboardNextMainCategory event, Emitter<DashboardState> emit) {
    final categories = state.categories;
    final activeCategory = state.activeCatgory ?? categories.first;
    final idx = categories.indexOf(activeCategory);
    if (idx < categories.length - 1) {
      final nextCategory = categories[idx + 1];
      add(DashBoardSetActiveCategory(category: nextCategory));
    }
  }

  _onPreviousMainCategory(
      DashboardPreviousMainCategory event, Emitter<DashboardState> emit) {
    final categories = state.categories;
    final activeCategory = state.activeCatgory ?? categories.first;
    final idx = categories.indexOf(activeCategory);
    if (idx > 0) {
      final previousCategory = categories[idx - 1];
      add(DashBoardSetActiveCategory(category: previousCategory));
    }
  }

  _onNextSubCategory(
      DashboardNextSubCategory event, Emitter<DashboardState> emit) {
    final activeCategory =
        state.activeSubCatgory ?? state.categories.first.subcategories.first;
    final categories = state.activeCatgory?.subcategories ?? [];
    final idx = categories.indexOf(activeCategory);
    if (idx < categories.length - 1) {
      final nextCategory = categories[idx + 1];
      add(DashBoardSetActiveSubCategory(category: nextCategory));
    }
  }

  _onPreviousSubCategory(
      DashboardPreviousSubCategory event, Emitter<DashboardState> emit) {
    final activeCategory =
        state.activeSubCatgory ?? state.categories.first.subcategories.first;
    final categories = state.activeCatgory?.subcategories ?? [];
    final idx = categories.indexOf(activeCategory);
    if (idx > 0) {
      final previousCategory = categories[idx - 1];
      add(DashBoardSetActiveSubCategory(category: previousCategory));
    }
  }

  _onGoToMenuPage(DashboardGoToMenuPage event, Emitter<DashboardState> emit) {
    if (state.selectedPage != HomeSelectedPage.menu) {
      emit(state.copyWith(selectedPage: HomeSelectedPage.menu));
    }
  }

  _onGoToOrdersPage(
      DashboardGoToOrdersPage event, Emitter<DashboardState> emit) {
    if (state.selectedPage != HomeSelectedPage.orders) {
      emit(state.copyWith(selectedPage: HomeSelectedPage.orders));
    }
  }

  _onAddNewItem(DashboardAddNewItem event, Emitter<DashboardState> emit) {
    emit(state.copyWith(selectedPage: HomeSelectedPage.menu));
  }

  _onAddOrders(DashboardAddOrders event, Emitter<DashboardState> emit) {
    emit(state.copyWith(orders: event.orders));
  }

  _onAddTables(DashboardAddTables event, Emitter<DashboardState> emit) {
    emit(state.copyWith(tables: event.tables));
  }

  _onAddWaiters(DashboardAddWaiters event, Emitter<DashboardState> emit) {
    emit(state.copyWith(waiters: event.waiters));
  }

  // _onGetTaxes(DashboardGetTaxes event, Emitter<DashboardState> emit) async {
  //   final result = await repository.getTaxes(state.activeRestaurant?.id ?? 0);
  //   result.fold(
  //     (failure) {
  //       emit(state.copyWith(failure: failure));
  //     },
  //     (list) {
  //       emit(state.copyWith(taxes: list));
  //     },
  //   );
  // }

  _onShowTaxDialog(DashboardShowTaxDialog event, Emitter<DashboardState> emit) {
    // add(DashboardGetTaxes());
    emit(state.copyWith(showTaxDialog: true));
  }

  _onHideTaxDialog(DashboardHideTaxDialog event, Emitter<DashboardState> emit) {
    emit(state.copyWith(showTaxDialog: false));
  }
}
