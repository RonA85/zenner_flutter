
import 'package:get_it/get_it.dart';
import 'package:zenner_flutter/stores/dialog_store.dart';

final getIt = GetIt.instance;

Future<void> setupLocator() async {
  // stores:--------------------------------------------------------------------
  getIt.registerSingleton(DialogStore());
}
