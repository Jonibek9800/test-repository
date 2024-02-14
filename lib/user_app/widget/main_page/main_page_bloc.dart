import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../entity/user.dart';
import '../../../admin_app/admin_widget/page_editing_widget/create_page_widget.dart';
import '../categories_page/categories_widget.dart';
import '../home_page/home_page_widget.dart';
import '../profile_page/profile_page_widget.dart';
import '../wishlist_page/wishlist_page_widget.dart';

class MainViewModel {
  int nextPageIndex = 0;
  List<Widget> widgetOptions = [];
  List<BottomNavigationBarItem> bottomNavigationBarItem = [];

  final List<Widget> userWidgetOptions = <Widget>[
    const HomePageWidget(),
    const CategoriesWidget(),
    const WishlistPageWidget(),
    const ProfilePageWidget(),
  ];
  final List<Widget> adminWidgetOptions = <Widget>[
    const HomePageWidget(),
    const CategoriesWidget(),
    const WishlistPageWidget(),
    const ProfilePageWidget(),
    const CreateWidgetPage(),
  ];


  List<BottomNavigationBarItem> userBottomNavigationBarItem =
  <BottomNavigationBarItem>[
    const BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: 'Home',
      // backgroundColor: Color(0xFF212934),
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.zoom_out_map),
      label: 'Categories',
      // backgroundColor: Color(0xFF212934),
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.favorite),
      label: 'Wishlist',
      // backgroundColor: Color(0xFF212934),
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.person),
      label: 'Profile',
      // backgroundColor: Color(0xFF212934),
    ),
  ];

  List<BottomNavigationBarItem> adminBottomNavigationBarItem =
  <BottomNavigationBarItem>[
    const BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: 'Home',
      // backgroundColor: Color(0xFF212934),
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.zoom_out_map),
      label: 'Categories',
      // backgroundColor: Color(0xFF212934),
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.favorite),
      label: 'Wishlist',
      // backgroundColor: Color(0xFF212934),
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.person),
      label: 'Profile',
      // backgroundColor: Color(0xFF212934),
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.edit),
      label: "Edit Page",
    )
  ];
}

abstract class MainViewBlocState {
  MainViewModel mainViewModel;

  MainViewBlocState({required this.mainViewModel});
}

class InitUserFromMainState extends MainViewBlocState {
  InitUserFromMainState({required MainViewModel mainViewModel})
      : super(mainViewModel: mainViewModel);
}

class NextPageBlocState extends MainViewBlocState {
  NextPageBlocState({required MainViewModel mainViewModel})
      : super(mainViewModel: mainViewModel);
}

//===========================================================================

abstract class MainViewBlocEvent {}

class NextPageBlocEvent extends MainViewBlocEvent {
  var index = 0;

  NextPageBlocEvent({required this.index});
}

class InitUserFromMainEvent extends MainViewBlocEvent {
  User? user;

  InitUserFromMainEvent({required this.user});
}

class MainBloc extends Bloc<MainViewBlocEvent, MainViewBlocState> {
  MainBloc() : super(NextPageBlocState(mainViewModel: MainViewModel())) {
    on<NextPageBlocEvent>((event, emit) {
      final currentState = state.mainViewModel;
      currentState.nextPageIndex = event.index;
      emit(NextPageBlocState(mainViewModel: currentState));
    });
    on<InitUserFromMainEvent>((event, emit) {
      final currentState = state.mainViewModel;
      if (event.user?.roleOfUserId == 1) {
        currentState.bottomNavigationBarItem =
            currentState.userBottomNavigationBarItem;
        currentState.widgetOptions = currentState.userWidgetOptions;
      } else if (event.user?.roleOfUserId == 2) {
        currentState.bottomNavigationBarItem =
            currentState.adminBottomNavigationBarItem;
        currentState.widgetOptions = currentState.adminWidgetOptions;
      }
      emit(InitUserFromMainState(mainViewModel: currentState));
    });
  }
}
