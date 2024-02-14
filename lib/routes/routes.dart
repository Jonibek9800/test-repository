import 'package:eGrocer/admin_app/admin_widget/category_options_widgets/create_category_widget/add_category_widget.dart';
import 'package:eGrocer/admin_app/admin_widget/category_options_widgets/update_category_widget/update_category_widget.dart';
import 'package:eGrocer/admin_app/admin_widget/product_options_widgets/create_product_widget/add_product_widget.dart';
import 'package:eGrocer/admin_app/admin_widget/product_options_widgets/products_edit_list_widget/product_edit_list_widget.dart';
import 'package:eGrocer/admin_app/admin_widget/product_options_widgets/update_product_widget/update_product_widget.dart';
import 'package:eGrocer/admin_app/admin_widget/slider_options_widgets/add_poster_widget/add_poster_widget.dart';
import 'package:eGrocer/admin_app/admin_widget/slider_options_widgets/posters_edit_list_widget/poster_edit_list_widget.dart';
import 'package:flutter/material.dart';

import '../admin_app/admin_widget/category_options_widgets/categories_edit_list_widget/categories_edit_list_widget.dart';
import '../admin_app/admin_widget/user_options_widgets/create_user_wdget/create_user_widget.dart';
import '../admin_app/admin_widget/user_options_widgets/update_user_widget/update_user_widget.dart';
import '../admin_app/admin_widget/user_options_widgets/users_edit_list_widget/users_edit_list_widget.dart';
import '../admin_app/main_page/admin_main_page.dart';
import '../user_app/widget/auth/auth_widget.dart';
import '../user_app/widget/cart_page/cart_page_widget.dart';
import '../user_app/widget/checkout_page/checkout_widget.dart';
import '../user_app/widget/loader_page/loader_widget.dart';
import '../user_app/widget/location_page/confirm_location_widget.dart';
import '../user_app/widget/location_page/location_page_widget.dart';
import '../user_app/widget/main_page/main_page_widget.dart';
import '../user_app/widget/orders_page/order_details_widget.dart';
import '../user_app/widget/orders_page/order_page_widget.dart';
import '../user_app/widget/product_card/product_card_widget.dart';
import '../user_app/widget/products_page/products_by_category_widget.dart';
import '../user_app/widget/products_page/products_widget.dart';
import '../user_app/widget/profile_page/edit_profile_widget.dart';
import '../user_app/widget/profile_page/profile_page_widget.dart';
import '../user_app/widget/search_widget/search_widget.dart';

abstract class MainNavigationRouteNames {
  ///Admin Routes
  static const userEditPage = "$adminMainPage/user_edit";
  static const addUserPage = "$userEditPage/add_user";
  static const updateUserPage = "$userEditPage/update_edit/";

  static const productEditList = "$adminMainPage/products_list";
  static const productUpdatePage = "$productEditList/update";
  static const productAddPage = "$productEditList/add";

  static const posterEditPage = "$adminMainPage/poster_edit";
  static const posterAddPage = "$posterEditPage/poster_add";

  static const categoryEditPage = "$adminMainPage/category_list";
  static const addCategoryPage = "$categoryEditPage/add";
  static const updateCategoryPage = "$categoryEditPage/update";


  static const adminMainPage = "/admin_main_page";

  ///User Routs
  static const loaderWidget = "/";
  static const auth = "/auth";
  static const mainPage = "/main_page";
  static const products = "$mainPage/products";
  static const cartPage = "/cart_page";
  static const checkout = "$cartPage/checkout";
  static const searchPage = "/search_page";
  static const profile = "/profile";
  static const editProfile = "$profile/edit_profile";
  static const allOrders = "$profile/orders";
  static const orderDetails = "$allOrders/details";
  static const location = "/location";
  static const confirmLocation = '$location/confirm';
  static const productCard = '/product/product_card';

  static const productByCategory = "/categories/product_by_category";
}

class Routes {
  static Map<String, WidgetBuilder> pathRoutes() {
    return {
      /// Admin Routes
      MainNavigationRouteNames.userEditPage: (_) => const UserEditWidget(),
      MainNavigationRouteNames.addUserPage: (_) => const CreateUserWidget(),
      MainNavigationRouteNames.updateUserPage: (_) => const UpdateUserWidget(),
      MainNavigationRouteNames.categoryEditPage: (_) => const CategoriesEditListWidget(),
      MainNavigationRouteNames.addCategoryPage: (_) => const AddCategoryWidget(),
      MainNavigationRouteNames.updateCategoryPage: (_) => const UpdateCategoryWidget(),
      MainNavigationRouteNames.productEditList: (_) => const ProductEditListWidget(),
      MainNavigationRouteNames.productUpdatePage: (_) => const UpdateProductWidget(),
      MainNavigationRouteNames.productAddPage: (_) => const AddProductWidget(),
      MainNavigationRouteNames.posterEditPage: (_) => const PosterEditListWidget(),
      MainNavigationRouteNames.posterAddPage: (_) => const AddPosterWidget(),

      /// User Routes
      MainNavigationRouteNames.loaderWidget: (_) => const LoaderWidget(),
      MainNavigationRouteNames.auth: (_) => const AuthWidget(),
      MainNavigationRouteNames.mainPage: (_) => const MainPageWidget(),
      MainNavigationRouteNames.products: (_) => const ProductsWidget(),
      MainNavigationRouteNames.cartPage: (_) => const CartPageWidget(),
      MainNavigationRouteNames.searchPage: (_) => const SearchWidget(),
      MainNavigationRouteNames.productByCategory: (_) => const ProductsByCategoryWidget(),
      MainNavigationRouteNames.profile: (_) => const ProfilePageWidget(),
      MainNavigationRouteNames.editProfile: (_) => const EditProfileWidget(),
      MainNavigationRouteNames.checkout: (_) => const CheckoutWidget(),
      MainNavigationRouteNames.allOrders: (_) => const OrdersWidget(),
      MainNavigationRouteNames.orderDetails: (_) => const OrderDetailsWidget(),
      MainNavigationRouteNames.location: (_) => const LocationWidget(),
      MainNavigationRouteNames.confirmLocation: (_) => const ConfirmLocationWidget(),
      MainNavigationRouteNames.productCard: (_) => const ProductCardWidget(),
      MainNavigationRouteNames.adminMainPage: (_) => const AdminMainPageWidget(),
    };
  }

  static void resetNavigation(BuildContext context) {
    Navigator.of(context).pushNamedAndRemoveUntil(MainNavigationRouteNames.loaderWidget, (route) => false);
  }
}
