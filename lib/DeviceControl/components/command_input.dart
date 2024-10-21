import 'package:flutter/material.dart';

class CommandInputWidget extends StatefulWidget {
  const CommandInputWidget({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CommandInputWidgetState createState() => _CommandInputWidgetState();
}

class _CommandInputWidgetState extends State<CommandInputWidget> {
  final TextEditingController _controller = TextEditingController();
  String _displayText = '';

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _sendCommand() {
    setState(() {
      _displayText = _controller.text;
      _controller.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Container(
          width: constraints.maxWidth,
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // Input field and send button
              Row(
                children: [
                  Expanded(
                    // width: 150,
                    child: TextField(
                      controller: _controller,
                      decoration: const InputDecoration(
                        hintText: 'Enter your Command',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: _sendCommand,
                    child: const Text('Send'),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                height: 200,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text(
                  _displayText,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
