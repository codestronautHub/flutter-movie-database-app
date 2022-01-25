import 'package:dartz/dartz.dart';
import '../../core.dart';
import '../entities/tv_detail.dart';
import '../repositories/tv_repository.dart';

class GetTvDetail {
  final TvRepository repository;

  GetTvDetail(this.repository);

  Future<Either<Failure, TvDetail>> execute(int id) {
    return repository.getTvDetail(id);
  }
}
