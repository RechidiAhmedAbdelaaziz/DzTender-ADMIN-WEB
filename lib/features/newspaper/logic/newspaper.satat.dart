// ignore_for_file: library_private_types_in_public_api

part of 'newspaper.cubit.dart';

enum _NewsPaperStatus {
  initial,
  loading,
  loaded,
  creating,
  created,
  updating,
  updated,
  deleting,
  deleted,
  error
}

class NewsPaperState extends ErrorState {
  final PaginationResult<NewsPaperModel> _pagination;
  final _NewsPaperStatus status;

  NewsPaperState({
    PaginationResult<NewsPaperModel>? pagination,
    this.status = _NewsPaperStatus.initial,
    String? error,
  })  : _pagination =
            pagination ?? PaginationResult<NewsPaperModel>(),
        super(error);

  List<NewsPaperModel> get newspapers => _pagination.data;
  Pagination get pagination => _pagination.pagination;

  factory NewsPaperState.initial() => NewsPaperState();

  NewsPaperState _loading(_NewsPaperStatus status) =>
      _copyWith(status: status);

  NewsPaperState _loaded(
          PaginationResult<NewsPaperModel> newPagination) =>
      _copyWith(
        pagination: newPagination,
        status: _NewsPaperStatus.loaded,
      );

  NewsPaperState _addElement(NewsPaperModel newspaper) => _copyWith(
      pagination: _pagination.add(newspaper),
      status: _NewsPaperStatus.created);

  NewsPaperState _updateElement(NewsPaperModel newspaper) =>
      _copyWith(
          pagination: _pagination.replace(newspaper),
          status: _NewsPaperStatus.updated);

  NewsPaperState _removeElement(NewsPaperModel newspaper) =>
      _copyWith(
          pagination: _pagination.remove(newspaper),
          status: _NewsPaperStatus.deleted);

  NewsPaperState _error(String error) =>
      _copyWith(status: _NewsPaperStatus.error, error: error);

  NewsPaperState _copyWith({
    PaginationResult<NewsPaperModel>? pagination,
    _NewsPaperStatus? status,
    String? error,
  }) {
    return NewsPaperState(
      pagination: pagination ?? _pagination,
      status: status ?? this.status,
      error: error,
    );
  }

  bool get isLoading => status == _NewsPaperStatus.loading;
  bool get isWaiting =>
      status == _NewsPaperStatus.creating ||
      status == _NewsPaperStatus.updating ||
      status == _NewsPaperStatus.deleting;
}
