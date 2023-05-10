import 'package:flutter/material.dart';

class ThemeDetailsScreen extends StatelessWidget {
  const ThemeDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
      slivers: [
        _CustomAppBar(),
        SliverList(
            delegate: SliverChildListDelegate(
                [_PosterAndTitle(), _Overview(), _Actors()]))
      ],
    ));
  }
}

class _CustomAppBar extends StatelessWidget {
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
          child: const Text(
            "Definición de Funciones Algebraicas y Diagramas Algebraicas",
            style: TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ),
        background: const FadeInImage(
          placeholder: AssetImage('assets/loading.gif'),
          image: NetworkImage(
              "https://4.bp.blogspot.com/-_iS2aIwixHg/WYJ23N3nElI/AAAAAAAABFw/EtIzL5wqd3UFWsPawlCGVpodD-Q1Ol1cACEwYBhgL/s1600/unidad1.png"),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class _PosterAndTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: const FadeInImage(
              placeholder: AssetImage('assets/no-image.jpg'),
              image: NetworkImage(
                  "https://4.bp.blogspot.com/-_iS2aIwixHg/WYJ23N3nElI/AAAAAAAABFw/EtIzL5wqd3UFWsPawlCGVpodD-Q1Ol1cACEwYBhgL/s1600/unidad1.png"),
              height: 120,
            ),
          ),
          const SizedBox(width: 20),
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: size.width - 190),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("UNIDAD 1",
                    style: textTheme.headline5,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2),
                Text('Temas: ' '8',
                    style: textTheme.headline6,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                            'Reconocer funciones de manera algebraica' '',
                            style: textTheme.caption),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                            'Definir de manera grafica con diagramas de Venn'
                            '',
                            style: textTheme.caption),
                      )
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
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: Text(
        "Contenido",
        textAlign: TextAlign.justify,
        style: Theme.of(context).textTheme.titleLarge,
      ),
    );
  }
}

class _Actors extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          child: Text(
            "Leción 1: Fuciones de Primer Grado",
            textAlign: TextAlign.justify,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: Text(
                "Lorem",
                textAlign: TextAlign.justify,
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
