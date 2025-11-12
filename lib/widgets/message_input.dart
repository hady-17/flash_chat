import 'package:flutter/material.dart';

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
    final cs = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: cs.primary, width: 2.0)),
      ),
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
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 10.0,
                  horizontal: 20.0,
                ),
                hintText: 'Type your message here...',
                hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(
                    context,
                  ).colorScheme.onSurface.withOpacity(0.6),
                ),
                border: InputBorder.none,
              ),
            ),
          ),
          TextButton(
            onPressed: _handleSend,
            style: TextButton.styleFrom(foregroundColor: cs.primary),
            child: Text(
              'Send',
              style: TextStyle(
                color: cs.primary,
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
