import 'package:cached_network_image/cached_network_image.dart';
import 'package:eGrocer/admin_app/admin_bloc/slider_options_bloc/slider_bloc.dart';
import 'package:eGrocer/admin_app/admin_bloc/slider_options_bloc/slider_bloc_state.dart';
import 'package:eGrocer/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PosterEditListWidget extends StatelessWidget {
  const PosterEditListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Poster Edit List"),
        centerTitle: true,
      ),
      body: BlocBuilder<SliderBloc, SliderBlocState>(builder: (BuildContext context, state) {
        final sliderModel = state.sliderBlocModel;
        return Stack(children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 70.0),
            child: ListView.builder(
              itemCount: sliderModel.posterList.length,
              itemBuilder: (BuildContext context, int index) {
                final poster = sliderModel.posterList[index];
                return Card(
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: CachedNetworkImage(
                          imageUrl: poster.getPoster(),
                          height: 260,
                          fit: BoxFit.fill,
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const Text("Show Time"),
                      const SizedBox(
                        height: 15,
                      ),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [Text("From"), Text("Before")],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [Text("${poster.startDate}"), Text("${poster.expirationDate}")],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton(
                              onPressed: () {},
                              child: const Row(
                                children: [
                                  Text("Edit"),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Icon(Icons.edit)
                                ],
                              )),
                          ElevatedButton(
                              onPressed: () {},
                              child: const Row(
                                children: [
                                  Text("Delete"),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Icon(Icons.delete)
                                ],
                              ))
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      )
                    ],
                  ),
                );
              },
            ),
          ),
          Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, MainNavigationRouteNames.posterAddPage);
                    },
                    child: const Text("Add Slider Poster"),
                  ),
                ),
              )),
        ]);
      }),
    );
  }
}
