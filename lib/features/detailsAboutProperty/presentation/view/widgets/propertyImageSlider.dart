import 'package:flutter/material.dart';
import 'package:peron_project/core/widgets/custom_arrow_back.dart';
import 'curvedtopclipper.dart';

class PropertyImageSlider extends StatelessWidget {
  final List<String> imagesPaths;
  final int currentImageIndex;
  final Function(int) goToImage;
  final double imageHeight;
  final double standardPadding;
  final double screenHeight;
  final double smallCircleSize;
  final PageController pageController;


  const PropertyImageSlider({
    super.key,
    required this.imagesPaths,
    required this.currentImageIndex,
    required this.goToImage,
    required this.imageHeight,
    required this.standardPadding,
    required this.screenHeight,
    required this.smallCircleSize,
    required this.pageController,
  });

  @override
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: imageHeight,
          width: double.infinity,
          child: PageView.builder(
            controller: pageController,
            itemCount: imagesPaths.length,
            itemBuilder: (context, index) {
              return Image.network(
                imagesPaths[index],
                fit: BoxFit.cover,
                width: double.infinity,
                height: imageHeight,
              );
            },
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
          top: 40,
          right: 15,
          child: Container(
            width: smallCircleSize,
            height: smallCircleSize,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: const Center(child: CustomArrowBack()),
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
