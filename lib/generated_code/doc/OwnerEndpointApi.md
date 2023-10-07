# openapi.api.OwnerEndpointApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**ownersAllGet**](OwnerEndpointApi.md#ownersallget) | **GET** /owners/all | 
[**ownersIdDeleteDelete**](OwnerEndpointApi.md#ownersiddeletedelete) | **DELETE** /owners/{id}/delete | 
[**ownersInsertPost**](OwnerEndpointApi.md#ownersinsertpost) | **POST** /owners/insert | 
[**ownersUpdatePut**](OwnerEndpointApi.md#ownersupdateput) | **PUT** /owners/update | 


# **ownersAllGet**
> ownersAllGet()



### Example
```dart
import 'package:openapi/api.dart';

final api_instance = OwnerEndpointApi();

try {
    api_instance.ownersAllGet();
} catch (e) {
    print('Exception when calling OwnerEndpointApi->ownersAllGet: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **ownersIdDeleteDelete**
> ownersIdDeleteDelete(id)



### Example
```dart
import 'package:openapi/api.dart';

final api_instance = OwnerEndpointApi();
final id = 789; // int | 

try {
    api_instance.ownersIdDeleteDelete(id);
} catch (e) {
    print('Exception when calling OwnerEndpointApi->ownersIdDeleteDelete: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**|  | 

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **ownersInsertPost**
> ownersInsertPost(owner)



### Example
```dart
import 'package:openapi/api.dart';

final api_instance = OwnerEndpointApi();
final owner = Owner(); // Owner | 

try {
    api_instance.ownersInsertPost(owner);
} catch (e) {
    print('Exception when calling OwnerEndpointApi->ownersInsertPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **owner** | [**Owner**](Owner.md)|  | [optional] 

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **ownersUpdatePut**
> ownersUpdatePut(owner)



### Example
```dart
import 'package:openapi/api.dart';

final api_instance = OwnerEndpointApi();
final owner = Owner(); // Owner | 

try {
    api_instance.ownersUpdatePut(owner);
} catch (e) {
    print('Exception when calling OwnerEndpointApi->ownersUpdatePut: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **owner** | [**Owner**](Owner.md)|  | [optional] 

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

