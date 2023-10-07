# openapi.api.CarEndpointApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**carsAllGet**](CarEndpointApi.md#carsallget) | **GET** /cars/all | 
[**carsCreatePost**](CarEndpointApi.md#carscreatepost) | **POST** /cars/create | 
[**carsIdDelete**](CarEndpointApi.md#carsiddelete) | **DELETE** /cars/{id} | 
[**carsOwnerIdCarsGet**](CarEndpointApi.md#carsowneridcarsget) | **GET** /cars/{ownerId}/cars | 
[**carsUpdatePut**](CarEndpointApi.md#carsupdateput) | **PUT** /cars/update | 


# **carsAllGet**
> carsAllGet()



### Example
```dart
import 'package:openapi/api.dart';

final api_instance = CarEndpointApi();

try {
    api_instance.carsAllGet();
} catch (e) {
    print('Exception when calling CarEndpointApi->carsAllGet: $e\n');
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

# **carsCreatePost**
> carsCreatePost(id, car)



### Example
```dart
import 'package:openapi/api.dart';

final api_instance = CarEndpointApi();
final id = 789; // int | 
final car = Car(); // Car | 

try {
    api_instance.carsCreatePost(id, car);
} catch (e) {
    print('Exception when calling CarEndpointApi->carsCreatePost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**|  | [optional] 
 **car** | [**Car**](Car.md)|  | [optional] 

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **carsIdDelete**
> carsIdDelete(id)



### Example
```dart
import 'package:openapi/api.dart';

final api_instance = CarEndpointApi();
final id = 789; // int | 

try {
    api_instance.carsIdDelete(id);
} catch (e) {
    print('Exception when calling CarEndpointApi->carsIdDelete: $e\n');
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

# **carsOwnerIdCarsGet**
> carsOwnerIdCarsGet(ownerId)



### Example
```dart
import 'package:openapi/api.dart';

final api_instance = CarEndpointApi();
final ownerId = 789; // int | 

try {
    api_instance.carsOwnerIdCarsGet(ownerId);
} catch (e) {
    print('Exception when calling CarEndpointApi->carsOwnerIdCarsGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **ownerId** | **int**|  | 

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **carsUpdatePut**
> carsUpdatePut(car)



### Example
```dart
import 'package:openapi/api.dart';

final api_instance = CarEndpointApi();
final car = Car(); // Car | 

try {
    api_instance.carsUpdatePut(car);
} catch (e) {
    print('Exception when calling CarEndpointApi->carsUpdatePut: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **car** | [**Car**](Car.md)|  | [optional] 

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

