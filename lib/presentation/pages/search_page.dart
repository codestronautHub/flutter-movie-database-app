import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/provider/movie_search_notifier.dart';
import 'package:ditonton/presentation/provider/search_filter_notifier.dart';
import 'package:ditonton/presentation/provider/tv_search_notifier.dart';
import 'package:ditonton/presentation/widgets/item_card_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatelessWidget {
  static const ROUTE_NAME = '/search';

  TextEditingController _textEditingController = TextEditingController();

  Future<void> _showFilterSearchDialog({
    required BuildContext context,
    required Function(SearchFilter?) onMovieFilterSelected,
    required Function(SearchFilter?) onTvFilterSelected,
  }) async {
    return showDialog<void>(
      context: context,
      builder: (context) {
        return Consumer<SearchFilterNotifier>(builder: (context, data, child) {
          return AlertDialog(
            title: Text('Filter by'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                RadioListTile<SearchFilter>(
                  title: Text('Movie'),
                  value: SearchFilter.movie,
                  groupValue: data.filter,
                  onChanged: onMovieFilterSelected,
                ),
                RadioListTile<SearchFilter>(
                  title: Text('Tv'),
                  value: SearchFilter.tv,
                  groupValue: data.filter,
                  onChanged: onTvFilterSelected,
                ),
              ],
            ),
          );
        });
      },
    );
  }

  Widget _buildSearchResults(BuildContext context, SearchFilter filter) {
    if (filter == SearchFilter.movie) {
      return Consumer<MovieSearchNotifier>(
        builder: (context, data, child) {
          if (data.state == RequestState.Loading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (data.state == RequestState.Loaded) {
            final result = data.searchResult;
            return Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(8),
                itemBuilder: (context, index) {
                  final movie = data.searchResult[index];
                  return ItemCard(
                    type: ContentType.Movie,
                    movie: movie,
                  );
                },
                itemCount: result.length,
              ),
            );
          } else {
            return Expanded(
              child: Container(),
            );
          }
        },
      );
    } else {
      return Consumer<TvSearchNotifier>(
        builder: (context, data, child) {
          if (data.state == RequestState.Loading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (data.state == RequestState.Loaded) {
            final result = data.searchResult;
            return Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(8),
                itemBuilder: (context, index) {
                  final tv = data.searchResult[index];
                  print(tv.id);
                  return ItemCard(
                    type: ContentType.Tv,
                    tv: tv,
                  );
                },
                itemCount: result.length,
              ),
            );
          } else {
            return Expanded(
              child: Container(),
            );
          }
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search'),
      ),
      body: Consumer<SearchFilterNotifier>(
        builder: (context, data, child) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 6,
                      child: TextField(
                        controller: _textEditingController,
                        onSubmitted: (query) {
                          if (data.filter == SearchFilter.movie) {
                            Provider.of<MovieSearchNotifier>(context,
                                    listen: false)
                                .fetchMovieSearch(query);
                          } else {
                            Provider.of<TvSearchNotifier>(context,
                                    listen: false)
                                .fetchTvSearch(query);
                          }
                        },
                        decoration: InputDecoration(
                          hintText: 'Search title',
                          prefixIcon: Icon(Icons.search),
                          border: OutlineInputBorder(),
                        ),
                        textInputAction: TextInputAction.search,
                      ),
                    ),
                    SizedBox(width: 16.0),
                    Expanded(
                      child: IconButton(
                        onPressed: () {
                          _showFilterSearchDialog(
                            context: context,
                            onMovieFilterSelected: (SearchFilter? newValue) {
                              data.setFilter(newValue!);
                              _textEditingController.clear();
                              Navigator.pop(context);
                            },
                            onTvFilterSelected: (SearchFilter? newValue) {
                              data.setFilter(newValue!);
                              _textEditingController.clear();
                              Navigator.pop(context);
                            },
                          );
                        },
                        icon: Icon(Icons.filter_alt_outlined),
                        splashRadius: 20.0,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Text('Search Result', style: kHeading6),
                _buildSearchResults(context, data.filter),
              ],
            ),
          );
        },
      ),
    );
  }
}
