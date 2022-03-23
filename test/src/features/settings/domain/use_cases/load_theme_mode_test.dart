import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:helios_q1/src/core/use_case/use_case.dart';
import 'package:helios_q1/src/features/settings/domain/repositories/settings_repository.dart';
import 'package:helios_q1/src/features/settings/domain/use_cases/load_theme_mode.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'load_theme_mode_test.mocks.dart';

@GenerateMocks([SettingsRepository])
void main() {
  // initialization outside of setUp
  final mockSettingsRepository = MockSettingsRepository();
  final useCase = LoadThemeMode(mockSettingsRepository);
  const tThemeMode = ThemeMode.dark;

  test(
    'should get the theme mode from the repository',
    () async {
      //arrange
      when(mockSettingsRepository.loadThemeMode())
          .thenAnswer((_) async => tThemeMode);
      // act
      final result = await useCase(NoParams());
      // assert
      expect(result, tThemeMode);
      verify(mockSettingsRepository.loadThemeMode());
      verifyNoMoreInteractions(mockSettingsRepository);
    },
  );
}
