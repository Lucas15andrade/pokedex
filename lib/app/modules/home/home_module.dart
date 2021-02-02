import 'package:pokedex/app/modules/home/repositories/pokemon_repository.dart';
import 'package:pokedex/app/modules/home/repositories/pokemon_repository_imp.dart';
import 'package:pokedex/app/modules/home/services/pokemon_service.dart';

import 'home_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'home_page.dart';

class HomeModule extends ChildModule {
  @override
  List<Bind> get binds => [
        $HomeController,
        Bind<PokemonRepository>((i) => PokemonRepositoryImp(i.get())),
        Bind((i) => PokemonService(i.get())),
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(Modular.initialRoute, child: (_, args) => HomePage()),
      ];

  static Inject get to => Inject<HomeModule>.of();
}
