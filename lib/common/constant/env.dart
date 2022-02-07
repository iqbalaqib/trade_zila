import 'package:flutter/cupertino.dart';

class Env {

  Env(this.baseUrl, {@required this.mqttServer, @required this.mqttPort});
  final String baseUrl;
  final String mqttServer;
  final int mqttPort;
}

mixin EnvValue {
  static final Env development = Env('10.10.45.186', mqttServer: '10.10.45.186', mqttPort: 1883 );
  static final Env staging = Env('10.10.45.186');
  static final Env production = Env('10.10.45.186');
}
