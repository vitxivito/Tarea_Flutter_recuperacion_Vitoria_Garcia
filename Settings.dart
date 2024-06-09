class Settings {
  String userName;
  int timeLimit;
  int numberOfCards;
  int cardTime;

  Settings({required this.userName, 
            required this.timeLimit, 
            required this.numberOfCards, 
            required this.cardTime
          });

  Settings.empty({
    this.userName = '',
    this.timeLimit = 0,
    this.numberOfCards = 0,
    this.cardTime = 0,
  });

  Map<String, dynamic> toJson() {
    return {
      'userName': userName,
      'timeLimit': timeLimit,
      'numberOfCards': numberOfCards,
      'cardTime': cardTime,
    };
  }

  factory Settings.fromJson(Map<String, dynamic> json) {
    return Settings(
      userName: json['userName'],
      timeLimit: json['timeLimit'],
      numberOfCards: json['numberOfCards'],
      cardTime: json['cardTime'],
    );
  }
}