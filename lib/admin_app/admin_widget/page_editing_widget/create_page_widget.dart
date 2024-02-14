import 'package:eGrocer/admin_app/admin_bloc/product_options_bloc/product_bloc.dart';
import 'package:eGrocer/admin_app/admin_bloc/product_options_bloc/product_bloc_event.dart';
import 'package:eGrocer/admin_app/admin_bloc/slider_options_bloc/slider_bloc.dart';
import 'package:eGrocer/admin_app/admin_bloc/slider_options_bloc/slider_bloc_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../routes/routes.dart';
import '../../../resources/resources.dart';
import '../../admin_bloc/category_options_bloc/category_bloc.dart';
import '../../admin_bloc/category_options_bloc/category_bloc_event.dart';
import '../../admin_bloc/user_options_bloc/user_bloc.dart';
import '../../admin_bloc/user_options_bloc/user_bloc_event.dart';

class CreateWidgetPage extends StatelessWidget {
  const CreateWidgetPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Edit Page"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            crossAxisCount: 2,
          ),
          children: [
            Card(
              child: InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: () {
                  context.read<UserBloc>().add(GetUserBlocEvent());
                  Navigator.of(context).pushNamed(MainNavigationRouteNames.userEditPage);
                },
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(
                        AppImages.person,
                        width: 100,
                        height: 100,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Column(
                      children: [
                        Text("Edit Users List"),
                      ],
                    )
                  ],
                ),
              ),
            ),
            Card(
              child: InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: () {
                  context.read<CategoryBloc>().add(GetCategoryBlocEvent());
                  Navigator.pushNamed(context, MainNavigationRouteNames.categoryEditPage);
                },
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(
                        AppImages.categories,
                        height: 100,
                        width: 100,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Column(
                      children: [
                        Text("Edit Category List"),
                      ],
                    )
                  ],
                ),
              ),
            ),
            Card(
              child: InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: () {
                  context.read<ProductBloc>().add(GetProductBlocEvent());
                  Navigator.pushNamed(context, MainNavigationRouteNames.productEditList);
                },
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(
                        AppImages.products,
                        height: 100,
                        width: 100,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Column(
                      children: [
                        Text("Edit Product List"),
                      ],
                    )
                  ],
                ),
              ),
            ),
            Card(
              child: InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: () {
                  context.read<SliderBloc>().add(GetSliderBlocEvent());
                  Navigator.pushNamed(context, MainNavigationRouteNames.posterEditPage);
                },
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(
                        AppImages.carousel,
                        height: 100,
                        width: 100,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Column(
                      children: [
                        Text("Edit Slider Page"),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
