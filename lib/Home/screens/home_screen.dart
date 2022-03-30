import 'package:flutter/material.dart';
import '../providers/movies_provider.dart';
import '../providers/watchList_provider.dart';
import 'watch_list_screen.dart';
import '../widgets/movie_item_widget.dart';
import '../widgets/pagination_widget.dart';
import '../../auth_feature/providers/auth_provider.dart';
import '../../auth_feature/providers/user_provider.dart';
import '../../core/constants/global.dart';
import '../../core/constants/strings.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    if (context.read<AuthProvider>().sessionId == null) {
      final String sessionId = Global.prefs.getString(Strings.sessionIdKey);
      if (sessionId.isNotEmpty) {
        Future.delayed(Duration.zero).then((_) {
          context.read<AuthProvider>().setSessionId = sessionId;
          context.read<UserProvider>().getUserData(sessionId, Global.apiKey);
        });
      }
    } else {
      Future.delayed(Duration.zero).then((_) => context
          .read<UserProvider>()
          .getUserData(context.read<AuthProvider>().sessionId!, Global.apiKey));
    }
    Future.delayed(Duration.zero)
        .then((value) => context.read<MoviesProvider>().getNowPlayingList(1));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton:
          context.select((UserProvider userProvider) => userProvider.user) ==
                  null
              ? null
              : FloatingActionButton(
                  onPressed: () {
                    context.read<WatchListProvider>().getWatchList(
                        context.read<UserProvider>().user!.id!,
                        1,
                        context.read<AuthProvider>().sessionId!);
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => const WatchList(),
                      ),
                    );
                  },
                  tooltip: "WatchList",
                  child: const Icon(Icons.favorite),
                ),
      body: Consumer<MoviesProvider>(
        builder: (context, moviesProvider, _) {
          return moviesProvider.isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Column(
                  children: [
                    Expanded(
                      child: ListView.separated(
                        separatorBuilder: (BuildContext context, int index) =>
                            const Divider(
                          color: Colors.black,
                          thickness: 2,
                        ),
                        itemBuilder: (ctx, index) => MovieItem(
                          movie: moviesProvider.nowPlaying?.movies?[index],
                          buttonTitle: "Add to WatchList",
                          buttonAction: context
                                  .watch<WatchListProvider>()
                                  .isLoading
                              ? null
                              : () async {
                                  final isAddedSuc = await context
                                      .read<WatchListProvider>()
                                      .addToWatchList(
                                        context.read<UserProvider>().user!.id!,
                                        context.read<AuthProvider>().sessionId!,
                                        moviesProvider
                                            .nowPlaying!.movies![index].id!,
                                      );
                                  if (isAddedSuc) {
                                    ScaffoldMessenger.of(context)
                                        .clearSnackBars();
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                            "${moviesProvider.nowPlaying?.movies?[index].title} added to WatchList"),
                                      ),
                                    );
                                  }
                                },
                        ),
                        itemCount:
                            moviesProvider.nowPlaying?.movies?.length ?? 0,
                      ),
                    ),
                    PaginationWidget(moviesProvider: moviesProvider),
                  ],
                );
        },
      ),
    );
  }
}
