class MyRoutes {
  static String home = '/home';
  static String signIn = '/sign-in';
  static String signUp = '/sign_up';
  static String emailForgotPassword = '/forgot-password/get-email';
  static String codeForgotPassword = '/forgot-password/validation-code';
  static String changePassword = '/change-password';
  static String notifications = '/notifications';
  static String createProject = '/create-project';
  static String createProjectDescription = '/create-project/description';
  static String configuration = '/configuration';
  static String myAccount = '/my-account';
  static String help = '/help';
  static String contactUs = '/help/contact-us';
  static String configurationAccount = '/configuration/account';
  static String twoStepVerification = '/configuration/account/two-step';
  static String changeNumberOrEmail =
      '/configuration/account/change-number-email';
  static String changeNumber = '/configuration/account/change-number';
  static String changeEmail = '/configuration/account/change-email';
  static String configurationDeleteAccount =
      '/configuration/account/delete-account';
  static String chat = '/home/chat/:projectId';
}
