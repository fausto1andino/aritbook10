import 'package:flutter/material.dart';

import '../models/UnitModel/unit_model.dart';

class ThemeDetailsScreen extends StatelessWidget {
  const ThemeDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final UnitBook unitBook =
        ModalRoute.of(context)!.settings.arguments as UnitBook;

    return Scaffold(
        body: CustomScrollView(
      slivers: [
        _CustomAppBar(unitBook),
        SliverList(
            delegate: SliverChildListDelegate([
          _PosterAndTitle(unitBook),
          _Overview(unitBook),
          _Actors(unitBook)
        ]))
      ],
    ));
  }
}

class _CustomAppBar extends StatelessWidget {
  final UnitBook unitBook;

  const _CustomAppBar(this.unitBook);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.indigo,
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
            style: TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ),
        background: FadeInImage(
          placeholder: AssetImage('assets/loading.gif'),
          image: NetworkImage(unitBook.urlMainImage),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class _PosterAndTitle extends StatelessWidget {
  final UnitBook unitBook;

  const _PosterAndTitle(this.unitBook);
  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: size.width - 50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("",
                    style: textTheme.headline5,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2),
                Text('Temas: ' '${unitBook.unitSubject.length}',
                    style: textTheme.headline6,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('${unitBook.descriptionUnitBook}' '',
                            style: textTheme.caption),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _Overview extends StatelessWidget {
  final UnitBook unitBook;

  const _Overview(this.unitBook);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: Text(
        unitBook.unitSubject.first.topic.first.tittleTopic,
        textAlign: TextAlign.justify,
        style: Theme.of(context).textTheme.titleLarge,
      ),
    );
  }
}

class _Actors extends StatelessWidget {
  final UnitBook unitBook;

  const _Actors(this.unitBook);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          child: Text(
            unitBook.unitSubject[0].titleSubject,
            textAlign: TextAlign.justify,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: Text(
                unitBook.unitSubject[0].descriptionSubject,
                textAlign: TextAlign.justify,
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ),
          ],
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: FadeInImage(
            placeholder: AssetImage('assets/images/no-image.jpg'),
            image: NetworkImage(
                unitBook.unitSubject.first.topic.first.urlImageTopic),
            height: size.height * 0.3,
          ),
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: FadeInImage(
            placeholder: AssetImage('assets/images/no-image.jpg'),
            image:
                NetworkImage(unitBook.unitSubject.first.topic[1].urlImageTopic),
            height: size.height * 0.3,
          ),
        ),
      ],
    );
  }
}
