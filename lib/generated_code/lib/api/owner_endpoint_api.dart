//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class OwnerEndpointApi {
  OwnerEndpointApi([ApiClient? apiClient]) : apiClient = apiClient ?? defaultApiClient;

  final ApiClient apiClient;

  /// Performs an HTTP 'GET /owners/all' operation and returns the [Response].
  Future<Response> ownersAllGetWithHttpInfo() async {
    // ignore: prefer_const_declarations
    final path = r'/owners/all';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>[];


    return apiClient.invokeAPI(
      path,
      'GET',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  Future<void> ownersAllGet() async {
    final response = await ownersAllGetWithHttpInfo();
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Performs an HTTP 'DELETE /owners/{id}/delete' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [int] id (required):
  Future<Response> ownersIdDeleteDeleteWithHttpInfo(int id,) async {
    // ignore: prefer_const_declarations
    final path = r'/owners/{id}/delete'
      .replaceAll('{id}', id.toString());

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>[];


    return apiClient.invokeAPI(
      path,
      'DELETE',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Parameters:
  ///
  /// * [int] id (required):
  Future<void> ownersIdDeleteDelete(int id,) async {
    final response = await ownersIdDeleteDeleteWithHttpInfo(id,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Performs an HTTP 'POST /owners/insert' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [Owner] owner:
  Future<Response> ownersInsertPostWithHttpInfo({ Owner? owner, }) async {
    // ignore: prefer_const_declarations
    final path = r'/owners/insert';

    // ignore: prefer_final_locals
    Object? postBody = owner;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['application/json'];


    return apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Parameters:
  ///
  /// * [Owner] owner:
  Future<void> ownersInsertPost({ Owner? owner, }) async {
    final response = await ownersInsertPostWithHttpInfo( owner: owner, );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Performs an HTTP 'PUT /owners/update' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [Owner] owner:
  Future<Response> ownersUpdatePutWithHttpInfo({ Owner? owner, }) async {
    // ignore: prefer_const_declarations
    final path = r'/owners/update';

    // ignore: prefer_final_locals
    Object? postBody = owner;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['application/json'];


    return apiClient.invokeAPI(
      path,
      'PUT',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Parameters:
  ///
  /// * [Owner] owner:
  Future<void> ownersUpdatePut({ Owner? owner, }) async {
    final response = await ownersUpdatePutWithHttpInfo( owner: owner, );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }
}
