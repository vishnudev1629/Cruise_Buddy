part of 'get_seached_cruiseresults_bloc.dart';

@freezed
class GetSeachedCruiseresultsState with _$GetSeachedCruiseresultsState {
  const factory GetSeachedCruiseresultsState.initial() = _Initial;
  const factory GetSeachedCruiseresultsState.loading() = _Loading;
  const factory GetSeachedCruiseresultsState.getuseruccess(
          {required PackageSearchResultsModel packagesearchresults}) =
      _GetSeachedCruiseresults;

  const factory GetSeachedCruiseresultsState.getuserFailure(
      {required String error}) = GetSeachedCruiseFailure;
  const factory GetSeachedCruiseresultsState.noInternet() = _NoInternet;
}
