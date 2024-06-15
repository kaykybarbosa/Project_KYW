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
  static const String urgent = 'Urgente';
  static const String important = 'Importante';
  static const String standard = 'Normal';

  static CriticalityEnum fromMap(String value) => switch (value) {
        'HIGH' => CriticalityEnum.high,
        'MEDIUM' => CriticalityEnum.medium,
        _ => CriticalityEnum.low,
      };

  static String toLabel(String value) => switch (value) {
        urgent => 'HIGH',
        important => 'MEDIUM',
        _ => 'LOW',
      };

  static String toMap(CriticalityEnum? value) => switch (value) {
        CriticalityEnum.high => 'HIGH',
        CriticalityEnum.medium => 'MEDIUM',
        _ => 'LOW',
      };
}
