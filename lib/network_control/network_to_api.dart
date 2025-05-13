import 'package:artify/app_background/app_state_provider.dart';
import 'package:artify/network_control/network_object.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

const apiKey = "DrnfEhU__6t1Tm_cP7jvKg2cph858pOWYDELjLCWBno";
final apiUrl = 'https://api.unsplash.com';

BaseOptions option = BaseOptions(
  baseUrl: apiUrl,
  headers: {'Authorization': 'Client-ID $apiKey'},
);

List<NetworkObject> images = [];
final dio = Dio(option);

Future SearchData(
  String text,
  int pageNo,
  bool isHome, {
  int perPage = 24,
}) async {
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
      // print(response.data['results']);
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
  dio.options.queryParameters = {'query': text}; //'per_page': 10
  currentCollectionIds.clear();
  try {
    Response response = await dio.get('/search/collections');

    if (response.statusCode == 200) {
      for (var item in response.data['results']) {
        currentCollectionIds.add(item['id']);
      }
      // print(currentCollectionIds);
      return currentCollectionIds;
    } else {
      print("Failed to fetch data, Status code: ${response.statusCode}");
    }
  } catch (e) {
    print("Error: $e");
  }
}

Future fetchImageByCollectionId(String id) async {
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

    final redirectedUrl = response.headers.value(
      'location',
    ); // Actual image URL
    print(response.statusCode);
    // print(response.isRedirect);
    // dio.download(response.data["url"], "/home/leta/Desktop");
    // return redirectedUrl;
  } catch (e) {
    print('Error fetching image URL: $e');
    return null;
  }
}

// Replace with your Unsplash API Client ID
// const String unsplashClientId = 'YOUR_UNSPLASH_CLIENT_ID';
// const String photoId = 'YOUR_PHOTO_ID'; // Example photo ID

Future<void> downloadUnsplashImage(String photoId) async {
  Dio dio = Dio();

  try {
    // 1. Get the photo details to access the download URL and download location
    final photoDetailsResponse = await dio.get(
      'https://api.unsplash.com/photos/$photoId',
      options: Options(headers: {'Authorization': 'Client-ID $apiKey'}),
    );

    if (photoDetailsResponse.statusCode == 200) {
      final photoData = photoDetailsResponse.data;
      final downloadUrl = photoData['links']['download'];
      final downloadLocationUrl = photoData['links']['download_location'];

      print('Download URL: $downloadUrl');

      // 2. Download the image using the download URL
      final imageResponse = await dio.download(
        downloadUrl,
        'unsplash_$photoId.jpg', // Specify the local file path and name
        onReceiveProgress: (received, total) {
          if (total != -1) {
            print('${(received / total * 100).toStringAsFixed(0)}%');
          }
        },
      );

      if (imageResponse.statusCode == 200) {
        print('Image downloaded successfully to unsplash_$photoId.jpg');

        // 3. Trigger the download location URL to track the download (optional but recommended)
        try {
          await dio.get(
            downloadLocationUrl,
            options: Options(headers: {'Authorization': 'Client-ID $apiKey'}),
          );
          print('Download location tracked.');
        } catch (e) {
          print('Error tracking download location: $e');
        }
      } else {
        print('Failed to download image: ${imageResponse.statusCode}');
        print(imageResponse.data);
      }
    } else {
      print(
        'Failed to fetch photo details: ${photoDetailsResponse.statusCode}',
      );
      print(photoDetailsResponse.data);
    }
  } catch (e) {
    print('An error occurred: $e');
  }
}
