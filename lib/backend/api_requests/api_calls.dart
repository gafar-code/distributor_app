import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'api_manager.dart';

export 'api_manager.dart' show ApiCallResponse;

const _kPrivateApiFunctionName = 'ffPrivateApiCall';

/// Start Distributor APP Group Code

class DistributorAPPGroup {
  static String getBaseUrl() => 'https://distributor-backend.fly.dev/api/v1';
  static Map<String, String> headers = {};
  static ChangePasswordCall changePasswordCall = ChangePasswordCall();
  static ForgotCall forgotCall = ForgotCall();
  static RegisterCall registerCall = RegisterCall();
  static LoginCall loginCall = LoginCall();
  static ListTaskCall listTaskCall = ListTaskCall();
  static CreateTaskCall createTaskCall = CreateTaskCall();
  static GetTaskCall getTaskCall = GetTaskCall();
  static UpdateTaskCall updateTaskCall = UpdateTaskCall();
  static DeleteTaskCall deleteTaskCall = DeleteTaskCall();
  static ListTaskProofCall listTaskProofCall = ListTaskProofCall();
  static CreateTaskProofCall createTaskProofCall = CreateTaskProofCall();
  static UpdateTaskProofCall updateTaskProofCall = UpdateTaskProofCall();
  static DeleteTaskProofCall deleteTaskProofCall = DeleteTaskProofCall();
  static ListSalesCall listSalesCall = ListSalesCall();
  static UploadImageCall uploadImageCall = UploadImageCall();
  static DeleteImageCall deleteImageCall = DeleteImageCall();
  static UpdateImageCall updateImageCall = UpdateImageCall();
}

