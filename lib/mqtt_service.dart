import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

class MqttService {
  late MqttServerClient client;

  MqttService() {
    // Génère un Client ID unique
    String clientId = 'client_${DateTime.now().millisecondsSinceEpoch}';

    // Initialise le client MQTT
    client = MqttServerClient('lb28a76a.ala.eu-central-1.emqxsl.com', clientId);
    client.port = 8883;
    client.secure = true;
    client.logging(on: true);
    client.keepAlivePeriod = 20;
    // client.onConnected = onConnected;
    client.onDisconnected = onDisconnected;
    client.onSubscribed = onSubscribed;
    client.pongCallback = pong;
  }

  Future<void> connect() async {
    try {
      await client.connect('test_appli', 'ZMaczfTu7');
      print("CONNECTED");
    } catch (e) {
      print('Erreur de connexion : $e');
      client.disconnect();
    }
  }

  void onConnected(String carVin) {
    print('Connecté à MQTT');
    client.subscribe('car/batteryStatus/$carVin', MqttQos.atMostOnce);
    client.subscribe('car/airConditioning/$carVin', MqttQos.atMostOnce);
  }

  void onDisconnected() {
    print('Déconnecté de MQTT');
  }

  void onSubscribed(String topic) {
    print('Abonné au sujet : $topic');
  }

  void pong() {
    print('Pong reçu de MQTT');
  }

  void listen(void Function(String message) onMessage) {
    client.updates?.listen((List<MqttReceivedMessage<MqttMessage>> c) {
      final MqttPublishMessage message = c[0].payload as MqttPublishMessage;
      final String payload = MqttPublishPayload.bytesToStringAsString(message.payload.message);
      onMessage(payload);
    });
  }

  void disconnect() {
    client.disconnect();
  }
}
