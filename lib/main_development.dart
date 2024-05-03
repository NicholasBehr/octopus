import 'package:auth_api/auth_api.dart';
import 'package:auth_repository/auth_repository.dart';
import 'package:data_api/data_api.dart';
import 'package:data_repository/data_repository.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';
import 'package:octopus/app/app.dart';
import 'package:octopus/bootstrap.dart';
import 'package:octopus/firebase_options_dev.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  /// data layer
  final authApi = AuthApi();
  final dataApi = DataApi();

  /// domain layer
  final authRepository = AuthRepository(authApi: authApi);
  final dataRepository = DataRepository(dataApi: dataApi);

  /// feature layer
  await bootstrap(
    () => App(
      authRepository: authRepository,
      dataRepository: dataRepository,
    ),
  );
}
