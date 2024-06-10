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

  static String toMap(String value) => switch (value) {
        CriticalityEnumM.urgent => 'HIGH',
        CriticalityEnumM.important => 'MEDIUM',
        _ => 'LOW',
      };
}
