import 'package:bookia/feature/search/cubit/search_cubit.dart';
import 'package:bookia/feature/search/ui/widgets/search_empty_results.dart';
import 'package:bookia/feature/search/ui/widgets/search_error_view.dart';
import 'package:bookia/feature/search/ui/widgets/search_field.dart';
import 'package:bookia/feature/search/ui/widgets/search_prompt.dart';
import 'package:bookia/feature/search/ui/widgets/search_results_grid.dart';
import 'package:bookia/feature/search/ui/widgets/search_skeleton_grid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: SearchField(controller: _controller),
      ),
      body: BlocBuilder<SearchCubit, SearchState>(
        builder: (context, state) {
          if (state is SearchInitial) {
            return const SearchPrompt();
          } else if (state is SearchLoading) {
            return const SearchSkeletonGrid();
          } else if (state is SearchSuccess) {
            return SearchResultsGrid(books: state.books);
          } else if (state is SearchEmpty) {
            return SearchEmptyResult(query: _controller.text);
          } else if (state is SearchError) {
            return SearchErrorView(
              message: state.message,
              onRetry: () =>
                  context.read<SearchCubit>().onSearchChanged(_controller.text),
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
