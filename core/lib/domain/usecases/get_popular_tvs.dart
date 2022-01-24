import 'package:dartz/dartz.dart';
import '../../core.dart';
import '../entities/tv.dart';
import '../repositories/tv_repository.dart';

class GetPopularTvs {
  final TvRepository repository;

  GetPopularTvs(this.repository);

  Future<Either<Failure, List<Tv>>> execute() {
    return repository.getPopularTvs();
  }
}
