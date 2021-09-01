import 'package:flutter/material.dart';
import 'package:flutter_app/model/movie_model.dart';
import 'package:flutter_app/providers/movie_provider.dart';

class DataSearch extends SearchDelegate {
  final movies = [
    'Lion King',
    'Ted',
    'Aquaman',
    'Frozen',
    'Batman',
    'Ironman',
  ];

  final recentMovies = [
    'Spiderman',
    'Captain America',
  ];

  final moviesProvider = new MoviesProvider();

  @override
  List<Widget> buildActions(BuildContext context) {
    // acciones del appbar
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = ''; //elimina el texto del buscador
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // icono a la izquierda del buscador
    return IconButton(
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
        ),
        onPressed: () {
          //metodo propio del delegate para cerrar el buscador
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    // builder que crea los resultados a mostrar
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // sugerencias que aparecen en el buscador
    if (query.isEmpty) {
      return Container();
    }
    return FutureBuilder(
      future: moviesProvider.searchMovie(query),
      builder: (BuildContext context, AsyncSnapshot<List<Movie>> snapshot) {
        if (snapshot.hasData) {
          final movies = snapshot.data;
          return ListView(
              children: movies.map((movie) {
                return ListTile(
                  leading: FadeInImage(
                    image: NetworkImage(movie.getMoviePoster()),
                    placeholder: AssetImage('assets/img/no-image.jpg'),
                    width: 50.0,
                    fit: BoxFit.contain,
                  ),
                  title: Text(movie.title),
                  subtitle: Text(movie.originalTitle),
                  onTap: () {
                    close(context, null); // cerrar el buscador
                    movie.uniqueId = '';
                    Navigator.pushNamed(context, 'detail', arguments: movie);
                  },
                );
              }).toList());
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}