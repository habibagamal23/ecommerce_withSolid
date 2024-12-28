import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../home/data/models/product.dart';
import '../data/repo/search_repo.dart';
import 'package:rxdart/rxdart.dart';
part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final SearchRepo searchRepo;
  final Map<String, List<Product>> _cache = {}; // Caching
  final _queryController = BehaviorSubject<String>(); // Manages search input

  SearchCubit(this.searchRepo) : super(SearchInitial()) {
    // Listen to query stream with debounceTime
    _queryController
        .debounceTime(const Duration(milliseconds: 500))
        .distinct()
        .listen(_handleSearchQuery);
  }

  void search(String query) {
    _queryController.add(query); // Add query to the stream
  }

  Future<void> _handleSearchQuery(String query) async {
    final trimmedQuery = query.trim();
    if (trimmedQuery.isEmpty) {
      emit(SearchInitial());
      return;
    }

    // Check cache
    if (_cache.containsKey(trimmedQuery)) {
      emit(SearchSuccess(_cache[trimmedQuery]!));
      return;
    }

    emit(SearchLoading());
    try {
      final result = await searchRepo.Searchproduct(trimmedQuery);
      if (result.isSuccess) {
        final products = result.data!.products;
        _cache[trimmedQuery] = products!; // Cache results
        emit(SearchSuccess(products));
      } else {
        emit(SearchError(result.error ?? 'Error fetching results.'));
      }
    } catch (e) {
      emit(SearchError('Error: ${e.toString()}'));
    }
  }

  @override
  Future<void> close() {
    _queryController.close(); // Dispose of the stream
    return super.close();
  }
}
