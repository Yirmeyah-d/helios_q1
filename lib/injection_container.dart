import 'package:get_it/get_it.dart';
import 'package:flutter/material.dart';
import 'package:helios_q1/src/core/network/network_info.dart';
import 'package:helios_q1/src/features/paginated_list/data/data_sources/paginated_list_local_data_source.dart';
import 'package:helios_q1/src/features/paginated_list/data/data_sources/paginated_list_remote_data_source.dart';
import 'package:helios_q1/src/features/paginated_list/data/repositories/paginated_list_repository_impl.dart';
import 'package:helios_q1/src/features/paginated_list/domain/repositories/paginated_list_repository.dart';
import 'package:helios_q1/src/features/paginated_list/domain/use_cases/fetch_next_result_page.dart';
import 'package:helios_q1/src/features/paginated_list/presentation/bloc/paginated_list_bloc.dart';
import 'package:helios_q1/src/features/settings/data/data_sources/settings_local_data_source.dart';
import 'package:helios_q1/src/features/settings/data/repositories/settings_repository_impl.dart';
import 'package:helios_q1/src/features/settings/domain/repositories/settings_repository.dart';
import 'package:helios_q1/src/features/settings/domain/use_cases/load_theme_mode.dart';
import 'package:helios_q1/src/features/settings/domain/use_cases/update_theme_mode.dart';
import 'package:helios_q1/src/features/settings/presentation/bloc/settings_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';

final serviceLocator = GetIt.instance;

Future<void> init() async {
  //! Features - Country
  //Bloc
  serviceLocator.registerFactory(
    () => PaginatedListBloc(
      networkInfo: serviceLocator(),
      fetchNextResultsPage: serviceLocator(),
    ),
  );
  // Use cases
  serviceLocator
      .registerLazySingleton(() => FetchNextResultsPage(serviceLocator()));

  // Repository
  serviceLocator.registerLazySingleton<PaginatedListRepository>(
    () => PaginatedListRepositoryImpl(
      remoteDataSource: serviceLocator(),
      localDataSource: serviceLocator(),
      networkInfo: serviceLocator(),
    ),
  );
  // Data Sources
  serviceLocator.registerLazySingleton<PaginatedListRemoteDataSource>(
    () => PaginatedListRemoteDataSourceImpl(
      dio: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton<PaginatedListLocalDataSource>(
    () => PaginatedListLocalDataSourceImpl(
      sharedPreferences: serviceLocator(),
    ),
  );

  //! Features - Settings
  //Bloc
  serviceLocator.registerFactory(
    () => SettingsBloc(
      loadThemeMode: serviceLocator(),
      updateThemeMode: serviceLocator(),
    ),
  );
  // Use cases
  serviceLocator.registerLazySingleton(() => UpdateThemeMode(serviceLocator()));
  serviceLocator.registerLazySingleton(() => LoadThemeMode(serviceLocator()));

  // Repository
  serviceLocator.registerLazySingleton<SettingsRepository>(
    () => SettingsRepositoryImpl(
      localDataSource: serviceLocator(),
    ),
  );
  // Data Sources
  serviceLocator.registerLazySingleton<SettingsLocalDataSource>(
    () => SettingsLocalDataSourceImpl(
      sharedPreferences: serviceLocator(),
    ),
  );

  //! Core
  serviceLocator.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(
      serviceLocator(),
    ),
  );

  //! External
  WidgetsFlutterBinding.ensureInitialized();
  final sharedPreferences = await SharedPreferences.getInstance();
  serviceLocator.registerLazySingleton(() => sharedPreferences);
  serviceLocator.registerLazySingleton(() => Dio());
  serviceLocator.registerLazySingleton(() => InternetConnectionChecker());
}
