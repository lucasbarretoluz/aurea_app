class PatientPhotoList {
  final List<String> urls;

  PatientPhotoList({required this.urls});

  factory PatientPhotoList.fromJson(dynamic json) {
    if (json is Map) {
      final photosList = json['photos'] as List? ?? [];
      
      if (photosList.isEmpty) {
        return PatientPhotoList(urls: []);
      }

      final urls = photosList.map((item) {
        if (item is Map) {
          return item['url'] as String? ?? '';
        }
        return '';
      }).where((url) => url.isNotEmpty).toList();

      return PatientPhotoList(urls: urls);
    }
    
    return PatientPhotoList(urls: []);
  }
}

