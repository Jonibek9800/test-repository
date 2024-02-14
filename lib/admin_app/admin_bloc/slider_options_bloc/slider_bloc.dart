import 'package:bloc/bloc.dart';
import 'package:eGrocer/admin_app/admin_api/slider_api.dart';
import 'package:eGrocer/admin_app/admin_bloc/slider_options_bloc/slider_bloc_event.dart';
import 'package:eGrocer/admin_app/admin_bloc/slider_options_bloc/slider_bloc_model.dart';
import 'package:eGrocer/admin_app/admin_bloc/slider_options_bloc/slider_bloc_state.dart';

import '../../../entity/slider.dart';

class SliderBloc extends Bloc<SliderBlocEvent, SliderBlocState> {
  SliderBloc() : super(InitSliderBlocState(sliderBlocModel: SliderBlocModel())) {
    on<GetSliderBlocEvent>((event, emit) => onGetSliderEvent(event, emit));
  }

  void onGetSliderEvent(GetSliderBlocEvent event, Emitter emit) async {
    final currentState = state.sliderBlocModel;
    try {
      final data = await SliderApi.getSliderPoster();
      if (data.containsKey("error")) {
        currentState.errorMessage = data['error'];
        emit(GetSliderBlocState(sliderBlocModel: currentState));
      }

      currentState.posterList = (data['carousel_poster'] as List).map((e) => Slider.fromJson(e)).toList();
    } catch (err) {
      currentState.errorMessage = err as String;
    }
    emit(GetSliderBlocState(sliderBlocModel: currentState));
  }
}
