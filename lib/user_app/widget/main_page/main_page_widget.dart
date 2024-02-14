import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'main_page_bloc.dart';

class MainPageWidget extends StatelessWidget {
  const MainPageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainBloc, MainViewBlocState>(
        builder: (BuildContext context, state) {
      final selectedIndex = state.mainViewModel.nextPageIndex;
      return Scaffold(
        body: Center(
          child: state.mainViewModel.widgetOptions.elementAt(selectedIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: state.mainViewModel.bottomNavigationBarItem,
          currentIndex: selectedIndex,
          // selectedIconTheme: const IconThemeData(color: Color(0xFF56AE7C)),
          // selectedItemColor: Colors.white,
          onTap: (index) {
            context.read<MainBloc>().add(NextPageBlocEvent(index: index));
          },
        ),
      );
    });
  }
}

