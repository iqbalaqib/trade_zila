import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trade_zila/app/app.dart';
import 'package:trade_zila/common/bloc/simple_bloc_delegate.dart';
import 'package:trade_zila/common/connection/connection_helper.dart';
import 'package:trade_zila/common/constant/env.dart';

void main() {
  Bloc.observer = SimpleBlocDelegate();
  WidgetsFlutterBinding.ensureInitialized();

  ConnectionHelper().connectToMQTT(EnvValue.development);
  runZonedGuarded(() {
    runApp(App(env: EnvValue.development));
  }, (error, stackTrace) async {});
}
