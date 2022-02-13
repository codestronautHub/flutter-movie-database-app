import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';

import '../entities/tv.dart';
import '../repositories/tv_repository.dart';

class GetOnTheAirTvs {
  final TvRepository repository;

  GetOnTheAirTvs(this.repository);

  Future<Either<Failure, List<Tv>>> execute() {
    return repository.getOnTheAirTvs();
  }
}
