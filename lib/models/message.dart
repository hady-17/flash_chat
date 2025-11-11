import 'package:cloud_firestore/cloud_firestore.dart';

/// Immutable message model used in the chat UI and repository.
class Message {
  final String id;
  final String senderId;
  final String senderEmail;
  final String text;
  final DateTime timestamp;

  const Message({
    required this.id,
    required this.senderId,
    required this.senderEmail,
    required this.text,
    required this.timestamp,
  });

  /// Construct a Message from a Firestore document snapshot or map.
  ///
  /// Supports both old format (sender field with email) and new format
  /// (senderId and senderEmail fields) for backwards compatibility.
  factory Message.fromMap(String id, Map<String, dynamic> map) {
    final ts = map['timestamp'];
    DateTime parsed;
    if (ts is Timestamp) {
      parsed = ts.toDate();
    } else if (ts is int) {
      parsed = DateTime.fromMillisecondsSinceEpoch(ts);
    } else if (ts is String) {
      parsed = DateTime.tryParse(ts) ?? DateTime.now();
    } else {
      parsed = DateTime.now();
    }

    // Handle backwards compatibility with old 'sender' field
    String senderId = map['senderId'] as String? ?? '';
    String senderEmail = map['senderEmail'] as String? ?? '';

    // If new fields are empty, try to get from old 'sender' field
    if (senderId.isEmpty && senderEmail.isEmpty) {
      final oldSender = map['sender'] as String? ?? '';
      senderEmail = oldSender;
      // For old messages, use email as both id and email since uid wasn't stored
      senderId = oldSender;
    }

    return Message(
      id: id,
      senderId: senderId,
      senderEmail: senderEmail,
      text: map['text'] as String? ?? '',
      timestamp: parsed,
    );
  }

  /// Convert this message to a map suitable for Firestore.
  Map<String, dynamic> toMap() => {
    'senderId': senderId,
    'senderEmail': senderEmail,
    'text': text,
    'timestamp': Timestamp.fromDate(timestamp),
  };
}
