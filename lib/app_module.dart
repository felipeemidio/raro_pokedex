import 'package:flutter_modular/flutter_modular.dart';
import 'package:raro_pokedex/modules/home/home_module.dart';
import 'package:raro_pokedex/modules/login/login_module.dart';
import 'package:raro_pokedex/modules/login/pages/login_page.dart';
import 'package:raro_pokedex/modules/app/splash_page.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => [];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (context, args) => SplashPage()),
        ModuleRoute('/login', module: LoginModule()),
        ModuleRoute('/home', module: HomeModule()),
      ];
}
