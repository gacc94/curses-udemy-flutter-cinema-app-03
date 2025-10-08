import 'package:cinema_app_03/domain/entities/movie.dart';
import 'package:cinema_app_03/infrastructure/models/moviedb/movie_moviedb.dart';
import 'package:cinema_app_03/infrastructure/models/moviedb/movie_detail.dart';

class MovieMapper {
  static Movie toMovie(MovieMovieDB movieDb) {
    return Movie(
      adult: movieDb.adult,
      backdropPath: movieDb.backdropPath != ''
          ? 'https://image.tmdb.org/t/p/w500/${movieDb.backdropPath}.jpg'
          : 'https://image.tmdb.org/t/p/w500/1E5baAaEse26fej7uHcjOgEE2t2.jpg',
      genreIds: movieDb.genreIds
          .map((e) => MovieGenre(id: e, name: e.toString()))
          .toList(),
      id: movieDb.id,
      originalLanguage: movieDb.originalLanguage,
      originalTitle: movieDb.originalTitle,
      overview: movieDb.overview,
      popularity: movieDb.popularity,
      posterPath: movieDb.posterPath != ''
          ? 'https://image.tmdb.org/t/p/w500/${movieDb.posterPath}.jpg'
          : 'no-poster',
      releaseDate: movieDb.releaseDate,
      title: movieDb.title,
      video: movieDb.video,
      voteAverage: movieDb.voteAverage,
      voteCount: movieDb.voteCount,
    );
  }

  static Movie movieDetailToMovie(MovieDetails movieDetails) {
    return Movie(
      adult: movieDetails.adult,
      backdropPath: movieDetails.backdropPath != ''
          ? 'https://image.tmdb.org/t/p/w500/${movieDetails.backdropPath}.jpg'
          : 'https://image.tmdb.org/t/p/w500/1E5baAaEse26fej7uHcjOgEE2t2.jpg',
      genreIds: movieDetails.genres
          .map((e) => MovieGenre(id: e.id, name: e.name))
          .toList(),
      id: movieDetails.id,
      originalLanguage: movieDetails.originalLanguage,
      originalTitle: movieDetails.originalTitle,
      overview: movieDetails.overview,
      popularity: movieDetails.popularity,
      posterPath: movieDetails.posterPath != ''
          ? 'https://image.tmdb.org/t/p/w500/${movieDetails.posterPath}.jpg'
          : 'https://images.fineartamerica.com/images/artworkimages/mediumlarge/3/do-not-go-where-the-path-may-lead-ralph-waldo-emerson-typographic-quote-poster-02-studio-grafiikka.jpg',
      releaseDate: movieDetails.releaseDate,
      title: movieDetails.title,
      video: movieDetails.video,
      voteAverage: movieDetails.voteAverage,
      voteCount: movieDetails.voteCount,
    );
  }
}
