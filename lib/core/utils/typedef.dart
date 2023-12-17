import 'package:clean_and_bloc/core/errors/failure.dart';
import 'package:dartz/dartz.dart';

typedef ResultFuture<T> = Future<Either<Failure, T>>;

typedef ResultVoid = Future<void>;

typedef DataMap = Map<String, dynamic>;