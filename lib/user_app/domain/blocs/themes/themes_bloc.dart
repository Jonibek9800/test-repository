import 'package:bloc/bloc.dart';
import 'package:eGrocer/user_app/domain/blocs/themes/themes_model.dart';

enum ThemesState { dark, light }

class ThemesBlocState {
  ThemesModel themesModel;

  ThemesBlocState({required this.themesModel});
}

class InitThemesState extends ThemesBlocState {
  InitThemesState({required ThemesModel themesModel})
      : super (themesModel: themesModel);
}

class ThemesDarkState extends ThemesBlocState {
  ThemesDarkState({required ThemesModel themesModel})
      : super (themesModel: themesModel);
}
class ThemesLightState extends ThemesBlocState {
  ThemesLightState({required ThemesModel themesModel})
      : super (themesModel: themesModel);
}


class ThemesBlocEvent {}

class ThemesDarkEvent extends ThemesBlocEvent {
  ThemesState? value;
  ThemesDarkEvent({required this.value});
}
class ThemesLightEvent extends ThemesBlocEvent {
  ThemesState? value;
  ThemesLightEvent({required this.value});
}

class ThemesBloc extends Bloc<ThemesBlocEvent, ThemesBlocState> {
  ThemesBloc() : super (InitThemesState(themesModel: ThemesModel())) {
    on<ThemesDarkEvent>((event, emit) {
      final current = state.themesModel;
      current.currentState = event.value;
      emit(ThemesDarkState(themesModel: current));
    });
    on<ThemesLightEvent>((event, emit) {
      final current = state.themesModel;
      current.currentState = event.value;
      emit(ThemesLightState(themesModel: current));
    });
  }


}