// ignore_for_file: constant_identifier_names

enum FilterEnum { Filter, Order }

extension FilterEnumZ on FilterEnum {
  bool get isFilter => this == FilterEnum.Filter;
}
