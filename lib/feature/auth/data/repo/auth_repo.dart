import 'package:bookia/core/helper/error_handler.dart';
import 'package:bookia/core/helper/storge_services.dart';
import 'package:bookia/core/networking/api_constants.dart';
import 'package:bookia/core/networking/api_result.dart';
import 'package:bookia/core/networking/dio_factory.dart';
import 'package:bookia/core/networking/fire_store_service.dart';
import 'package:bookia/feature/auth/data/models/user_model.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

//TODO: REFACTOR THIS CLASS TO BE MORE CLEAN AND TESTABLE
class AuthRepo {
  AuthRepo._();

  static final AuthRepo instance = AuthRepo._();

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirestoreService _firestoreService = FirestoreService.instance;

  // ── Current user ──────────────────────────────────────────────────────────────

  User? get currentUser => _firebaseAuth.currentUser;

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  // ── Email Sign In ─────────────────────────────────────────────────────────────

  Future<UserCredential> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    return await _firebaseAuth.signInWithEmailAndPassword(
      email: email.trim(),
      password: password.trim(),
    );
  }

  // ── Register ──────────────────────────────────────────────────────────────────

  /// Creates the Firebase Auth account, updates the display name,
  /// then saves the user document to Firestore.
  Future<UserCredential> createUserWithEmailAndPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    final credential = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email.trim(),
      password: password.trim(),
    );

    // Update display name on Firebase Auth
    await credential.user?.updateDisplayName(name.trim());

    // Save to Firestore
    final user = UserModel(
      uid: credential.user!.uid,
      name: name.trim(),
      email: email.trim(),
      createdAt: DateTime.now(),
    );
    await _firestoreService.addUser(user);

    return credential;
  }

  // ── Google Sign In ────────────────────────────────────────────────────────────

  /// Signs in with Google. If this is a new user (first time),
  /// saves their profile to Firestore automatically.
  Future<UserCredential?> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    if (googleUser == null) return null;

    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final userCredential = await _firebaseAuth.signInWithCredential(credential);

    // Only save to Firestore if this is a brand new user
    if (userCredential.additionalUserInfo?.isNewUser == true) {
      final user = UserModel(
        uid: userCredential.user!.uid,
        name: userCredential.user?.displayName ?? 'User',
        email: userCredential.user?.email ?? '',
        createdAt: DateTime.now(),
      );
      await _firestoreService.addUser(user);
    }

    return userCredential;
  }

  // ── Forgot Password ───────────────────────────────────────────────────────────

  Future<void> sendPasswordResetEmail({required String email}) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email.trim());
  }

  // ── Sign Out ──────────────────────────────────────────────────────────────────

  Future<void> signOut() async {
    await Future.wait([_firebaseAuth.signOut(), _googleSignIn.signOut()]);
  }

  // ── Error Handling ────────────────────────────────────────────────────────────

  static String getErrorMessage(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        return 'No account found with this email.';
      case 'wrong-password':
        return 'Incorrect password. Please try again.';
      case 'email-already-in-use':
        return 'An account already exists with this email.';
      case 'invalid-email':
        return 'Please enter a valid email address.';
      case 'weak-password':
        return 'Password must be at least 6 characters.';
      case 'user-disabled':
        return 'This account has been disabled.';
      case 'too-many-requests':
        return 'Too many attempts. Please try again later.';
      case 'network-request-failed':
        return 'Network error. Check your connection.';
      case 'invalid-credential':
        return 'Invalid credentials. Please try again.';
      default:
        return e.message ?? 'An unexpected error occurred.';
    }
  }

  static Future<ApiResult<bool>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await DioFactory.dio?.post(
        ApiConstants.loginEndpoint,
        data: {"email": email, "password": password},
      );
      if (response?.statusCode == 200) {
        final token = response?.data['data']['token'] as String? ?? '';
        debugPrint('>>> token: $token');
        await StorageService.saveToken(token);
        DioFactory.updateToken(token);
        return const ApiResult.success(true);
      }
      return const ApiResult.failure('Login failed. Please try again.');
    } on DioException catch (e) {
      return ApiResult.failure(ErrorHandler.handle(e));
    }
  }

  static Future<ApiResult<bool>> register({
    required String email,
    required String password,
    required String passwordConfirmation,
    required String name,
  }) async {
    try {
      final response = await DioFactory.dio?.post(
        ApiConstants.registerEndpoint,
        data: {
          "name": name,
          "email": email,
          "password": password,
          "password_confirmation": passwordConfirmation,
        },
      );
      if (response?.statusCode == 201) {
        final token = response?.data['data']['token'] as String? ?? '';
        debugPrint('>>> register token: $token');
        await StorageService.saveToken(token);
        DioFactory.updateToken(token);
        return const ApiResult.success(true);
      }
      return const ApiResult.failure('Registration failed. Please try again.');
    } on DioException catch (e) {
      return ApiResult.failure(ErrorHandler.handle(e));
    }
  }

  static Future<void> logout() async {
    await StorageService.removeToken();
    DioFactory.dio?.options.headers.remove('Authorization');
  }
}
