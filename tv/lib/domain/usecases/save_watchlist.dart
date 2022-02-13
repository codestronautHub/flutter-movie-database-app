import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';

import '../entities/tv_detail.dart';
import '../repositories/tv_repository.dart';

class SaveWatchlist {
  final TvRepository tvRepository;

  SaveWatchlist({required this.tvRepository});

  Future<Either<Failure, String>> executeTv(TvDetail tv) {
    return tvRepository.saveWatchlist(tv);
  }
}
