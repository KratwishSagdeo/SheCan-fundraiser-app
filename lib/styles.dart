import 'package:flutter/material.dart';

// Color Palette
const Color kPrimaryColor = Color(0xFF4E89AE);
const Color kAccentColor = Color(0xFFED6663);
const Color kLightSkin = Color(0xFFFBE9E7);
const Color kInputFillColor = Color(0xFFF1F3F6);
const double kPadding = 20.0;

// Background Image Decoration (use this globally)
final BoxDecoration kGradientBackground = BoxDecoration(
  image: DecorationImage(
    image: AssetImage('assets/images/img.png'), // <-- ensure this path is correct
    fit: BoxFit.cover,
  ),
);

// Glassmorphism Container Decoration (for cards/sections)
BoxDecoration glassContainerDecoration = BoxDecoration(
  color: Colors.white.withOpacity(0.25),
  borderRadius: BorderRadius.circular(20),
  border: Border.all(color: Colors.white.withOpacity(0.2)),
  boxShadow: [
    BoxShadow(
      color: Colors.black12,
      blurRadius: 10,
      offset: Offset(0, 4),
    ),
  ],
);

// TextStyle Shortcut for Headings
TextStyle kHeadingStyle = TextStyle(
  fontSize: 26,
  fontWeight: FontWeight.bold,
  color: Colors.white,
);

// TextStyle Shortcut for Section Titles
TextStyle kSectionTitleStyle = TextStyle(
  fontSize: 20,
  fontWeight: FontWeight.w600,
  color: Colors.white,
);

// ButtonStyle Shortcut
ButtonStyle kPrimaryButtonStyle = ElevatedButton.styleFrom(
  backgroundColor: kPrimaryColor,
  padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(12),
  ),
);
