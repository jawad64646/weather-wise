import 'package:fpdart/fpdart.dart';
import 'package:weatherwise/features/search/domain/entities/SearchEntity.dart';
import 'package:weatherwise/features/search/domain/repositories/search_repo.dart';

class GetSearchedResultUseCase {
  final SearchRepo searchRepo;

  GetSearchedResultUseCase(this.searchRepo);

  Future<Either<String, List<ResultEntity>>> call(String query) async {
    return await searchRepo.getSearchedResult(query);
  }
}
