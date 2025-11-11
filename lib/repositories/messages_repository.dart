import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb_auth;
import '../models/message.dart';

/// Repository that provides access to messages stored in Cloud Firestore.
class MessagesRepository {
  final FirebaseFirestore _firestore;
  final String collectionPath;

  MessagesRepository({
    FirebaseFirestore? firestore,
    this.collectionPath = 'messages',
  }) : _firestore = firestore ?? FirebaseFirestore.instance;

  /// Stream of messages ordered by timestamp ascending.
  Stream<List<Message>> messagesStream({int limit = 100}) {
    return _firestore
        .collection(collectionPath)
        .orderBy('timestamp', descending: false)
        .limit(limit)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((d) => Message.fromMap(d.id, d.data()))
              .toList(),
        );
  }

  /// Send a new message for the currently authenticated user.
  ///
  /// The method uses the provided [text] and the active Firebase user to
  /// create a message document. It returns the newly created document id.
  Future<String> sendMessage(String text) async {
    final user = fb_auth.FirebaseAuth.instance.currentUser;
    if (user == null) throw StateError('User not authenticated');

    final msg = Message(
      id: '',
      senderId: user.uid,
      senderEmail: user.email ?? user.uid,
      text: text,
      timestamp: DateTime.now(),
    );

    final docRef = await _firestore.collection(collectionPath).add(msg.toMap());
    return docRef.id;
  }
}
