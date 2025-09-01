import 'package:breach/core/injections/injection.config.dart' as inject;
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

GetIt sl = GetIt.instance;

@InjectableInit(asExtension: false)
Future<void> configureDependencies() => inject.init(sl);
