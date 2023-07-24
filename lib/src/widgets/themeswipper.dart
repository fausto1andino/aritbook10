import 'dart:io';
import 'package:EspeMath/src/models/UnitModel/unit_model.dart';
import 'package:flutter_card_swipper/flutter_card_swiper.dart';
import 'package:media_cache_manager/media_cache_manager.dart';
import 'package:flutter/material.dart';

class ThemeSwipper extends StatelessWidget {
  final List<UnitBook> unitBooks;
  const ThemeSwipper({super.key, required this.unitBooks});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    if (unitBooks.isEmpty) {
      return SizedBox(
        width: double.infinity,
        height: size.height * 0.5,
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return SizedBox(
        width: double.infinity,
        height: size.height * 0.5,
        child: Swiper(
            itemCount: unitBooks.length,
            layout: SwiperLayout.STACK,
            itemWidth: size.width * 0.6,
            itemHeight: size.height * 0.4,
            itemBuilder: (_, int index) {
              final unitBook = unitBooks[index];
              return GestureDetector(
                onTap: () => Navigator.pushNamed(context, 'detailsTheme',
                    arguments: unitBook),
                child: DownloadMediaBuilder(
                  url: unitBook.urlMainImage,
                  onSuccess: (snapshot) {
                    return Image.file(
                      File(snapshot.filePath!),
                      width: size.width * 0.40,
                      height: (size.width > 361)
                          ? MediaQuery.of(context).size.width * 0.55
                          : MediaQuery.of(context).size.width * 0.35,
                      fit: BoxFit.fill,
                    );
                  },
                ),
              );
            }));
  }
}
