import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pokedex/app/models/pokemon.dart';
import 'package:pokedex/app/models/pokemon_detail.dart';
import 'package:pokedex/app/modules/home/widgets/pokemon_type_widget.dart';
import 'package:pokedex/app/shared/extensions/string_extension.dart';
import 'package:tinycolor/tinycolor.dart';

class PokemonTileWidget extends StatefulWidget {
  final Pokemon pokemon;
  final Function tap;

  const PokemonTileWidget({Key key, this.pokemon, this.tap}) : super(key: key);

  @override
  _PokemonTileWidgetState createState() => _PokemonTileWidgetState();
}

class _PokemonTileWidgetState extends State<PokemonTileWidget> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topRight,
      children: [
        Container(
            margin: EdgeInsets.fromLTRB(15, 10, 15, 15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient: LinearGradient(
                begin: FractionalOffset.topLeft,
                end: FractionalOffset.bottomRight,
                stops: [0.3, 0.6],
                colors: [
                  TinyColor(widget.pokemon.colorDominant).darken().color,
                  widget.pokemon.colorDominant
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: widget.pokemon.colorDominant.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 7,
                  offset: Offset(-2, 6),
                ),
              ],
            ),
            height: 120,
            child: Flex(
              direction: Axis.horizontal,
              children: [
                Container(
                  margin: EdgeInsets.only(left: 30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.pokemon.pokemonDetail.name.capcapitalize,
                        style: GoogleFonts.roboto(
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          fontSize: 25,
                        ),
                      ),
                      Row(
                        children: getTypesPokemon(
                            widget.pokemon.pokemonDetail.types,
                            widget.pokemon.colorDominant),
                      )
                    ],
                  ),
                ),
              ],
            )),
        Positioned(
          width: 120,
          right: 70,
          top: -10,
          height: 150,
          child: Image(image: widget.pokemon.image),
        ),
        Positioned(
            top: 10,
            right: 20,
            child: IconButton(
              icon: Observer(
                  name: "observer_favorite",
                  builder: (_) {
                    if (widget.pokemon.favorite) {
                      return Icon(
                        Icons.favorite,
                        size: 30,
                        color: Colors.red,
                      );
                    } else {
                      return Icon(
                        Icons.favorite,
                        size: 30,
                        color: Colors.white,
                      );
                    }
                  }),
              onPressed: widget.tap,
            ))
      ],
    );
  }

  List<Widget> getTypesPokemon(List<Types> types, Color color) {
    List<Widget> typesChips = [];

    if (types.length <= 2) {
      typesChips
        ..addAll(types
            .sublist(0, types.length)
            .map((e) => PokemonTypeWidget(
                  type: e.type.name,
                  color: color,
                ))
            .toList());
    } else {
      typesChips
        ..addAll(types
            .sublist(0, 2)
            .map((e) => PokemonTypeWidget(
                  type: e.type.name,
                  color: color,
                ))
            .toList());
      typesChips.add(Icon(Icons.more));
    }
    return typesChips;
  }
}
