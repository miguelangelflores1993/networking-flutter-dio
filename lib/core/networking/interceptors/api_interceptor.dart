import 'package:dio/dio.dart';

class ApiInterceptor extends Interceptor {
  ApiInterceptor({
    required this.token,
  }) : super();
  final Future<String>? token;
  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (options.extra.containsKey('requiresAuthToken')) {
      if (options.extra['requiresAuthToken'] == true) {
        final tokenData = await token;
        options.headers.addAll(
          {'Authorization': 'Bearer $tokenData'},
        );
      }

      options.extra.remove('requiresAuthToken');
    }
    return handler.next(
      options,
    );
  }

  @override
  void onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) {
    return handler.next(
      response,
    );
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    return handler.next(
      err,
    );
  }
}