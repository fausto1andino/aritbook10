import 'package:flutter_card_swipper/flutter_card_swiper.dart';
import 'package:flutter/material.dart';

class ThemeSwipper extends StatelessWidget {
  const ThemeSwipper({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SizedBox(
        width: double.infinity,
        height: size.height * 0.5,
        child: Swiper(
            itemCount: 5,
            layout: SwiperLayout.STACK,
            itemWidth: size.width * 0.6,
            itemHeight: size.height * 0.4,
            itemBuilder: (_, int index) {
              return GestureDetector(
                onTap: () => Navigator.pushNamed(context, 'detailsTheme'),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: const FadeInImage(
                    placeholder: AssetImage('assets/images/no-image.jpg'),
                    image: NetworkImage(
                        "https://4.bp.blogspot.com/-_iS2aIwixHg/WYJ23N3nElI/AAAAAAAABFw/EtIzL5wqd3UFWsPawlCGVpodD-Q1Ol1cACEwYBhgL/s1600/unidad1.png"),
                    fit: BoxFit.cover,
                  ),
                ),
              );
            }));
  }
}
