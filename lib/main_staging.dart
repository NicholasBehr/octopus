import 'package:auth_repository/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_api/firebase_auth_api.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';
import 'package:octopus/app/app.dart';
import 'package:octopus/bootstrap.dart';
import 'package:octopus/firebase_options_dev.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  /// data layer
  final authApi = FirebaseAuthApi(firebaseAuth: FirebaseAuth.instance);

  /// domain layer
  final authRepository = AuthRepository(authApi: authApi);

  /// feature layer
  await bootstrap(
    () => App(authRepository: authRepository),
  );
}
