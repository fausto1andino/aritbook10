import 'package:flutter/material.dart';

import '../../models/UnitModel/unit_model.dart';

class CustomAppBar extends StatelessWidget {
  final UnitBook unitBook;

  const CustomAppBar(this.unitBook, {super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Theme.of(context).primaryColor,
      expandedHeight: 200,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        titlePadding: const EdgeInsets.all(0),
        title: Container(
          width: double.infinity,
          alignment: Alignment.bottomCenter,
          padding: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
          color: Colors.black12,
          child: Text(
            unitBook.titleUnitBook,
            style: const TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ),
        background: FadeInImage(
          placeholder: const AssetImage('assets/loading.gif'),
          image: NetworkImage(unitBook.urlMainImage),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
