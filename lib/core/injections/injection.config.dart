// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:breach/core/injections/register_module.dart' as _i463;
import 'package:breach/core/local_data/device_info/device_info.dart' as _i1070;
import 'package:breach/core/local_data/first_time_user/get_first_time.dart'
    as _i223;
import 'package:breach/core/local_data/first_time_user/save_first_time.dart'
    as _i868;
import 'package:breach/core/local_data/local_data.dart' as _i55;
import 'package:breach/core/local_data/user_data/secured_user_data.dart'
    as _i781;
import 'package:breach/core/local_data/user_token/get_user_logged_in_token.dart'
    as _i572;
import 'package:breach/core/local_data/user_token/set_user_logged_in_token.dart'
    as _i943;
import 'package:breach/core/navigation/navigation_service.dart' as _i940;
import 'package:breach/core/network/info/network_info.dart' as _i192;
import 'package:breach/core/utils/internet_safe_runner.dart' as _i69;
import 'package:breach/features/app_bottom_nav/presentation/state_management/app_bottom_nav_cubit.dart'
    as _i351;
import 'package:breach/features/authentication/data/data_sources/auth_data_source.dart'
    as _i689;
import 'package:breach/features/authentication/data/repositories/auth_repo_impl.dart'
    as _i6;
import 'package:breach/features/authentication/domain/repositories/auth_repo.dart'
    as _i220;
import 'package:breach/features/authentication/domain/use_cases/auth_use_case.dart'
    as _i506;
import 'package:breach/features/authentication/presentation/state_management/auth/auth_bloc.dart'
    as _i252;
import 'package:breach/features/blog/presentation/state_management/filter/filter_cubit.dart'
    as _i918;
import 'package:breach/features/blog/presentation/state_management/stream/web_socket_cubit.dart'
    as _i491;
import 'package:breach/features/home/data/data_sources/home_data_source.dart'
    as _i427;
import 'package:breach/features/home/data/reposiitories/home_repo_impl.dart'
    as _i99;
import 'package:breach/features/home/domain/repositories/home_repo.dart'
    as _i1057;
import 'package:breach/features/home/domain/use_cases/home_use_case.dart'
    as _i1027;
import 'package:breach/features/home/presentation/state_management/category/categories_cubit.dart'
    as _i874;
import 'package:breach/features/home/presentation/state_management/post/posts_cubit.dart'
    as _i176;
import 'package:breach/features/home/presentation/state_management/user_interests/user_interests_cubit.dart'
    as _i573;
import 'package:dart_ipify/dart_ipify.dart' as _i307;
import 'package:device_info_plus/device_info_plus.dart' as _i833;
import 'package:dio/dio.dart' as _i361;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i558;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart'
    as _i161;
import 'package:local_auth/local_auth.dart' as _i152;
import 'package:package_info_plus/package_info_plus.dart' as _i655;

