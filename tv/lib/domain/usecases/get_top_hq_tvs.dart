import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';

import '../entities/tv.dart';
import '../repositories/tv_repository.dart';

class GetTopHqTvs {
  final TvRepository repository;

  GetTopHqTvs(this.repository);

  Future<Either<Failure, List<Tv>>> execute() {
    return repository.getTopHqTvs();
  }
}
