import 'package:aaa/network_control/network_object.dart';
import 'package:dio/dio.dart';

const apiKey = "DrnfEhU__6t1Tm_cP7jvKg2cph858pOWYDELjLCWBno";
final apiUrl = 'https://api.unsplash.com';

BaseOptions option = BaseOptions(
  baseUrl: apiUrl,
  headers: {'Authorization': 'Client-ID $apiKey'},
);

List<NetworkObject> images = [];

Future searchData(
  String text,
  int pageNo,
  bool isHome, {
  int perPage = 30,
}) async {
  final dio = Dio(option);
  dio.options.queryParameters = {
    'per_page': perPage,
    'query': text,
    'page': pageNo,
  };
  try {
    Response response = await dio.get((isHome) ? '/photos' : '/search/photos');
    images.clear();
    if (response.statusCode == 200) {
      images =
          (((isHome) ? response.data : response.data['results']) as List)
              .map((json) => NetworkObject.fromJson(json))
              .toList();
      return images;
    } else {
      print("Failed to fetch data, Status code: ${response.statusCode}");
    }
  } catch (e) {
    print("Error: $e");
  }
  dio.close();
}

List<String> currentCollectionIds = [];

Future fetchImageCollectionId(String text) async {
  final dio = Dio(option);
  dio.options.queryParameters = {'query': text}; //'per_page': 10
  currentCollectionIds.clear();
  try {
    Response response = await dio.get('/search/collections');

    if (response.statusCode == 200) {
      for (var item in response.data['results']) {
        currentCollectionIds.add(item['id']);
      }
      return currentCollectionIds;
    } else {
      print("Failed to fetch data, Status code: ${response.statusCode}");
    }
  } catch (e) {
    print("Error: $e");
  }
}

Future fetchImageByCollectionId(String id) async {
  final dio = Dio(option);
  dio.options.queryParameters = {'per_page': 15}; //'per_page': 10
  try {
    Response response = await dio.get('/collections/$id/photos');
    if (response.statusCode == 200) {
      images =
          (response.data as List)
              .map((json) => NetworkObject.fromJson(json))
              .toList();
      return images;
    } else {
      print("Failed to fetch data, Status code: ${response.statusCode}");
    }
  } catch (e) {
    print("Error: $e");
  }
}

// Replace with your Unsplash API Client ID
// const String unsplashClientId = 'YOUR_UNSPLASH_CLIENT_ID';
// const String photoId = 'YOUR_PHOTO_ID'; // Example photo ID
