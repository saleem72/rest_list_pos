part of 'dashboard_bloc.dart';

enum HomeSelectedPage { menu, orders }

class DashboardState extends Equatable {
  const DashboardState({
    this.user,
    this.isLoading = false,
    this.activeRestaurant,
    this.failure,
    this.categories = const [],
    this.activeCatgory,
    this.activeSubCatgory,
    this.products = const [],
    this.activeProduct,
    this.orders = const [],
    this.selectedPage = HomeSelectedPage.menu,
    this.selectedOrder,
  });

  final AppUser? user;
  final bool isLoading;
  final Restaurant? activeRestaurant;
  final Failure? failure;
  final List<ProductCategory> categories;
  final ProductCategory? activeCatgory;
  final ProductCategory? activeSubCatgory;
  final List<Product> products;
  final Product? activeProduct;
  final List<AppOrder> orders;
  final HomeSelectedPage selectedPage;
  final AppOrder? selectedOrder;
  @override
  List<Object?> get props => [
        user,
        activeRestaurant,
        failure,
        isLoading,
        categories,
        activeCatgory,
        activeSubCatgory,
        products,
        activeProduct,
        selectedPage,
        selectedOrder,
      ];

  DashboardState copyWith({
    AppUser? user,
    bool? isLoading,
    Restaurant? activeRestaurant,
    Failure? failure,
    List<ProductCategory>? categories,
    ProductCategory? activeCatgory,
    ProductCategory? activeSubCatgory,
    List<Product>? products,
    Product? activeProduct,
    List<AppOrder>? orders,
    HomeSelectedPage? selectedPage,
    AppOrder? selectedOrder,
  }) {
    return DashboardState(
      user: user ?? this.user,
      isLoading: isLoading ?? this.isLoading,
      activeRestaurant: activeRestaurant ?? this.activeRestaurant,
      failure: failure ?? this.failure,
      categories: categories ?? this.categories,
      activeCatgory: activeCatgory ?? this.activeCatgory,
      activeSubCatgory: activeSubCatgory ?? this.activeSubCatgory,
      products: products ?? this.products,
      activeProduct: activeProduct ?? this.activeProduct,
      orders: orders ?? this.orders,
      selectedPage: selectedPage ?? this.selectedPage,
      selectedOrder: selectedOrder ?? this.selectedOrder,
    );
  }

  DashboardState clearError() {
    return DashboardState(
        user: user,
        isLoading: isLoading,
        activeRestaurant: activeRestaurant,
        failure: null,
        categories: categories,
        activeCatgory: activeCatgory,
        activeSubCatgory: activeSubCatgory,
        products: products,
        activeProduct: activeProduct,
        orders: orders,
        selectedPage: selectedPage,
        selectedOrder: selectedOrder);
  }

  DashboardState clearActiveProduct() {
    return DashboardState(
      user: user,
      isLoading: isLoading,
      activeRestaurant: activeRestaurant,
      failure: failure,
      categories: categories,
      activeCatgory: activeCatgory,
      activeSubCatgory: activeSubCatgory,
      products: products,
      activeProduct: null,
      orders: orders,
      selectedPage: selectedPage,
      selectedOrder: selectedOrder,
    );
  }

  DashboardState clearActiveOrder() {
    return DashboardState(
      user: user,
      isLoading: isLoading,
      activeRestaurant: activeRestaurant,
      failure: failure,
      categories: categories,
      activeCatgory: activeCatgory,
      activeSubCatgory: activeSubCatgory,
      products: products,
      activeProduct: null,
      orders: orders,
      selectedPage: selectedPage,
      selectedOrder: null,
    );
  }
}
