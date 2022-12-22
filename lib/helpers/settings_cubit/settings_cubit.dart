import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../models/settings_item.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit() : super(const SettingsState());

  setActiveItem(SettingsItem item) {
    emit(state.copyWith(item: item));
  }

  highlightItem(SettingsItem item) {
    emit(state.copyWith(item: item, shouldHighlighted: true));
  }

  moveToPosistion(Offset position) {
    emit(state.copyWith(position: position));
  }

  moveToActive(SettingsItem item, Offset position) async {
    emit(state.copyWith(position: position));
    await Future.delayed(const Duration(milliseconds: 200));
    emit(state.copyWith(item: item));
  }

  clearHighlight(Offset position) {
    emit(state.copyWith(position: position, shouldHighlighted: false));
  }
}
