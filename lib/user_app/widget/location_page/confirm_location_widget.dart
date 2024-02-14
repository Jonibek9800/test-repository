import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

import '../../../routes/routes.dart';
import '../../domain/blocs/location_cubit/location_cubit.dart';
import '../../domain/blocs/location_cubit/location_cubit_state.dart';
import '../../domain/blocs/themes/themes_model.dart';
import '../loader_page/loader_view_cubit.dart';

class ConfirmLocationWidget extends StatelessWidget {
  const ConfirmLocationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocationCubit, LocationCubitState>(
        builder: (BuildContext context, state) {
      final locationModel = state.locationCubitModel;
      return Scaffold(
        appBar: AppBar(
          title: Text("Confirm location"),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Expanded(
                child: Stack(children: [
              YandexMap(
                mapObjects: locationModel.mapObject,
                onMapCreated: (YandexMapController controller) {
                  context.read<LocationCubit>().onCreated(controller);
                },
              ),
              Positioned(
                bottom: 10,
                right: 10,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    FloatingActionButton.small(
                      heroTag: 'btn1',
                      onPressed: () {
                        context.read<LocationCubit>().zoomIn();
                      },
                      child: const Icon(Icons.add),
                    ),
                    FloatingActionButton.small(

                      heroTag: "btn2",
                      onPressed: () {
                        context.read<LocationCubit>().zoomOut();
                      },
                      child: const Icon(Icons.remove),
                    )
                  ],
                ),
              ),
            ])),
            Card(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Select Your Location"),
                        IconButton(
                            onPressed: () {
                              context.read<LocationCubit>().currentLocation();
                            },
                            icon: const Icon(Icons.my_location))
                      ],
                    ),
                  ),
                  const Divider(
                    height: 1,
                    indent: 10,
                    endIndent: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(
                          Icons.location_history_outlined,
                          color: ThemeColor.greenColor,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                            child: Text(
                          locationModel.address ?? "${locationModel.address}",
                          maxLines: 2,
                        )),
                        OutlinedButton(
                            style: const ButtonStyle(
                                backgroundColor: MaterialStatePropertyAll(
                                    Colors.greenAccent)),
                            onPressed: () {},
                            child: Text(
                              "Change",
                              style: TextStyle(color: ThemeColor.greenColor),
                            ))
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: ElevatedButton(
                            onPressed: () {
                              context.read<LoaderViewCubit>().onUnknown();
                              context.read<LocationCubit>().reset();
                              Navigator.of(context).pushReplacementNamed(
                                  MainNavigationRouteNames.loaderWidget);
                            },
                            child: const Text("Confirm Location"))),
                  )
                ],
              ),
            )
          ],
        ),
      );
    });
  }
}
