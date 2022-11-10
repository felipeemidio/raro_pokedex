import 'package:dio/dio.dart';
import 'package:raro_pokedex/core/entites/http_response.dart';
import 'package:raro_pokedex/core/drivers/http/client_http.dart';

class DioClientHttp implements ClientHttp {
  @override
  Future<HttpResponse> get(
      {required String url, Map<String, dynamic>? params}) async {
    var dio = Dio();
    final response =
        await dio.get(url, options: Options(responseType: ResponseType.json), queryParameters: params);
    HttpResponse httpResponse = HttpResponse(
      message: "",
      statusCode: response.statusCode ?? 0,
      data: response.data,
    );
    return httpResponse;
  }
}
