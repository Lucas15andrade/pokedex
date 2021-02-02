import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pokedex/app/modules/home/status/status_pokemon.dart';
import 'package:pokedex/app/modules/home/widgets/pokemon_tile_widget.dart';
import 'home_controller.dart';

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({Key key, this.title = "Home"}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ModularState<HomePage, HomeController> {
  final List<String> filtros = <String>["Sort by favorites"];
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBar(),
        body: SafeArea(
          child: NotificationListener<ScrollNotification>(
              onNotification: (ScrollNotification scrollInfo) {
            if (scrollInfo.metrics.pixels ==
                scrollInfo.metrics.maxScrollExtent) {
              controller.loadMorePokemons();
            }
          }, child: Observer(
            builder: (_) {
              switch (controller.statusPokemon) {
                case StatusPokemon.ERROR:
                  return error();
                  break;
                case StatusPokemon.SUCCESS:
                  return ListView(
                    children: [
                      header(),
                      pokemons(),
                      loadingMore(),
                    ],
                  );
                  break;
                default:
                  return Center(child: CircularProgressIndicator());
              }
            },
          )),
        ));
  }

  Widget pokemons() {
    return Column(
      children: controller.pokemons
          .map(
            (pokemon) => PokemonTileWidget(
              pokemon: pokemon,
              tap: () {
                controller.setPokemonFavorite(!pokemon.favorite, pokemon.id);
              },
            ),
          )
          .toList(),
    );
  }

  Widget header() {
    return Container(
      margin: EdgeInsets.only(left: 15, right: 15, top: 20, bottom: 20),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                  fillColor: Colors.black,
                  hintText: 'Enter a search pokemon name',
                  border: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black))),
            ),
          ),
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () async {
                await controller.searchPokemon(searchController.text.trim());
              }),
        ],
      ),
    );
  }

  Widget loadingMore() {
    return Observer(
      builder: (_) {
        switch (controller.loadMore) {
          case StatusPokemon.LOADING:
            return Container(
              margin: EdgeInsets.all(10),
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
            break;
          case StatusPokemon.ERROR:
            return Container(
              margin: EdgeInsets.all(10),
              child: Text("Algo deu errado :( "),
            );
            break;
          default:
            return Container();
        }
      },
    );
  }

  Widget error() {
    return Center(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Ocorreu um erro"),
        RaisedButton(
          onPressed: () async {
            controller.offset = 0;
            await controller.getAllPokemons();
          },
          child: Text("Tentar novamente"),
        ),
      ],
    ));
  }

  AppBar appBar() {
    return AppBar(
      backgroundColor: Colors.white,
      centerTitle: true,
      title: Text(
        "Pokédex",
        style: GoogleFonts.roboto(
            fontWeight: FontWeight.bold, fontSize: 33, color: Colors.black),
      ),
      actions: <Widget>[
        PopupMenuButton<String>(
          key: ValueKey('popupMenu'),
          onSelected: (escolha) {
            if (escolha == 'Sort by favorites') {
              controller.orderByFavorites();
            }
          },
          icon: Icon(
            Icons.sort,
            color: Colors.black,
          ),
          itemBuilder: (BuildContext context) {
            return filtros.map(
              (String opcao) {
                return PopupMenuItem<String>(
                  key: ValueKey(opcao),
                  value: opcao,
                  child: Text(opcao),
                );
              },
            ).toList();
          },
        )
      ],
    );
  }
}
