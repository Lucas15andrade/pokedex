import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PokemonTypeWidget extends StatelessWidget {
  final String type;
  final Color color;

  const PokemonTypeWidget({Key key, this.type, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(3),
      margin: EdgeInsets.only(right: 3),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(3),
        color: color,
      ),
      child: Text(type,
          style: GoogleFonts.roboto(
            shadows: [
              BoxShadow(
                color: Colors.black,
                spreadRadius: 1,
                blurRadius: 3,
                offset: Offset(-2, 1),
              ),
            ],
            color: Colors.white,
          )),
    );
  }
}
