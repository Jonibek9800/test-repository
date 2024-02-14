import 'package:eGrocer/admin_app/admin_bloc/slider_options_bloc/slider_bloc_model.dart';

class SliderBlocState {
  SliderBlocModel sliderBlocModel;

  SliderBlocState({required this.sliderBlocModel});
}

class InitSliderBlocState extends SliderBlocState {
  InitSliderBlocState({required SliderBlocModel sliderBlocModel}) : super(sliderBlocModel: sliderBlocModel);
}

class GetSliderBlocState extends SliderBlocState {
  GetSliderBlocState({required SliderBlocModel sliderBlocModel}) : super(sliderBlocModel: sliderBlocModel);
}
