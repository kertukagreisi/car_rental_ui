import 'package:flutter/cupertino.dart';
import 'package:http_interceptor/http_interceptor.dart';
import 'package:logging/logging.dart';

import '../shared/auth_service.dart';
import '../shared/locator.dart';

InterceptedClient buildInterceptedClient() => InterceptedClient.build(
      interceptors: [
        AuthInterceptor(),
        LoggerInterceptor(),
      ],
      //retryPolicy: ExpiredTokenRetryPolicy(),
    );

class AuthInterceptor extends BugInterceptor {
  final _auth = getIt.get<AuthService>();

  @override
  Future<BaseRequest> interceptRequest({required BaseRequest request}) async {
    if (await _auth.isAuthenticated.first) {
      request.headers['Authorization'] = 'Bearer ${_auth.token}';
    }
    return super.interceptRequest(request: request);
  }
}

class LoggerInterceptor extends BugInterceptor {
  final _logger = Logger('$LoggerInterceptor');

  @override
  Future<BaseRequest> interceptRequest({required BaseRequest request}) {
    final method = request.method;
    final headers = request.headers;
    _logger.finest('--> $method ${request.url}');
    if (headers.isNotEmpty) _logger.finest('HEADERS: $headers');
    if (request is Request) _logBody(request.body);
    _logger.finest('--> END $method');
    return super.interceptRequest(request: request);
  }

  @override
  Future<BaseResponse> interceptResponse({required BaseResponse response}) {
    final statusCode = response.statusCode;
    _logger.finest('<-- $statusCode ${response.request?.url}');
    _logger.finest('HEADERS: ${response.headers}');
    if (response is Response) _logBody(response.body);
    _logger.finest('<-- END $statusCode');
    return super.interceptResponse(response: response);
  }

  void _logBody(String? body) {
    if (body == null || body.isEmpty) return;
    final bodyStr = (body.length > 800) ? '${body.substring(0, 800)} ...' : body;
    _logger.finest('BODY: $bodyStr');
  }
}

// It seems there is a bug in the library where for the GET requests
// the BODY parameter is set to empty string instead of null.
// Which then causes the http library to set the wrong content-type.
// https://github.com/CodingAleCR/http_interceptor/issues/121
abstract class BugInterceptor extends InterceptorContract {
  @mustCallSuper
  @override
  Future<BaseRequest> interceptRequest({required BaseRequest request}) {
    if (request is Request && request.body.isEmpty && StringToMethod.fromString(request.method) == HttpMethod.GET) {
      request.headers['content-type'] = 'application/json';
    }
    return Future.value(request);
  }

  @override
  Future<BaseResponse> interceptResponse({required BaseResponse response}) {
    return Future.value(response);
  }
}

/*class ExpiredTokenRetryPolicy extends RetryPolicy {
  final _auth = getIt.get<AuthService>();

  @override
  int get maxRetryAttempts => 2;

  @override
  Future<bool> shouldAttemptRetryOnResponse(BaseResponse response) async {
    bool shouldAttemptRetry = false;
    if (response.statusCode == 401) {
      shouldAttemptRetry = await _auth.refreshToken();
    }
    return Future.value(shouldAttemptRetry);
  }
}*/
