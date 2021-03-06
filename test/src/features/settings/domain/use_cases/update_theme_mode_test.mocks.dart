// Mocks generated by Mockito 5.1.0 from annotations
// in helios_q1/test/src/features/settings/domain/use_cases/update_theme_mode_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i3;

import 'package:flutter/material.dart' as _i4;
import 'package:helios_q1/src/features/settings/domain/repositories/settings_repository.dart'
    as _i2;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

/// A class which mocks [SettingsRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockSettingsRepository extends _i1.Mock
    implements _i2.SettingsRepository {
  MockSettingsRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.Future<void> updateThemeMode(_i4.ThemeMode? themeMode) =>
      (super.noSuchMethod(Invocation.method(#updateThemeMode, [themeMode]),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i3.Future<void>);
  @override
  _i3.Future<_i4.ThemeMode> loadThemeMode() =>
      (super.noSuchMethod(Invocation.method(#loadThemeMode, []),
              returnValue: Future<_i4.ThemeMode>.value(_i4.ThemeMode.system))
          as _i3.Future<_i4.ThemeMode>);
}
