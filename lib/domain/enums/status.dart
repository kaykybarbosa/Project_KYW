enum TaskStatus { complete, incomplete, pending }

extension TaskStatusX on TaskStatus {
  String get label => switch (this) {
        TaskStatus.incomplete => 'Incompleto',
        TaskStatus.pending => 'Pendente',
        _ => 'Completo',
      };
}

class TaskStatusM {
  static TaskStatus fromMap(String value) => switch (value) {
        'OPEN' => TaskStatus.incomplete,
        'PENDING' => TaskStatus.pending,
        _ => TaskStatus.complete,
      };

  static String toMap(TaskStatus value) => switch (value) {
        TaskStatus.incomplete => 'OPEN',
        TaskStatus.pending => 'PENDING',
        _ => 'COMPLETE',
      };
}
