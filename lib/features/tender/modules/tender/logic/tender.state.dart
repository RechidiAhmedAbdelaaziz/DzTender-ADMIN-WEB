// ignore_for_file: library_private_types_in_public_api

part of 'tender.cubit.dart';

enum _TenderStatus { initial, loading, loaded, success, error }

class TenderState extends ErrorState {
  TenderDTO? _tenderDTO;
  final _TenderStatus status;

  TenderState({
    TenderDTO? tenderDTO,
    this.status = _TenderStatus.initial,
    String? error,
  })  : _tenderDTO = tenderDTO,
        super(error);

  TenderDTO get tenderDTO => _tenderDTO!;
  bool get isLoading => status == _TenderStatus.loading;
  bool get isUpdating => _tenderDTO is UpdateTenderDTO;

  factory TenderState.initial() => TenderState();

  TenderState _loading() => _copyWith(status: _TenderStatus.loading);

  TenderState _loaded(TenderDTO tenderDTO) =>
      _copyWith(status: _TenderStatus.loaded, tenderDTO: tenderDTO);

  TenderState _success() => _copyWith(status: _TenderStatus.success);

  TenderState _error(String error) =>
      _copyWith(status: _TenderStatus.error, error: error);

  TenderState _copyWith({
    TenderDTO? tenderDTO,
    _TenderStatus? status,
    String? error,
  }) {
    return TenderState(
      tenderDTO: tenderDTO ?? _tenderDTO,
      status: status ?? this.status,
      error: error,
    );
  }
}
