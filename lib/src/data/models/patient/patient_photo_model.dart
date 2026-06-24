class PatientPhotoItem {
  final String url;
  final String path;
  final String type;

  const PatientPhotoItem({
    required this.url,
    required this.path,
    this.type = 'appointment',
  });

  factory PatientPhotoItem.fromJson(Map<String, dynamic> json) {
    final url = json['url'] as String? ?? '';
    var path = json['path'] as String? ?? '';
    if (path.isEmpty && url.isNotEmpty) {
      path = pathFromFirebaseUrl(url);
    }

    return PatientPhotoItem(
      url: url,
      path: path,
      type: _typeFromJson(json['type']),
    );
  }

  static String _typeFromJson(dynamic value) {
    if (value is String && value.isNotEmpty) return value;
    if (value is int) return value == 1 ? 'profile' : 'appointment';
    return 'appointment';
  }

  static String pathFromFirebaseUrl(String url) {
    final uri = Uri.tryParse(url);
    if (uri == null) return '';

    final segments = uri.pathSegments;
    final objectIndex = segments.indexOf('o');
    if (objectIndex == -1 || objectIndex + 1 >= segments.length) return '';

    return Uri.decodeComponent(segments[objectIndex + 1]);
  }
}

class PatientPhotoList {
  final List<PatientPhotoItem> photos;

  PatientPhotoList({required this.photos});

  List<String> get urls => photos.map((photo) => photo.url).toList();

  factory PatientPhotoList.fromJson(dynamic json) {
    if (json is Map) {
      final photosList = json['photos'] as List? ?? [];

      if (photosList.isEmpty) {
        return PatientPhotoList(photos: []);
      }

      final photos = photosList
          .whereType<Map>()
          .map((item) => PatientPhotoItem.fromJson(Map<String, dynamic>.from(item)))
          .where((photo) => photo.url.isNotEmpty)
          .toList();

      return PatientPhotoList(photos: photos);
    }

    return PatientPhotoList(photos: []);
  }
}
