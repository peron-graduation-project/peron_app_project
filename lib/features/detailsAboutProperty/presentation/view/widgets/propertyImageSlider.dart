import 'package:flutter/material.dart';

import 'curvedtopclipper.dart';

class PropertyImageSlider extends StatelessWidget {
  final List<String> imagesPaths;
  final int currentImageIndex;
  final Function(int) goToImage;
  final double imageHeight;
  final double standardPadding;
  final double screenHeight;
  final double smallCircleSize;

  const PropertyImageSlider({
    Key? key,
    required this.imagesPaths,
    required this.currentImageIndex,
    required this.goToImage,
    required this.imageHeight,
    required this.standardPadding,
    required this.screenHeight,
    required this.smallCircleSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onHorizontalDragEnd: (details) {
            if (details.primaryVelocity != null) {
              if (details.primaryVelocity! > 0) {
                goToImage(currentImageIndex - 1);
              } else {
                goToImage(currentImageIndex + 1);
              }
            }
          },
          child: Container(
            height: imageHeight,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(imagesPaths[currentImageIndex]),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Positioned(
          bottom: imageHeight * 0.15,
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: imageHeight * 0.03,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    imagesPaths.length,
                    (index) => Container(
                      width: currentImageIndex == index ? 24 : 8,
                      height: 8,
                      margin: const EdgeInsets.symmetric(horizontal: 2),
                      decoration: BoxDecoration(
                        color: currentImageIndex == index
                            ? const Color(0xFF0F8E65)
                            : Colors.white.withOpacity(0.6),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: screenHeight * 0.05,
          right: standardPadding,
          child: Container(
            width: smallCircleSize,
            height: smallCircleSize,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              padding: EdgeInsets.zero,
              icon: Icon(
                Icons.chevron_right,
                color: Colors.grey[800],
                size: 25,
              ),
              onPressed: () {},
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: ClipPath(
            clipper: CurvedTopClipper(),
            child: Container(
              height: 60,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
