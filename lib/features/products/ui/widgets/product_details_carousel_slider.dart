import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:crafty_bay_ecommerce/app/app_colors.dart';

class ProductDetailsCarouselSlider extends StatefulWidget {
  const ProductDetailsCarouselSlider({
    super.key,
    required this.images,
  });

  final List<String> images;

  @override
  State<ProductDetailsCarouselSlider> createState() =>
      _ProductDetailsCarouselSliderState();
}

class _ProductDetailsCarouselSliderState
    extends State<ProductDetailsCarouselSlider> {
  final CarouselSliderController _carouselController =
      CarouselSliderController();

  ValueNotifier<int> _currentIndex = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CarouselSlider(
          carouselController: _carouselController,
          options: CarouselOptions(
            onPageChanged: (index, reason) {
              _currentIndex = ValueNotifier<int>(index);
              setState(() {});
            },
            viewportFraction: 1.0,
            height: 220.0,
            enlargeCenterPage: true,
            autoPlay: false,
            aspectRatio: 16 / 9,
            autoPlayCurve: Curves.fastOutSlowIn,
            enableInfiniteScroll: true,
            autoPlayAnimationDuration: const Duration(milliseconds: 3000),
          ),
          items: widget.images.map((image) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  // margin: const EdgeInsets.symmetric(horizontal: 2.0),
                  decoration: const BoxDecoration(
                    // borderRadius: BorderRadius.all(Radius.circular(16.0)),
                    color: Colors.black12,
                  ),
                  child: Image.network(
                    image,
                    fit: BoxFit.fill,
                  ),
                );
              },
            );
          }).toList(),
        ),
        // add indicator for carousel

        const SizedBox(height: 8.0),
        Positioned(
          bottom: 8.0,
          left: 0,
          right: 0,
          child: ValueListenableBuilder<int>(
              valueListenable: _currentIndex,
              builder: (context, value, _) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 4.0,
                  children: [
                    for (int i = 0; i < widget.images.length; i++)
                      GestureDetector(
                        onTap: () {
                          _carouselController.animateToPage(i);
                          setState(() {});
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 2.0),
                          width: 16.0,
                          height: 16.0,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: value == i
                                ? AppColors.themeColor
                                : Colors.white,
                          ),
                        ),
                      ),
                  ],
                );
              }),
        )
      ],
    );
  }
}
