enum CriticalityEnum {
  high,
  medium,
  low,
}

extension CriticalityEnumX on CriticalityEnum {
  bool get isHigh => this == CriticalityEnum.high;

  bool get isMedium => this == CriticalityEnum.medium;

  bool get isLow => this == CriticalityEnum.low;
}

class CriticalityEnumM {
  static CriticalityEnum fromMap(String value) => switch (value) {
        'HIGH' => CriticalityEnum.high,
        'MEDIUM' => CriticalityEnum.medium,
        _ => CriticalityEnum.low,
      };
}
