import 'package:flutter/material.dart';
import 'package:aurea_app/src/presentation/screens/patients_add/widgets/back_button.dart';

//TODO: DELETE THIS FILE
class PhotoContentWrapper extends StatelessWidget {
  final Widget photoContent;
  final bool hasPhotos;

  const PhotoContentWrapper({
    super.key,
    required this.photoContent,
    required this.hasPhotos,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        photoContent,
        PatientBackButton(),
      ],
    );
  }
}

