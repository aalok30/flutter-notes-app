import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseManager {
  FirebaseManager._privateConstructor();

  static final FirebaseManager instance = FirebaseManager._privateConstructor();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // =========================
  // AUTHENTICATION
  // =========================

  User? get currentUser => _auth.currentUser;

  Stream<User?> authStateChanges() => _auth.authStateChanges();

  Future<User?> signUp({required String email, required String password}) async {
    final credential = await _auth.createUserWithEmailAndPassword(email: email.trim(), password: password.trim());
    return credential.user;
  }

  Future<User?> login({required String email, required String password}) async {
    final credential = await _auth.signInWithEmailAndPassword(email: email.trim(), password: password.trim());
    return credential.user;
  }

  Future<void> logout() async {
    await _auth.signOut();
  }

  // =========================
  // NOTES CRUD
  // =========================

  CollectionReference<Map<String, dynamic>> get _notesRef => _firestore.collection('notes');

  Future<void> createNote({required String title, required String content}) async {
    final user = currentUser;
    if (user == null) throw Exception('User not authenticated');

    final docRef = _notesRef.doc();

    await docRef.set({
      'id': docRef.id,
      'title': title,
      'content': content,
      'user_id': user.uid,
      'created_at': FieldValue.serverTimestamp(),
      'updated_at': FieldValue.serverTimestamp(),
    });
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getNotes() {
    final user = currentUser;
    if (user == null) {
      throw Exception('User not authenticated');
    }

    return _notesRef.where('user_id', isEqualTo: user.uid).orderBy('created_at', descending: true).snapshots();
  }

  Future<void> updateNote({required String noteId, required String title, required String content}) async {
    await _notesRef.doc(noteId).update({
      'title': title,
      'content': content,
      'updated_at': FieldValue.serverTimestamp(),
    });
  }

  Future<void> deleteNote(String noteId) async {
    await _notesRef.doc(noteId).delete();
  }

  // =========================
  // CLIENT-SIDE SEARCH (OPTION B)
  // =========================

  List<QueryDocumentSnapshot<Map<String, dynamic>>> searchNotes({
    required List<QueryDocumentSnapshot<Map<String, dynamic>>> notes,
    required String query,
  }) {
    if (query.isEmpty) return notes;

    return notes.where((doc) {
      final title = doc['title'].toString().toLowerCase();
      return title.contains(query.toLowerCase());
    }).toList();
  }
}
