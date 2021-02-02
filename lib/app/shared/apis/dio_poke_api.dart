import 'package:dio/dio.dart';
import 'package:pokedex/app/shared/constants.dart';

class DioPokeApi {
  Dio _dio;

  DioPokeApi() {
    _dio = Dio(BaseOptions(baseUrl: BASE_URL_POKE_API));
  }

  Dio get dio => _dio;
}
