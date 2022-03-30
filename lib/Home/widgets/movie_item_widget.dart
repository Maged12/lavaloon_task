import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/movie_model.dart';
import '../../auth_feature/providers/user_provider.dart';
import 'package:provider/provider.dart';

class MovieItem extends StatelessWidget {
  final Movie? movie;
  final String buttonTitle;
  final void Function()? buttonAction;
  const MovieItem({
    Key? key,
    this.movie,
    required this.buttonTitle,
    this.buttonAction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FadeInImage(
          fit: BoxFit.fill,
          placeholder: const AssetImage("assets/images/placeholder.png"),
          image: NetworkImage(
            "https://image.tmdb.org/t/p/w500${movie?.posterPath}",
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Text(
                      movie?.title ?? "No Title",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.acme(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  if (context.select(
                          (UserProvider userProvider) => userProvider.user) !=
                      null)
                    ElevatedButton.icon(
                      onPressed: buttonAction,
                      label: Text(buttonTitle),
                      icon: Icon(buttonTitle == "Add to WatchList"
                          ? Icons.favorite_border_outlined
                          : Icons.favorite),
                    )
                ],
              ),
              Divider(
                color: Colors.black,
                endIndent: MediaQuery.of(context).size.width * .15,
                indent: MediaQuery.of(context).size.width * .15,
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(
            movie?.overview ?? "No Desc",
            style: GoogleFonts.acme(fontSize: 16),
          ),
        ),
      ],
    );
  }
}
