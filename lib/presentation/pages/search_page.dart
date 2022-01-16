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

  final TextEditingController _textEditingController = TextEditingController();

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
                itemCount: result.length,
                padding: EdgeInsets.zero,
                itemBuilder: (context, index) {
                  final movie = data.searchResult[index];
                  return ItemCard(
                    type: MdbContentType.Movie,
                    movie: movie,
                  );
                },
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
                itemCount: result.length,
                padding: EdgeInsets.zero,
                itemBuilder: (context, index) {
                  final tv = data.searchResult[index];
                  return ItemCard(
                    type: MdbContentType.Tv,
                    tv: tv,
                  );
                },
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
    return WillPopScope(
      onWillPop: () async {
        _textEditingController.clear();
        Provider.of<MovieSearchNotifier>(context, listen: false)
            .searchResult
            .clear();
        Provider.of<TvSearchNotifier>(context, listen: false)
            .searchResult
            .clear();
        return true;
      },
      child: Scaffold(
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
                            prefixIcon: Icon(
                              Icons.search,
                              color: Colors.white70,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(color: Colors.white),
                            ),
                          ),
                          textInputAction: TextInputAction.search,
                          cursorColor: Colors.white,
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
                                Provider.of<MovieSearchNotifier>(context,
                                        listen: false)
                                    .searchResult
                                    .clear();
                                Navigator.pop(context);
                              },
                              onTvFilterSelected: (SearchFilter? newValue) {
                                data.setFilter(newValue!);
                                _textEditingController.clear();
                                Provider.of<TvSearchNotifier>(context,
                                        listen: false)
                                    .searchResult
                                    .clear();
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
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    child: Row(
                      children: [
                        Text(
                          'Search Result for ',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        Text(
                          data.filter == SearchFilter.movie
                              ? 'Movie'
                              : 'Tv Shows',
                          style: kHeading6.copyWith(
                            color: Colors.redAccent,
                          ),
                        )
                      ],
                    ),
                  ),
                  _buildSearchResults(context, data.filter),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
