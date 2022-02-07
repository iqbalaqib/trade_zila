import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:trade_zila/common/constant/env.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'dart:io';

class ConnectionManager {

  Env env;
  final String _TAG = "ConnectionManager";
  MqttServerClient _client = null;

  ConnectionManager({@required this.env});

  // ConnectionManager
  Future<MqttClient> connect() async {
    _client =
    MqttServerClient.withPort(env.mqttServer, 'flutter_client', env.mqttPort);
    _client.logging(on: true);
    _client.onConnected = onConnected;
    _client.onDisconnected = onDisconnected;
    _client.onUnsubscribed = onUnsubscribed;
    _client.onSubscribed = onSubscribed;
    _client.onSubscribeFail = onSubscribeFail;
    _client.pongCallback = pong;

    final connMess = MqttConnectMessage()
        .withClientIdentifier("flutter_client")
        .authenticateAs("test", "test")
        .keepAliveFor(60)
        .withWillTopic('willtopic')
        .withWillMessage('My Will message')
        .startClean()
        .withWillQos(MqttQos.atLeastOnce);
    _client.connectionMessage = connMess;
    try {
      print('Connecting');
      await _client.connect();
    } catch (e) {
      print('Exception: $e');
      _client.disconnect();
    }

    if (_client.connectionStatus.state == MqttConnectionState.connected) {
      log('${_TAG} _client connected');

      // MessageHander
      _client.updates.listen((List<MqttReceivedMessage<MqttMessage>> c) {
        final MqttPublishMessage message = c[0].payload;
        final payload =
        MqttPublishPayload.bytesToStringAsString(message.payload.message);

        print('From _client Received message:$payload from topic: ${c[0].topic}>');
      });

      _client.published.listen((MqttPublishMessage message) {
        print('published');
        final payload =
        MqttPublishPayload.bytesToStringAsString(message.payload.message);
        print(
            'From Client Published message: $payload to topic: ${message.variableHeader.topicName}');
      });
    } else {
      print(
          'EMQX _client connection failed - disconnecting, status is ${_client.connectionStatus}');
      _client.disconnect();
      exit(-1);
    }

    return _client;
  }


  void disconnect() {
    _client.disconnect();
  }

  void subscribeToTopic(String topic, MqttQos level) {
    _client.subscribe(topic, level);
  }

  void unSubscribeToTopic(String topic) {
    _client.unsubscribe(topic);
  }

  void onConnected() {
    print('Connected');
  }

  void onDisconnected() {
    print('Disconnected');
  }

  void onSubscribed(String topic) {
    print('Subscribed topic: $topic');
  }

  void onSubscribeFail(String topic) {
    print('Failed to subscribe topic: $topic');
  }

  void onUnsubscribed(String topic) {
    print('Unsubscribed topic: $topic');
  }

  void pong() {
    print('Ping response client callback invoked');
  }

}