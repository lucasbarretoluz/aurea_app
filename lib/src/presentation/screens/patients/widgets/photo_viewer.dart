import 'package:flutter/material.dart';

class PhotoViewer extends StatelessWidget {
  final List<String> photoUrls;
  final VoidCallback onAddPhoto;

  const PhotoViewer({
    super.key,
    required this.photoUrls,
    required this.onAddPhoto,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 530,
          decoration: BoxDecoration(
            color: const Color(0xFFF5F5F5),
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(50),
              bottomRight: Radius.circular(50),
            ),
          ),
          child: PageView.builder(
            itemCount: photoUrls.length,
            itemBuilder: (context, index) {
              return ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                  bottomRight: Radius.circular(50),
                ),
                child: Image.network(
                  photoUrls[index],
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey[300],
                      child: const Center(
                        child: Icon(
                          Icons.broken_image,
                          size: 64,
                          color: Colors.grey,
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ),
        Positioned(
          bottom: 20,
          right: 20,
          child: FloatingActionButton(
            onPressed: onAddPhoto,
            backgroundColor: Colors.black,
            child: const Icon(
              Icons.add_photo_alternate,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}