// initializes the registration of main-scope dependencies inside of GetIt
Future<_i174.GetIt> init(
  _i174.GetIt getIt, {
  String? environment,
  _i526.EnvironmentFilter? environmentFilter,
}) async {
  final gh = _i526.GetItHelper(getIt, environment, environmentFilter);
  final registerModule = _$RegisterModule();
  gh.factory<_i152.LocalAuthentication>(
    () => registerModule.localAuthentication,
  );
  gh.factory<_i558.FlutterSecureStorage>(
    () => registerModule.flutterSecureStorage,
  );
  await gh.factoryAsync<_i655.PackageInfo>(
    () => registerModule.packageInfo,
    preResolve: true,
  );
  gh.factory<_i161.InternetConnection>(
    () => registerModule.internetConnectionChecker,
  );
  gh.factory<_i833.DeviceInfoPlugin>(() => registerModule.deviceInfoPlugin);
  gh.factory<_i307.Ipify>(() => registerModule.ipify);
  gh.lazySingleton<_i940.NavigationService>(() => _i940.NavigationService());
  gh.lazySingleton<_i351.AppBottomNavCubit>(() => _i351.AppBottomNavCubit());
  gh.lazySingleton<_i918.FilterCubit>(() => _i918.FilterCubit());
  gh.lazySingleton<_i192.NetworkInfo>(
    () => _i192.NetworkInfoImpl(gh<_i161.InternetConnection>()),
  );
  gh.lazySingleton<_i1070.DeviceInfo>(
    () => _i1070.DeviceInformation(
      gh<_i833.DeviceInfoPlugin>(),
      gh<_i307.Ipify>(),
    ),
  );
  gh.lazySingleton<_i223.GetFirstTime>(
    () => _i223.GetFirstTimeImpl(gh<_i558.FlutterSecureStorage>()),
  );
  gh.lazySingleton<_i781.SecuredUserData>(
    () => _i781.SecuredUserDataImpl(gh<_i558.FlutterSecureStorage>()),
  );
  gh.lazySingleton<_i572.GetLoggedInUserToken>(
    () => _i572.GetLoggedInUserTokenImpl(gh<_i558.FlutterSecureStorage>()),
  );
  gh.lazySingleton<_i868.SaveFirstTime>(
    () => _i868.SaveFirstTimeImpl(gh<_i558.FlutterSecureStorage>()),
  );
  gh.lazySingleton<_i252.AuthBloc>(
    () => _i252.AuthBloc(secureStorage: gh<_i558.FlutterSecureStorage>()),
  );
  gh.lazySingleton<_i943.SaveLoggedInUserToken>(
    () => _i943.SaveLoggedInUserTokenImpl(gh<_i558.FlutterSecureStorage>()),
  );
  gh.lazySingleton<_i361.Dio>(
    () => registerModule.dio(gh<_i192.NetworkInfo>()),
  );
  gh.lazySingleton<_i69.InternetSafeRunner>(
    () => registerModule.runner(gh<_i192.NetworkInfo>()),
  );
  gh.lazySingleton<_i491.WebSocketCubit>(
    () => _i491.WebSocketCubit(gh<_i55.GetLoggedInUserToken>()),
  );
  gh.lazySingleton<_i689.AuthRemoteDataSource>(
    () => _i689.AuthRemoteDataSourceImpl(
      dio: gh<_i361.Dio>(),
      networkInfo: gh<_i192.NetworkInfo>(),
      getLoggedInUserToken: gh<_i572.GetLoggedInUserToken>(),
      saveLoggedInUserToken: gh<_i943.SaveLoggedInUserToken>(),
      securedUserData: gh<_i781.SecuredUserData>(),
      internetSafeRunner: gh<_i69.InternetSafeRunner>(),
    ),
  );
  gh.lazySingleton<_i427.HomeRemoteDataSource>(
    () => _i427.HomeRemoteDataSourceImpl(
      dio: gh<_i361.Dio>(),
      networkInfo: gh<_i192.NetworkInfo>(),
      getLoggedInUserToken: gh<_i572.GetLoggedInUserToken>(),
      securedUserData: gh<_i781.SecuredUserData>(),
      internetSafeRunner: gh<_i69.InternetSafeRunner>(),
    ),
  );
  gh.lazySingleton<_i220.AuthRepository>(
    () => _i6.AuthRepoImpl(gh<_i689.AuthRemoteDataSource>()),
  );
  gh.lazySingleton<_i1057.HomeRepo>(
    () => _i99.HomeRepoImpl(gh<_i427.HomeRemoteDataSource>()),
  );
  gh.lazySingleton<_i506.AuthUseCase>(
    () => _i506.AuthUseCase(gh<_i220.AuthRepository>()),
  );
  gh.lazySingleton<_i1027.HomeUseCase>(
    () => _i1027.HomeUseCase(gh<_i1057.HomeRepo>()),
  );
  gh.lazySingleton<_i176.PostsCubit>(
    () => _i176.PostsCubit(gh<_i1027.HomeUseCase>()),
  );
  gh.lazySingleton<_i874.CategoriesCubit>(
    () => _i874.CategoriesCubit(gh<_i1027.HomeUseCase>()),
  );
  gh.lazySingleton<_i573.UserInterestsCubit>(
    () => _i573.UserInterestsCubit(gh<_i1027.HomeUseCase>()),
  );
  return getIt;
}

class _$RegisterModule extends _i463.RegisterModule {}
