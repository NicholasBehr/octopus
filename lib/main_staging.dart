import 'package:api_auth_firebase/api_auth_firebase.dart';
import 'package:api_data_firestore/api_data_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';
import 'package:octopus/app/app.dart';
import 'package:octopus/bootstrap.dart';
import 'package:octopus/firebase_options_dev.dart';
import 'package:repository_user/repository_user.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  /// data layer
  final apiAuth = ApiAuthFirebase();
  final apiData = ApiDataFirestore();

  /// domain layer
  final repositoryUser = RepositoryUser(apiAuth: apiAuth, apiData: apiData);

  /// feature layer
  await bootstrap(
    () => App(
      repositoryUser: repositoryUser,
    ),
  );
}
