import 'package:flutter/material.dart';

import '../../domain/repositories/settings_repository.dart';
import '../data_sources/settings_local_data_source.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  final SettingsLocalDataSource localDataSource;

  SettingsRepositoryImpl({
    required this.localDataSource,
  });

  @override
  Future<void> updateThemeMode(ThemeMode themeMode) async {
    localDataSource.cacheThemeMode(themeMode);
  }

  @override
  Future<ThemeMode> loadThemeMode() async {
    final localThemeMode = await localDataSource.getLastThemeMode();
    return localThemeMode;
  }
}
