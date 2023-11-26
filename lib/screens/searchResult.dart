import 'package:flutter/material.dart';
import 'package:movie_app/widgets/search_slider.dart';
import '../api/api.dart';

class SearchedScreen extends StatelessWidget {

  final String searchedMovie;

  const SearchedScreen({super.key, required this.searchedMovie});
  // late Future<List<Movie>> searchedMovies;

  // @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Search results for  $searchedMovie ',
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const Text('SEARCH RESULTS'),
            const SizedBox(height: 20),
            SizedBox(
              child: FutureBuilder(
                  future:
                  Api.instance.getSearchedMovies(
                      movieName: searchedMovie),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(
                        child: Text(snapshot.error.toString()),
                      );
                    } else if (snapshot.hasData) {
                      return SearchSlider(
                        snapshot: snapshot,
                      );
                    } else {
                      return const Center(child: CircularProgressIndicator(
                        color: Colors.red,
                      ));
                    }
                  }),
            )
          ],
        ),
      ),
    );
  }
}

// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:movie_app/api/api.dart';
// import 'package:movie_app/widgets/search_slider.dart';
// import '../constants.dart';
// import '../models/movie.dart';
// import 'package:http/http.dart' as http;
//
// class SearchedScreen extends StatefulWidget {
//   final String searchedMovie;
//
//   const SearchedScreen({super.key, required this.searchedMovie});
//
//   static const _searchedMovieUrl =
//       'https://api.themoviedb.org/3/search/movie?api_key=${Constants.apiKey}';
//
//   @override
//   State<SearchedScreen> createState() => _SearchedScreenState();
// }
//
// class _SearchedScreenState extends State<SearchedScreen> {
//   static const _searchedMovieUrl =
//       'https://api.themoviedb.org/3/search/movie?api_key=${Constants.apiKey}';
//
//   Future<List<Movie>> getSearchedMovies({required String movieName}) async {
//     List<Movie> movieList = [];
//
//     var url = '$_searchedMovieUrl&query=$movieName';
//     final response = await http.get(Uri.parse(url));
//     if (response.statusCode == 200) {
//       final decodedData = json.decode(response.body)['results'] as List;
//       decodedData.forEach((showData) {
//         Movie movies = Movie.fromJson(showData);
//         movieList.add(movies);
//         print(showData['original_title']);
//       });
//       return movieList;
//       // return decodedData.map((movie) => Movie.fromJson(movie)).toList();
//     } else {
//       throw Exception('Something happened');
//     }
//   }
//
//   late Future<List<Movie>> searchedMovies;
//   late String movieName = '';
//
//   @override
//   void initState() {
//     searchedMovies = Api.instance.getSearchedMovies(movieName: movieName);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       child: FutureBuilder(
//           future: searchedMovies,
//           builder: (context, AsyncSnapshot<List<Movie>> snapshot) {
//             if (snapshot.hasError) {
//               return Center(
//                 child: Text(snapshot.error.toString()),
//               );
//             } else if (snapshot.hasData) {
//               print(snapshot);
//               return ListSlider(snapshot: snapshot);
//             } else {
//               return const Center(child: CircularProgressIndicator());
//             }
//             // if (!snapshot.hasData) {
//             //   return const CircularProgressIndicator();
//             // }
//             // else{
//             //   return ListSlider(snapshot: snapshot);
//             //   // return ListView.builder(
//             //   //     itemCount: 4,
//             //   //     itemBuilder: (context, index) {
//             //   //       return  Card(
//             //   //         child: Column(
//             //   //           children: [
//             //   //             Text('original_name'),
//             //   //             Text(snapshot.data![index].toString()),
//             //   //           ],
//             //   //         ),
//             //   //       );
//             //   //     });
//             // }
//
//           }
//           //   if (snapshot.hasError) {
//           //     return Center(
//           //       child: Text(snapshot.error.toString()),
//           //     );
//           //   } else if (snapshot.hasData) {
//           //     return TrendingSlider(
//           //       snapshot: snapshot,
//           //     );
//           //   } else {
//           //     return const Center(child: CircularProgressIndicator());
//           //   }
//           // },
//           ),
//     );
//   }
// }
//
// //
// // class SearchedScreen extends StatefulWidget {
// //   final String searchedMovie;
// //
// //   const SearchedScreen({super.key, required this.searchedMovie});
// //
// //   @override
// //   State<SearchedScreen> createState() => _SearchedScreenState();
// // }
// // class _SearchedScreenState extends State<SearchedScreen> {
// //   List<Movie> searchedMoviesList = [];
// //   bool searched = false;
// //
// //   _initSearchResult() async {
// //     List<Movie>? list =
// //         await Api.instance.getSearchedMovies(movieName: widget.searchedMovie);
// //     if (mounted) {
// //       setState(() {
// //         searchedMoviesList = list;
// //         searched = true;
// //       });
// //     }
// //   }
// //
// //   @override
// //   void initState() {
// //     // TODO: implement initState
// //     _initSearchResult();
// //     super.initState();
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return (searchedMoviesList.isEmpty)
// //         ? (searched)
// //             ? const Center(
// //                 child: Text("Nothing Found"),
// //               )
// //             : Center(
// //                 child: CircularProgressIndicator(
// //                   valueColor: AlwaysStoppedAnimation<Color>(
// //                     Theme.of(context).primaryColor,
// //                   ),
// //                 ),
// //               )
// //         : ListView.builder(
// //             itemBuilder: (context, index) {
// //               var movie = searchedMoviesList[index];
// //               return InkWell(
// //                 onTap: () {
// //                   Navigator.push(
// //                     context,
// //                     MaterialPageRoute(
// //                       builder: (_) => DetailsScreen(movie: movie),
// //                     ),
// //                   );
// //                 },
// //               );
// //             },
// //           );
// //   }
// // }
