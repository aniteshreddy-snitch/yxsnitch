import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';

const yelloColor = Color.fromARGB(255, 239, 239, 197);

const greenColor = Color.fromARGB(255, 214, 255, 216);

const kbaseURL = 'http://127.0.0.1:8000/api/';

Widget mainHeader(String heading) {
  return Container(
      margin: const EdgeInsets.all(20),
      child: Text(heading,
          style: const TextStyle(
              fontSize: 36,
              letterSpacing: 2,
              wordSpacing: 6,
              fontWeight: FontWeight.bold,
              height: 2)));
}


TextStyle kLoginTitleStyle(Size size) => GoogleFonts.ubuntu(
      fontSize: size.height * 0.060,
      fontWeight: FontWeight.bold,
    );

TextStyle kLoginSubtitleStyle(Size size) => GoogleFonts.ubuntu(
      fontSize: size.height * 0.030,
    );

TextStyle kLoginTermsAndPrivacyStyle(Size size) =>
    GoogleFonts.ubuntu(fontSize: 15, color: Colors.grey, height: 1.5);

TextStyle kHaveAnAccountStyle(Size size) =>
    GoogleFonts.ubuntu(fontSize: size.height * 0.022, color: Colors.black);

TextStyle kLoginOrSignUpTextStyle(
  Size size,
) =>
    GoogleFonts.ubuntu(
      fontSize: size.height * 0.022,
      fontWeight: FontWeight.w500,
      color: Colors.deepPurpleAccent,
    );

Widget mainSVGasset(Size size) {
  return Expanded(
    flex: 3,
    child: SvgPicture.asset(
      'assets/SnitchShield.svg',
      height: size.height * 0.5,
      width: double.infinity,

      // fit: BoxFit.fill,
    ),
  );
}
