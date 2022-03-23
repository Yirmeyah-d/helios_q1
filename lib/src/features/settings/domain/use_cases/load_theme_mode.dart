import 'package:flutter/material.dart';

import '../../../../core/use_case/use_case.dart';
import '../repositories/settings_repository.dart';

class LoadThemeMode {
  final SettingsRepository repository;

  LoadThemeMode(this.repository);

  Future<ThemeMode> call(NoParams params) async {
    return await repository.loadThemeMode();
  }
}
