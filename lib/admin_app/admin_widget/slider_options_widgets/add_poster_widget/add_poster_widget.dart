import 'dart:io';

import 'package:eGrocer/admin_app/admin_bloc/slider_options_bloc/slider_bloc.dart';
import 'package:eGrocer/admin_app/admin_bloc/slider_options_bloc/slider_bloc_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../resources/resources.dart';

class AddPosterWidget extends StatelessWidget {
  const AddPosterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Slider Poster"),
        centerTitle: true,
      ),
      body: BlocBuilder<SliderBloc, SliderBlocState>(
        builder: (BuildContext context, state) {
          final posterModel = state.sliderBlocModel;
          Object? arguments;
          return ListView(
            children: [
              InkWell(
                onTap: () {},
                child: posterModel.file != null
                    ? Image.file(
                        posterModel.file as File,
                        height: 250,
                      )
                    : Image.asset(
                        AppImages.person,
                        height: 250,
                      ),
              ),
              SizedBox(height: 15,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text("After"),
                  Text("Before")
                ],
              ),
              SizedBox(height: 15,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  FloatingActionButton.small(
                    heroTag: "btn1",
                    onPressed: () {
                      final pik = showDatePicker(
                        context: context,
                        // builder: (BuildContext context) {
                        //   return DatePickerDialog(
                        //     restorationId: 'date_picker_dialog',
                        //     initialEntryMode: DatePickerEntryMode.calendarOnly,
                        //     initialDate: DateTime.now(),
                        //     firstDate: DateTime(2021),
                        //     lastDate: DateTime(2025),
                        //   );
                        // },
                        initialDate: DateTime.now(), firstDate: DateTime(2021), lastDate: DateTime(2025),
                      );
                      pik.then((value) => print(value));
                    },
                    child: const Icon(Icons.date_range),
                  ),
                  FloatingActionButton.small(
                    heroTag: "btn2",
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return DatePickerDialog(
                            restorationId: 'date_picker_dialog',
                            initialEntryMode: DatePickerEntryMode.calendarOnly,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2021),
                            lastDate: DateTime(2025),
                          );
                        },
                      );
                    },
                    child: Icon(Icons.date_range),
                  ),
                ],
              )
            ],
          );
        },
      ),
    );
  }
}
