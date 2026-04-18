import 'dart:ui';

class AppColors {
  // ── Brand (shared across both themes) ──────────────────────
  static const Color primaryColor = Color(0xFFBB9457);
  static const Color secondaryColor = Color(0xFFB89B5E);
  static const Color primaryLight = Color(0xFFD4B978);
  static const Color accentBrown = Color(0xFFB89F5D);
  static const Color hintColor = Color(0xFF8391A1);

  // ── Light palette ───────────────────────────────────────────
  static const Color lightBackground = Color(0xFFFDF6EC);
  static const Color lightFillColor = Color(0xFFF7F8F9);
  static const Color lightBorderColor = Color(0xFFE8ECF4);
  static const Color lightTextPrimary = Color(0xFF1E232C);
  static const Color lightTextColor = Color(0xFF2F2F2F);
  static const Color lightSubtitle = Color(0xFF6A707C);
  static const Color lightHint = Color(0xFF8391A1);
  static const Color lightGray = Color(0xFFE0E0E0);
  static const Color lightSecGray = Color(0xFF7F8C8D);
  static const Color lightDarkText = Color(0xFF333333);

  // ── Dark / Espresso palette ─────────────────────────────────
  static const Color darkBackground = Color(0xFF1C1410); // deep espresso
  static const Color darkSurface = Color(0xFF26201A); // card / sheet bg
  static const Color darkFillColor = Color(0xFF332B22); // input fill
  static const Color darkBorderColor = Color(0xFF3F3228); // input border
  static const Color darkTextPrimary = Color(0xFFF5ECD8); // warm parchment
  static const Color darkTextColor = Color(0xFFEADCC8); // body text
  static const Color darkSubtitle = Color(0xFFB8A090); // muted warm
  static const Color darkHint = Color(0xFF9C8870); // input hint
  static const Color darkGray = Color(0xFF3F3228); // dividers
  static const Color darkSecGray = Color(0xFF6B5A4A); // secondary gray
  // ── Universals ───────────────────────────────────────────────
  static const Color black = Color(0xFF000000);
  static const Color white = Color(0xFFFFFFFF);

  static Color? get secondaryGray => null;
}
