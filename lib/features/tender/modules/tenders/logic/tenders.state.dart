// ignore_for_file: library_private_types_in_public_api

part of 'tenders.cubit.dart';

typedef _Tenders = PaginationResult<TenderModel>;

enum TendersStatus { initial, loading, loaded, error }

class TendersState extends ErrorState {
  final _Tenders _tenders;
  final TendersStatus _status;

  TendersState({
    _Tenders? tenders,
    TendersStatus status = TendersStatus.initial,
    String? error,
  })  : _tenders = tenders ?? PaginationResult<TenderModel>(),
        _status = status,
        super(error);

  factory TendersState.initial() => TendersState();

  TendersState _loading() => _copyWith(status: TendersStatus.loading);

  TendersState _fetchSuccess(_Tenders tenders) => _copyWith(
        tenders: tenders,
        status: TendersStatus.loaded,
      );

  TendersState _failure(String error) => _copyWith(
        status: TendersStatus.error,
        error: error,
      );

  TendersState _copyWith({
    _Tenders? tenders,
    TendersStatus? status,
    String? error,
  }) {
    return TendersState(
      tenders: tenders ?? _tenders,
      status: status ?? _status,
      error: error,
    );
  }

  List<TenderModel> get tenders => _tenders.data;
  Pagination get pagination => _tenders.pagination;

  bool get isLoading => _status == TendersStatus.loading;
}
