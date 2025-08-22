import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:crafty_bay_ecommerce/app/app_colors.dart';
import 'package:crafty_bay_ecommerce/features/home/data/models/slider_model.dart';

class HomeCarouselSlider extends StatefulWidget {
  const HomeCarouselSlider({
    super.key,
    required this.sliders,
  });

  final List<SliderModel> sliders;

  @override
  State<HomeCarouselSlider> createState() => _HomeCarouselSliderState();
}

class _HomeCarouselSliderState extends State<HomeCarouselSlider> {
  final CarouselSliderController _carouselController =
      CarouselSliderController();

  ValueNotifier<int> _currentIndex = ValueNotifier<int>(0);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          carouselController: _carouselController,
          options: CarouselOptions(
            onPageChanged: (index, reason) {
              _currentIndex = ValueNotifier<int>(index);
              setState(() {});
            },
            viewportFraction: 1.0,
            height: 180.0,
            enlargeCenterPage: true,
            autoPlay: false,
            autoPlayInterval: const Duration(seconds: 9),
            aspectRatio: 16 / 9,
            autoPlayCurve: Curves.fastOutSlowIn,
            enableInfiniteScroll: true,
            autoPlayAnimationDuration: const Duration(milliseconds: 3000),
          ),
          items: widget.sliders.map((data) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.symmetric(horizontal: 2.0),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                    // color: AppColors.themeColor,
                    image: DecorationImage(
                      image: NetworkImage(data.photoUrl ?? ""),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Buy ${data.description ?? ""}",
                          style: TextTheme.of(context).titleMedium?.copyWith(
                                fontWeight: FontWeight.w700,
                              ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 3.5,
                          child: ElevatedButton(
                            onPressed: () {},
                            child: const Text("Buy Now"),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }).toList(),
        ),
        // add indicator for carousel

        const SizedBox(height: 8.0),
        ValueListenableBuilder<int>(
            valueListenable: _currentIndex,
            builder: (context, value, _) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (int i = 0; i < widget.sliders.length; i++)
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
                          border:
                              Border.all(color: Colors.grey.shade400, width: 1),
                          shape: BoxShape.circle,
                          color:
                              value == i ? AppColors.themeColor : Colors.white,
                        ),
                      ),
                    ),
                ],
              );
            })
      ],
    );
  }
}
