import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'params.g.dart';

class NoParams extends Equatable {
  @override
  List<Object?> get props => [];
}

@JsonSerializable()
class PaginationParams extends Equatable {
  @JsonKey(name: 'page')
  final int page;
  @JsonKey(name: 'limit')
  final int limit;

  const PaginationParams({required this.page, required this.limit});
  factory PaginationParams.fromJson(Map<String, dynamic> json) =>
      _$PaginationParamsFromJson(json);
  Map<String, dynamic> toJson() => _$PaginationParamsToJson(this);
  @override
  List<Object?> get props => [page, limit];
}

@JsonSerializable()
class FilterParams extends Equatable {
  @JsonKey(name: 'search')
  final String? searchQuery;

  const FilterParams({this.searchQuery});

  factory FilterParams.fromJson(Map<String, dynamic> json) =>
      _$FilterParamsFromJson(json);

  Map<String, dynamic> toJson() => _$FilterParamsToJson(this);

  @override
  List<Object?> get props => [searchQuery];
}


