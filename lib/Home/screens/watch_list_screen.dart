import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../providers/watchList_provider.dart';
import '../widgets/movie_item_widget.dart';
import '../../auth_feature/providers/auth_provider.dart';
import '../../auth_feature/providers/user_provider.dart';
import 'package:provider/provider.dart';

class WatchList extends StatelessWidget {
  const WatchList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("WatchList"), centerTitle: true),
      body: Consumer<WatchListProvider>(
        builder: (context, watchListProvider, _) {
          return watchListProvider.isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : watchListProvider.watchList?.movies?.isEmpty ?? true
                  ? Center(
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text(
                          "There is no Movies in WatchList .",
                          style: GoogleFonts.aBeeZee(fontSize: 20),
                        ),
                      ),
                    )
                  : ListView.separated(
                      separatorBuilder: (BuildContext context, int index) =>
                          const Divider(
                        color: Colors.black,
                        thickness: 2,
                      ),
                      itemBuilder: (ctx, index) => MovieItem(
                        movie: watchListProvider.watchList?.movies?[index],
                        buttonTitle: "Remove from WatchList",
                        buttonAction: watchListProvider.isLoading
                            ? null
                            : () async {
                                final isRemovedSuc = await context
                                    .read<WatchListProvider>()
                                    .removeFromWatchList(
                                      context.read<UserProvider>().user!.id!,
                                      context.read<AuthProvider>().sessionId!,
                                      watchListProvider
                                          .watchList!.movies![index].id!,
                                    );
                                await context
                                    .read<WatchListProvider>()
                                    .getWatchList(
                                      context.read<UserProvider>().user!.id!,
                                      watchListProvider.watchList!.page!,
                                      context.read<AuthProvider>().sessionId!,
                                    );
                                if (isRemovedSuc) {
                                  ScaffoldMessenger.of(context).clearSnackBars();
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                          "One item Removed from WatchList"),
                                    ),
                                  );
                                }
                              },
                      ),
                      itemCount:
                          watchListProvider.watchList?.movies?.length ?? 0,
                    );
        },
      ),
    );
  }
}
