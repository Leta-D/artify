class NetworkObject {
  String id, downUrl, rawUrl, rawUrlFull;
  int likes;

  NetworkObject({
    required this.id,
    required this.rawUrl,
    required this.rawUrlFull,
    required this.downUrl,
    required this.likes,
  });

  factory NetworkObject.fromJson(Map<String, dynamic> json) {
    return NetworkObject(
      id: json['id'],
      rawUrl: json['urls']['small'],
      rawUrlFull: json['urls']['full'], //full better speed
      downUrl: json['links']['download_location'],
      likes: json['likes'],
    );
  }
}
