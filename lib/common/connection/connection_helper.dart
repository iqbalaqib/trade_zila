
import 'package:trade_zila/common/connection/manager/connection_manager.dart';
import 'package:trade_zila/common/constant/env.dart';
import 'package:mqtt_client/mqtt_client.dart';

class ConnectionHelper {

  bool reachAble = false;
  double signalStrength = 0.0;
  String carrierType = null;
  ConnectionManager _connectionManager = null;


  static final ConnectionHelper _connectionHelper = ConnectionHelper._getInstance();

  factory ConnectionHelper() {
    return _connectionHelper;
  }

  ConnectionHelper._getInstance();

  bool getInternetReachablity() {}
  double getSingnalStrength() {}

  void connectToMQTT(Env env) {
    _connectionManager = ConnectionManager(env: env);
    _connectionManager.connect();

  }
  void disconnectFromQTT() {

   if(_connectionManager == null) {
     throw "MQTT client not connected";
   }

   _connectionManager.disconnect();
  }

  void subscribeMQTTTopic(String topic, MqttQos level) {

    if(_connectionManager == null) {
      throw "MQTT client not connected";
    }

    _connectionManager.subscribeToTopic(topic, level);
  }
  void unsubscribeMQTTTopic(String topic) {

    if(_connectionManager == null) {
      throw "MQTT client not connected";
    }
    _connectionManager.unSubscribeToTopic(topic);
  }

  void connectionLost() {}
}



