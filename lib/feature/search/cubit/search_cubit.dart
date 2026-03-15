import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bookia/feature/home/data/models/books_model.dart';
import 'package:bookia/feature/search/data/repo/search_repo.dart';
import 'package:meta/meta.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitial());

  Timer? _debounce;
  String _lastQuery = '';

  void onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    if (query.trim().isEmpty) {
      _lastQuery = '';
      emit(SearchInitial());
      return;
    }

    _debounce = Timer(const Duration(milliseconds: 500), () {
      // distinct — skip if same query after trim
      if (query.trim() == _lastQuery) return;
      _lastQuery = query.trim();
      searchBooks(_lastQuery);
    });
  }

  Future<void> searchBooks(String query) async {
    emit(SearchLoading());

    final response = await SearchRepo.searchBooks(query);
    if (isClosed) return;

    if (response == null) {
      emit(SearchError());
    } else {
      final books = response.data?.products ?? [];
      books.isEmpty ? emit(SearchEmpty()) : emit(SearchSuccess(books));
    }
  }

  @override
  Future<void> close() {
    _debounce?.cancel();
    return super.close();
  }
}
