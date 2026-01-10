enum EnvironmentEnum { dev, prod, preprod }

class Environment {
  EnvironmentEnum? _environment;
  static final Environment _instance = Environment._internal();

  Environment._internal();

  factory Environment() {
    return _instance;
  }

  EnvironmentEnum? get environment => _environment;

  void setEnvironment(EnvironmentEnum env) {
    _environment = env;
  }

  bool get isDev => _environment == EnvironmentEnum.dev;
  bool get isProd => _environment == EnvironmentEnum.prod;
}
