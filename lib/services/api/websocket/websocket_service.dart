import 'package:web_socket_channel/io.dart';

class WebsocketService {
  final IOWebSocketChannel channel;

  WebsocketService(String url) : channel = IOWebSocketChannel.connect(url);

  Stream<dynamic> get stream => channel.stream;

  void send(dynamic message) {
    channel.sink.add(message);
  }

  void dispose(){
    channel.sink.close();
  }
}