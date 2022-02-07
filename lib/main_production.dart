import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trade_zila/app/app.dart';
import 'package:trade_zila/common/bloc/simple_bloc_delegate.dart';
import 'package:trade_zila/common/constant/env.dart';

void main() {
  Bloc.observer = SimpleBlocDelegate();
  WidgetsFlutterBinding.ensureInitialized();

  runZonedGuarded(() {
    runApp(App(env: EnvValue.production));
  }, (error, stackTrace) async {});
}
