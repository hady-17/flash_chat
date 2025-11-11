import 'package:flutter/material.dart';
import '../constants.dart';

/// Widget for the message input field and send button.
///
/// Provides a text field for typing messages and a send button.
/// Calls [onSendPressed] with the message text when send is pressed.
class MessageInput extends StatefulWidget {
  final void Function(String text) onSendPressed;

  const MessageInput({super.key, required this.onSendPressed});

  @override
  State<MessageInput> createState() => _MessageInputState();
}

class _MessageInputState extends State<MessageInput> {
  final TextEditingController _controller = TextEditingController();
  String _messageText = '';

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleSend() {
    final text = _messageText.trim();
    if (text.isEmpty) return;

    widget.onSendPressed(text);
    _controller.clear();
    setState(() {
      _messageText = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: kMessageContainerDecoration,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: TextField(
              controller: _controller,
              onChanged: (value) {
                setState(() {
                  _messageText = value;
                });
              },
              onSubmitted: (_) => _handleSend(),
              decoration: kMessageTextFieldDecoration,
            ),
          ),
          TextButton(
            onPressed: _handleSend,
            child: const Text('Send', style: kSendButtonTextStyle),
          ),
        ],
      ),
    );
  }
}
