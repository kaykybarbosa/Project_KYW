enum TypeNotification {
  alert,
  chat,
  task,
  invitation,
}

extension TypeNotificationX on TypeNotification {
  bool get isAlert => this == TypeNotification.alert;

  bool get isChat => this == TypeNotification.chat;

  bool get isTask => this == TypeNotification.task;

  bool get isInvitation => this == TypeNotification.invitation;
}
