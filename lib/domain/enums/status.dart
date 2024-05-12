enum TaskStatus { complete, incomplete, pending }

extension TaskStatusX on TaskStatus {
  String get label => switch (this) {
        TaskStatus.incomplete => 'Incompleto',
        TaskStatus.pending => 'Pendente',
        _ => 'Completo',
      };
}