class ChangePasswordCall {
  Future<ApiCallResponse> call({
    String? bearerAuth = '',
  }) async {
    final baseUrl = DistributorAPPGroup.getBaseUrl();

    const ffApiRequestBody = '''
{
  "old_password": "old_password",
  "new_password": "new_password"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'ChangePassword',
      apiUrl: '$baseUrl/auth/change',
      callType: ApiCallType.PUT,
      headers: {
        'Authorization': 'Bearer $bearerAuth',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class ForgotCall {
  Future<ApiCallResponse> call() async {
    final baseUrl = DistributorAPPGroup.getBaseUrl();

    const ffApiRequestBody = '''
{
  "email": "4I9o6@example.com"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'Forgot',
      apiUrl: '$baseUrl/auth/forgot',
      callType: ApiCallType.POST,
      headers: {},
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class RegisterCall {
  Future<ApiCallResponse> call() async {
    final baseUrl = DistributorAPPGroup.getBaseUrl();

    const ffApiRequestBody = '''
{
  "role": "ADMIN",
  "name": "John Doe",
  "email": "4I9o6@example.com",
  "password": "password"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'Register',
      apiUrl: '$baseUrl/auth/register',
      callType: ApiCallType.POST,
      headers: {},
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class LoginCall {
  Future<ApiCallResponse> call({
    String? email = '',
    String? password = '',
  }) async {
    final baseUrl = DistributorAPPGroup.getBaseUrl();

    final ffApiRequestBody = '''
{
  "email": "$email",
  "password": "$password"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'Login',
      apiUrl: '$baseUrl/auth/login',
      callType: ApiCallType.POST,
      headers: {},
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class ListTaskCall {
  Future<ApiCallResponse> call({
    int? paginationId,
    String? bearerAuth = '',
  }) async {
    final baseUrl = DistributorAPPGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'ListTask',
      apiUrl: '$baseUrl/task',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Bearer $bearerAuth',
      },
      params: {
        'pagination_id': paginationId,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class CreateTaskCall {
  Future<ApiCallResponse> call({
    String? bearerAuth = '',
  }) async {
    final baseUrl = DistributorAPPGroup.getBaseUrl();

    const ffApiRequestBody = '''
{
  "title": "title",
  "body": "body",
  "sales_id": 1
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'CreateTask',
      apiUrl: '$baseUrl/task',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'Bearer $bearerAuth',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class GetTaskCall {
  Future<ApiCallResponse> call({
    int? taskId,
    String? bearerAuth = '',
  }) async {
    final baseUrl = DistributorAPPGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'GetTask',
      apiUrl: '$baseUrl/task/$taskId',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Bearer $bearerAuth',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class UpdateTaskCall {
  Future<ApiCallResponse> call({
    int? taskId,
    String? bearerAuth = '',
  }) async {
    final baseUrl = DistributorAPPGroup.getBaseUrl();

    const ffApiRequestBody = '''
{
  "title": "title",
  "body": "body",
  "status": "PENDING",
  "sales_id": 1,
  "sales_name": "sales name"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'UpdateTask',
      apiUrl: '$baseUrl/task/$taskId',
      callType: ApiCallType.PUT,
      headers: {
        'Authorization': 'Bearer $bearerAuth',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class DeleteTaskCall {
  Future<ApiCallResponse> call({
    int? taskId,
    String? bearerAuth = '',
  }) async {
    final baseUrl = DistributorAPPGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'DeleteTask',
      apiUrl: '$baseUrl/task/$taskId',
      callType: ApiCallType.DELETE,
      headers: {
        'Authorization': 'Bearer $bearerAuth',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class ListTaskProofCall {
  Future<ApiCallResponse> call({
    int? paginationId,
    int? taskId,
    String? bearerAuth = '',
  }) async {
    final baseUrl = DistributorAPPGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'ListTaskProof',
      apiUrl: '$baseUrl/task_proof',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Bearer $bearerAuth',
      },
      params: {
        'pagination_id': paginationId,
        'task_id': taskId,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class CreateTaskProofCall {
  Future<ApiCallResponse> call({
    String? bearerAuth = '',
  }) async {
    final baseUrl = DistributorAPPGroup.getBaseUrl();

    const ffApiRequestBody = '''
{
  "task_id": 1,
  "description": "description",
  "image": "image.png",
  "latitude": 1,
  "longitude": 1,
  "address": "address"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'CreateTaskProof',
      apiUrl: '$baseUrl/task_proof',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'Bearer $bearerAuth',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class UpdateTaskProofCall {
  Future<ApiCallResponse> call({
    int? taskProofId,
    String? bearerAuth = '',
  }) async {
    final baseUrl = DistributorAPPGroup.getBaseUrl();

    const ffApiRequestBody = '''
{
  "description": "description"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'UpdateTaskProof',
      apiUrl: '$baseUrl/task_proof/$taskProofId',
      callType: ApiCallType.PUT,
      headers: {
        'Authorization': 'Bearer $bearerAuth',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class DeleteTaskProofCall {
  Future<ApiCallResponse> call({
    int? taskProofId,
    String? bearerAuth = '',
  }) async {
    final baseUrl = DistributorAPPGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'DeleteTaskProof',
      apiUrl: '$baseUrl/task_proof/$taskProofId',
      callType: ApiCallType.DELETE,
      headers: {
        'Authorization': 'Bearer $bearerAuth',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class ListSalesCall {
  Future<ApiCallResponse> call({
    int? paginationId,
    String? name = '',
    String? bearerAuth = '',
  }) async {
    final baseUrl = DistributorAPPGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'ListSales',
      apiUrl: '$baseUrl/sales',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Bearer $bearerAuth',
      },
      params: {
        'pagination_id': paginationId,
        'name': name,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class UploadImageCall {
  Future<ApiCallResponse> call({
    String? bearerAuth = '',
  }) async {
    final baseUrl = DistributorAPPGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'UploadImage',
      apiUrl: '$baseUrl/file/image',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'Bearer $bearerAuth',
      },
      params: {},
      bodyType: BodyType.MULTIPART,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class DeleteImageCall {
  Future<ApiCallResponse> call({
    String? name = '',
    String? bearerAuth = '',
  }) async {
    final baseUrl = DistributorAPPGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'DeleteImage',
      apiUrl: '$baseUrl/file/image/$name',
      callType: ApiCallType.DELETE,
      headers: {
        'Authorization': 'Bearer $bearerAuth',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class UpdateImageCall {
  Future<ApiCallResponse> call({
    String? name = '',
    String? bearerAuth = '',
  }) async {
    final baseUrl = DistributorAPPGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'UpdateImage',
      apiUrl: '$baseUrl/file/image/$name',
      callType: ApiCallType.PUT,
      headers: {
        'Authorization': 'Bearer $bearerAuth',
      },
      params: {},
      bodyType: BodyType.MULTIPART,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

/// End Distributor APP Group Code

class ApiPagingParams {
  int nextPageNumber = 0;
  int numItems = 0;
  dynamic lastResponse;

  ApiPagingParams({
    required this.nextPageNumber,
    required this.numItems,
    required this.lastResponse,
  });

  @override
  String toString() =>
      'PagingParams(nextPageNumber: $nextPageNumber, numItems: $numItems, lastResponse: $lastResponse,)';
}

String _toEncodable(dynamic item) {
  return item;
}

String _serializeList(List? list) {
  list ??= <String>[];
  try {
    return json.encode(list, toEncodable: _toEncodable);
  } catch (_) {
    if (kDebugMode) {
      print("List serialization failed. Returning empty list.");
    }
    return '[]';
  }
}

String _serializeJson(dynamic jsonVar, [bool isList = false]) {
  jsonVar ??= (isList ? [] : {});
  try {
    return json.encode(jsonVar, toEncodable: _toEncodable);
  } catch (_) {
    if (kDebugMode) {
      print("Json serialization failed. Returning empty json.");
    }
    return isList ? '[]' : '{}';
  }
}
