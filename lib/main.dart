import 'package:breach/app/view/app.dart';
import 'package:breach/bootstrap.dart';
import 'package:breach/core/core.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  await configureDependencies();
  await bootstrap(() => const App());
}


