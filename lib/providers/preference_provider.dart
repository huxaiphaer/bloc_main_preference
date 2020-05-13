import 'package:blocmainpreference/blocs/preference_bloc.dart';
import 'package:flutter/cupertino.dart';

class PreferenceProvider with ChangeNotifier {
  PreferenceBloc _bloc;

  PreferenceProvider() {
    _bloc = PreferenceBloc();
    _bloc.loadPreferences();
  }

  PreferenceBloc get bloc => _bloc;
}
