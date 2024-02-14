import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../routes/routes.dart';
import '../../domain/api_client/auth_api_client.dart';
import '../../domain/api_client/network_client.dart';
import '../../domain/blocs/auth_bloc/auth_bloc.dart';
import '../../domain/blocs/auth_bloc/auth_event.dart';
import '../../domain/blocs/cart_blocs/cart_bloc.dart';
import '../../domain/blocs/cart_blocs/cart_bloc_event.dart';
import '../../domain/blocs/categories_bloc/categories_bloc.dart';
import '../../domain/blocs/categories_bloc/categories_event.dart';
import '../../domain/blocs/favorite_cubit/favorite_cubit.dart';
import '../../domain/blocs/products_bloc/products_bloc.dart';
import '../../domain/blocs/products_bloc/products_bloc_event.dart';
import '../../domain/blocs/slider_cubit/slider_cubit.dart';
import '../../../../entity/user.dart';
import '../../utils/global_context_helper.dart';
import '../main_page/main_page_bloc.dart';
import 'loader_view_cubit.dart';

class LoaderWidget extends StatefulWidget {
  const LoaderWidget({super.key});

  @override
  State<LoaderWidget> createState() => _LoaderWidgetState();
}

class _LoaderWidgetState extends State<LoaderWidget> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // await Future.delayed(const Duration(seconds: 3));
      final state = context.read<LoaderViewCubit>().state;
      context.read<LoaderViewCubit>().emitState(state);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoaderViewCubit, LoaderViewCubitState>(
      // listenWhen: (prev, current) => current != LoaderViewCubitState.unknown,
      listener: (context, state) {
        _onLoaderViewCubitStateChange(context, state);
      },
      child: Scaffold(
        body: Center(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Colors.green,
            child: const Center(
              child: Text(
                "eGrocer",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 72,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onLoaderViewCubitStateChange(
    BuildContext context,
    LoaderViewCubitState state,
  ) async {
    var authBloc = BlocProvider.of<AuthBloc>(context);
    var categoryBloc = BlocProvider.of<CategoriesBloc>(context);
    var productBloc = BlocProvider.of<ProductsBloc>(context);
    var cartBloc = BlocProvider.of<CartBloc>(context);
    var favoriteCubit = BlocProvider.of<FavoriteCubit>(context);
    var mainBloc = BlocProvider.of<MainBloc>(context);
    var sliderCubit = BlocProvider.of<SliderCubit>(context);

    await NetworkClient.initDio();
    sliderCubit.getSliders();
    final user = await AuthApiClient().getToken();
    final authModel = authBloc.state.authModel;
    if (user?.containsKey('user') ?? false) {
      authModel.user = User.fromJson(user?['user']);
      authBloc.add(AuthLoginEvent());
    }
    if (user != null) {
      cartBloc.add(InitCartEvent());
      favoriteCubit.getFavorite(user['id']);
      mainBloc.add(InitUserFromMainEvent(user: authModel.user));
    } else {
      cartBloc.state.cartBlocModel.cartProductList = [];
    }

    final nextScreen = state != LoaderViewCubitState.unAuthorized
        ? authModel.user?.roleOfUserId == 2
            ? MainNavigationRouteNames.adminMainPage
            : MainNavigationRouteNames.mainPage
        : MainNavigationRouteNames.auth;

    nextPageNavigate(nextScreen);
    categoryBloc.add(LoadFromServerEvent());
    productBloc.add(GetLimitProductEvent());
  }
}

void nextPageNavigate(nextScreen) {
  final context = GlobalContext.globalNavigatorContext.currentContext;
  Navigator.pushNamedAndRemoveUntil(context!, nextScreen, (route) => false);
}
