import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as status;

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController _controller = TextEditingController();

  void initWebSocket() async {
    final wsUrl = Uri.parse('ws://localhost:4040/ws');
    final channel = WebSocketChannel.connect(wsUrl);
    await channel.ready;
    //channel.sink.add("Hello");
    channel.stream.listen((message) {
      print(message);
      channel.sink.add('hello from client');
      channel.sink.close(status.goingAway);
    });
  }

  @override
  void initState() {
    initWebSocket();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Form(
                child: TextFormField(
                  controller: _controller,
                  decoration: InputDecoration(labelText: 'Send a message'),
                ),
              ),
              Text(""),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {}, // _sendMessage,
          tooltip: 'Send message',
          child: Icon(Icons.send),
        ));
  }
}
