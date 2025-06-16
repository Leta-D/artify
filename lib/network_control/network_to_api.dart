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

// Future fetchData(String query, int pageNo, {int perPage = 24}) async {
//   dio.options.queryParameters = {
//     'per_page': perPage,
//     'query': query,
//     'page': pageNo,
//   };
//   try {
//     Response response = await dio.get('/photos');

//     if (response.statusCode == 200) {
//       images =
//           (response.data as List)
//               .map((json) => NetworkObject.fromJson(json))
//               .toList();
//       return images;
//     } else {
//       print("Failed to fetch data, Status code: ${response.statusCode}");
//     }
//   } catch (e) {
//     print("Error: $e");
//   }
// }

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

// Future<void> fetchDownloadLocation(String imageId) async {
//   final dio = Dio();
//   try {
//     Response response = await dio.get('/photos/$imageId/download');
//     if (response.statusCode == 200) {
//       print(response.data);
//       // return images;
//     } else {
//       print("Failed to fetch data, Status code: ${response.statusCode}");
//     }
//   } catch (e) {
//     print("Error: $e");
//   }
// }

Future<String?> fetchDownloadLocation(String photoId) async {
  final dio = Dio();
  try {
    final response = await dio.get(
      photoId,
      options: Options(
        headers: {'Authorization': 'Client-ID $apiKey'},
        followRedirects: false,
        // validateStatus: (status) => status == 302,
      ),
    );

    // final redirectedUrl = response.headers.value(
    //   'location',
    // ); // Actual image URL
    // print(response.statusCode);
    // print(response.isRedirect);
    // dio.download(response.data["url"], "/home/leta/Desktop");
    // return redirectedUrl;
  } catch (e) {
    print('Error fetching image URL: $e');
    return null;
  }
  return null;
}

// Replace with your Unsplash API Client ID
// const String unsplashClientId = 'YOUR_UNSPLASH_CLIENT_ID';
// const String photoId = 'YOUR_PHOTO_ID'; // Example photo ID
