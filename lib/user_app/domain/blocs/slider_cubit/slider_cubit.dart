import 'package:bloc/bloc.dart';
import 'package:eGrocer/user_app/domain/blocs/slider_cubit/slider_cubit_model.dart';
import 'package:eGrocer/user_app/domain/blocs/slider_cubit/slider_cubit_state.dart';

import '../../api_client/carousel_api.dart';
import '../../../../entity/slider.dart';

class SliderCubit extends Cubit<SliderCubitState> {
  SliderCubit()
      : super(InitSliderCubitState(sliderCubitModel: SliderCubitModel()));

  void getSliders() async {
    final current = state.sliderCubitModel;
    final data = await CarouselApi.getCarouselImages();
    if (data.containsKey("carousel_poster")) {
      current.sliders = (data['carousel_poster'] as List)
          .map((e) => Slider.fromJson(e))
          .toList();
      emit(GetSlidersCubitState(sliderCubitModel: current));
    }
  }
}
