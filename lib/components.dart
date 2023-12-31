import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SansText extends StatelessWidget {
  final text;
  final size;
  const SansText(this.text, this.size, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: GoogleFonts.openSans(
          fontSize: size, fontWeight: FontWeight.w300, color: Colors.white),
    );
  }
}

class TextBlack extends StatelessWidget {
  final text;
  final size;
  const TextBlack(this.text, this.size, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.openSans(
          fontSize: size, fontWeight: FontWeight.w300, color: Colors.black),
    );
  }
}

class TextForm extends StatelessWidget {
  final text;
  final containerWidth;
  final hintText;
  final controller;
  final validator;

  const TextForm(
  {Key? key,
  @required this.text,
  @required this.containerWidth,
  @required this.hintText,
  @required this.controller,
  @required this.validator})
  : super (key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 5.0),
        SizedBox(
          width: containerWidth,
          child: TextFormField(
            cursorColor: Colors.white,
            style: GoogleFonts.poppins(fontSize: 14.0, color: Colors.white),
            validator: validator,
            controller: controller,
            decoration: InputDecoration(
              errorBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red),
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              focusedErrorBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red),
                borderRadius: BorderRadius.all(Radius.circular(15.0)),
              ),
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.green),
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.lightGreen, width: 2.0),
                borderRadius: BorderRadius.all(Radius.circular(15.0)),
              ),
              hintText: hintText,
              hintStyle: GoogleFonts.poppins(fontSize: 14.0, color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}

class NavButton extends StatelessWidget {
  final text;
  final page;
  const NavButton(this.text, this.page, {Key? key}) : super(key: key);

  @override
Widget build(BuildContext context) {
    return SizedBox(
      height: 50.0,
      width: 200.0,
      child: MaterialButton(
        child: SansText(text, 25.0),
        splashColor: Colors.grey,
        color: Color(0XFF003049),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0)),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => page,),
          );
        },
      ),
    );
  }
}

