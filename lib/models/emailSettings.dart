class EmailSettings {
  final String username;
  final String password;
  final String smtp;
  final int port;

  const EmailSettings({
    required this.username,
    required this.password,
    required this.smtp,
    required this.port,
  });
}
