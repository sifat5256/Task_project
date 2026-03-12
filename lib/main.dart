import 'package:flutter/material.dart';
import 'package:task_project/app/app.dart';
import 'package:task_project/di/injection_container.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(const App());
}
