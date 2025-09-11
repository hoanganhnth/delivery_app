import 'package:flutter/material.dart';
import '../../core/network/socket/stomp_socket_service.dart';
import '../../core/network/socket/websocket_service.dart';

/// Example page để test cả STOMP và WebSocket service mới
class SimpleSocketExamplePage extends StatefulWidget {
  const SimpleSocketExamplePage({Key? key}) : super(key: key);

  @override
  State<SimpleSocketExamplePage> createState() => _SimpleSocketExamplePageState();
}

class _SimpleSocketExamplePageState extends State<SimpleSocketExamplePage> {
  final StompManager stompManager = StompManager();
  final SocketManager socketManager = SocketManager();
  
  final List<String> _messages = [];
  final TextEditingController _messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _setupConnections();
  }

  void _setupConnections() {
    // Kết nối STOMP
    stompManager.connect(
      'delivery-stomp',
      'ws://localhost:61613/stomp',
      username: 'guest',
      password: 'guest',
    );

    // Kết nối WebSocket
    socketManager.connect(
      'location-ws',
      'ws://localhost:3002/location',
    );

    // Lắng nghe STOMP messages
    stompManager.listen('delivery-stomp')?.listen((data) {
      setState(() {
        _messages.add('📩 STOMP [${data['topic']}]: ${data['body']}');
      });
    });

    // Lắng nghe WebSocket messages
    socketManager.listen('location-ws')?.listen((message) {
      setState(() {
        _messages.add('📩 WebSocket: $message');
      });
    });

    // Subscribe STOMP topic
    Future.delayed(Duration(seconds: 2), () {
      stompManager.subscribe('delivery-stomp', '/topic/delivery/updates');
      stompManager.subscribe('delivery-stomp', '/topic/notifications');
    });
  }

  @override
  void dispose() {
    stompManager.disconnectAll();
    socketManager.disconnectAll();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Simple Socket Services'),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          // Connection Status
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            color: Colors.grey.shade100,
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: _buildConnectionStatus(
                        'STOMP',
                        stompManager.isConnected('delivery-stomp'),
                        Icons.message,
                        Colors.blue,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: _buildConnectionStatus(
                        'WebSocket',
                        true, // WebSocket không có isConnected method trong ví dụ
                        Icons.wifi,
                        Colors.purple,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                
                // Controls
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          _sendStompMessage();
                        },
                        icon: const Icon(Icons.send),
                        label: const Text('Send STOMP'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          _sendWebSocketMessage();
                        },
                        icon: const Icon(Icons.wifi),
                        label: const Text('Send WebSocket'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.purple,
                          foregroundColor: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Message Input
          Container(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: const InputDecoration(
                      hintText: 'Nhập message...',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  onPressed: _clearMessages,
                  icon: const Icon(Icons.clear),
                  tooltip: 'Clear messages',
                ),
              ],
            ),
          ),

          // Messages List
          Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(8),
              ),
              child: _messages.isEmpty
                  ? const Center(
                      child: Text(
                        'Chưa có message nào...\nKết nối và gửi thử!',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.grey),
                      ),
                    )
                  : ListView.builder(
                      itemCount: _messages.length,
                      itemBuilder: (context, index) {
                        final message = _messages[index];
                        final isStormp = message.contains('STOMP');
                        
                        return Container(
                          margin: const EdgeInsets.symmetric(vertical: 2),
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: isStormp 
                              ? Colors.blue.withOpacity(0.1)
                              : Colors.purple.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(
                              color: isStormp ? Colors.blue : Colors.purple,
                              width: 0.5,
                            ),
                          ),
                          child: Text(
                            message,
                            style: const TextStyle(
                              fontFamily: 'monospace',
                              fontSize: 12,
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ),

          // Connection Info
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            color: Colors.grey.shade50,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'STOMP Connections: ${stompManager.getConnections().length}',
                  style: const TextStyle(fontSize: 12),
                ),
                if (stompManager.getConnections().isNotEmpty)
                  Text(
                    'STOMP Subscriptions: ${stompManager.getSubscriptions('delivery-stomp').length}',
                    style: const TextStyle(fontSize: 12),
                  ),
                const Text(
                  'WebSocket: location-ws',
                  style: TextStyle(fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConnectionStatus(String title, bool isConnected, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isConnected ? color.withOpacity(0.1) : Colors.red.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isConnected ? color : Colors.red,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            isConnected ? icon : Icons.error,
            color: isConnected ? color : Colors.red,
            size: 20,
          ),
          const SizedBox(width: 8),
          Column(
            children: [
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: isConnected ? color : Colors.red,
                ),
              ),
              Text(
                isConnected ? 'Connected' : 'Disconnected',
                style: TextStyle(
                  fontSize: 12,
                  color: isConnected ? Colors.green : Colors.red,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _sendStompMessage() {
    final message = _messageController.text.trim();
    if (message.isEmpty) return;

    stompManager.send(
      'delivery-stomp',
      '/app/message',
      message,
      headers: {'timestamp': DateTime.now().millisecondsSinceEpoch.toString()},
    );

    setState(() {
      _messages.add('📤 STOMP Sent: $message');
    });

    _messageController.clear();
  }

  void _sendWebSocketMessage() {
    final message = _messageController.text.trim();
    if (message.isEmpty) return;

    final locationData = {
      'type': 'location',
      'message': message,
      'timestamp': DateTime.now().millisecondsSinceEpoch,
      'lat': 10.762622,
      'lng': 106.660172,
    };

    socketManager.sendRaw('location-ws', locationData.toString());

    setState(() {
      _messages.add('📤 WebSocket Sent: $message');
    });

    _messageController.clear();
  }

  void _clearMessages() {
    setState(() {
      _messages.clear();
    });
  }
}
