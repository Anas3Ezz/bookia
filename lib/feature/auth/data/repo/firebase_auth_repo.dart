import 'package:bookia/core/networking/api_result.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

/// Handles all Firebase authentication (email/password + Google Sign-In).
/// For REST API auth, see [AuthRepo].
class FirebaseAuthRepo {
  FirebaseAuthRepo._();

  static final FirebaseAuthRepo instance = FirebaseAuthRepo._();

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  // ── Current user ──────────────────────────────────────────────────────────────

  User? get currentUser => _firebaseAuth.currentUser;

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  // ── Email / Password Sign In ──────────────────────────────────────────────────

  Future<ApiResult<UserCredential>> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      return ApiResult.success(credential);
    } on FirebaseAuthException catch (e) {
      return ApiResult.failure(_mapError(e));
    } catch (e) {
      return ApiResult.failure('An unexpected error occurred.');
    }
  }

  // ── Register ──────────────────────────────────────────────────────────────────

  Future<ApiResult<UserCredential>> createUserWithEmailAndPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      await credential.user?.updateDisplayName(name.trim());
      return ApiResult.success(credential);
    } on FirebaseAuthException catch (e) {
      return ApiResult.failure(_mapError(e));
    } catch (e) {
      return ApiResult.failure('An unexpected error occurred.');
    }
  }

  // ── Google Sign In ────────────────────────────────────────────────────────────

  /// Returns null inside [ApiResult.success] only when the user cancels
  /// the Google sign-in sheet — treat that as a no-op, not an error.
  Future<ApiResult<UserCredential?>> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      // User cancelled the picker — not an error
      if (googleUser == null) return const ApiResult.success(null);

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final oauthCredential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential = await _firebaseAuth.signInWithCredential(
        oauthCredential,
      );

      return ApiResult.success(userCredential);
    } on FirebaseAuthException catch (e) {
      return ApiResult.failure(_mapError(e));
    } catch (e) {
      return ApiResult.failure('Google sign-in failed. Please try again.');
    }
  }

  // ── Forgot Password ───────────────────────────────────────────────────────────

  Future<ApiResult<bool>> sendPasswordResetEmail({
    required String email,
  }) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email.trim());
      return const ApiResult.success(true);
    } on FirebaseAuthException catch (e) {
      return ApiResult.failure(_mapError(e));
    } catch (e) {
      return ApiResult.failure('Failed to send reset email. Try again.');
    }
  }

  // ── Sign Out ──────────────────────────────────────────────────────────────────

  Future<void> signOut() async {
    await Future.wait([_firebaseAuth.signOut(), _googleSignIn.signOut()]);
  }

  // ── Error mapping ─────────────────────────────────────────────────────────────

  static String _mapError(FirebaseAuthException e) {
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
}
