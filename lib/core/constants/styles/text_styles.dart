import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextStyles {
  static final ubuntu = GoogleFonts.ubuntu();

  // Naming convention: [fontFamily]_[fontSize]_[color with last 2 digits]_[fontWeight]

  static final TextStyle ubuntu32black24w2900 = ubuntu.copyWith(
    fontSize: 32,
    fontWeight: FontWeight.w900,
    color: const Color(0xFF131515),
  );
  static final TextStyle ubuntu32blue24w2900 = ubuntu.copyWith(
    fontSize: 32,
    fontWeight: FontWeight.w900,
    color: const Color(0xFF1F8386),
  );
  static final TextStyle ubuntu16black55w400 = ubuntu.copyWith(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: const Color(0xFF555555),
  );
  static final TextStyle ubuntu16black23w700 = ubuntu.copyWith(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: const Color(0xFF191D23),
  );
  static final TextStyle ubuntu12blue23w500 = ubuntu.copyWith(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: const Color(0xFF1F8386),
  );
  static final TextStyle ubuntu16black23w300 = ubuntu.copyWith(
    fontSize: 16,
    fontWeight: FontWeight.w300,
    color: const Color(0xFF191D23),
  );
  static final TextStyle ubuntu16whiteFFw500 = ubuntu.copyWith(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: const Color(0xFFFFFFFF),
  );
  static final TextStyle ubuntu16black23w400 = ubuntu.copyWith(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: const Color(0xFF191D23),
  );
  static final TextStyle ubuntu16blue86w400 = ubuntu.copyWith(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: const Color(0xFF1F8386),
  );
  static final TextStyle ubuntu16blue86w500 = ubuntu.copyWith(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: const Color(0xFF1F8386),
  );
  static final TextStyle ubuntu16blue86w600 = ubuntu.copyWith(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: const Color(0xFF1F8386),
  );
  static final TextStyle ubuntu32blue86w700 = ubuntu.copyWith(
    fontSize: 32,
    fontWeight: FontWeight.w700,
    color: const Color(0xFF1F8386),
  );
  static final TextStyle rubik16w2700 = ubuntu.copyWith(
    fontSize: 16,
    fontWeight: FontWeight.w700,
  );

  static final TextStyle ubuntu16whitew2700 = ubuntu.copyWith(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: const Color(0xFFFFFFFF),
  );
  static final TextStyle ubuntu14whitew2700 = ubuntu.copyWith(
    fontSize: 14,
    fontWeight: FontWeight.w700,
    color: const Color(0xFFFFFFFF),
  );
}
