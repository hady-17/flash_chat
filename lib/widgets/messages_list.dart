import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/message.dart';
import 'message_bubble.dart';

/// Widget that displays a scrollable list of messages.
///
/// Listens to a stream of messages and renders them as [MessageBubble]s.
/// The list is reversed so newest messages appear at the bottom.
class MessagesList extends StatelessWidget {
  final Stream<List<Message>> messagesStream;
  final String currentUserId;

  const MessagesList({
    super.key,
    required this.messagesStream,
    required this.currentUserId,
  });

  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser;
    final currentEmail = currentUser?.email ?? '';

    return StreamBuilder<List<Message>>(
      stream: messagesStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.lightBlueAccent,
            ),
          );
        }

        if (snapshot.hasError) {
          return Center(
            child: Text(
              'Error: ${snapshot.error}',
              style: const TextStyle(color: Colors.red),
            ),
          );
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(
            child: Text(
              'No messages yet. Start the conversation!',
              style: TextStyle(color: Colors.grey),
            ),
          );
        }

        final messages = snapshot.data!;

        return Expanded(
          child: ListView.builder(
            reverse: true,
            padding: const EdgeInsets.symmetric(
              horizontal: 10.0,
              vertical: 20.0,
            ),
            itemCount: messages.length,
            itemBuilder: (context, index) {
              // Reverse the order so newest messages are at the bottom
              final message = messages[messages.length - 1 - index];

              // Check if message is from current user
              // Support both uid-based (new) and email-based (old) comparison
              final isMe =
                  message.senderId == currentUserId ||
                  message.senderEmail == currentEmail;

              return MessageBubble(message: message, isMe: isMe);
            },
          ),
        );
      },
    );
  }
}
