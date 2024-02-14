import 'package:eGrocer/user_app/domain/blocs/slider_cubit/slider_cubit_model.dart';

class SliderCubitState {
  SliderCubitModel sliderCubitModel;

  SliderCubitState({required this.sliderCubitModel});
}


class InitSliderCubitState extends SliderCubitState {
  InitSliderCubitState({required SliderCubitModel sliderCubitModel})
      : super (sliderCubitModel: sliderCubitModel);
}

class GetSlidersCubitState extends SliderCubitState {
  GetSlidersCubitState({required SliderCubitModel sliderCubitModel})
      : super (sliderCubitModel: sliderCubitModel);
}