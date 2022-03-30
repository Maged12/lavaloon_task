import 'package:flutter/material.dart';
import '../providers/movies_provider.dart';
import 'package:provider/provider.dart';

class PaginationWidget extends StatelessWidget {
  final MoviesProvider moviesProvider;
  const PaginationWidget({Key? key, required this.moviesProvider})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: Icon(Icons.adaptive.arrow_back),
          onPressed: (moviesProvider.nowPlaying?.page ?? 0 )> 1
              ? () => context
                  .read<MoviesProvider>()
                  .getNowPlayingList(moviesProvider.nowPlaying!.page! - 1)
              : null,
        ),
        const SizedBox(
          width: 20,
        ),
        Text(moviesProvider.nowPlaying?.page.toString() ?? ""),
        const SizedBox(
          width: 20,
        ),
        IconButton(
          icon: Icon(Icons.adaptive.arrow_forward),
          onPressed: (moviesProvider.nowPlaying?.page ?? 1) <
                  (moviesProvider.nowPlaying?.totalPages ?? 0)
              ? () => context
                  .read<MoviesProvider>()
                  .getNowPlayingList(moviesProvider.nowPlaying!.page! + 1)
              : null,
        )
      ],
    );
  }
}
