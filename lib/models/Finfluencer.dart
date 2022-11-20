class Finfluencer {
  String? tweetAuthorDisplayName;
  int? tweetAuthorId;
  double? fraudScore;
  double? socialScore;
  String? tweetAuthorUsername;

  Finfluencer(
      {this.fraudScore,
      this.socialScore,
      this.tweetAuthorDisplayName,
      this.tweetAuthorId,
      this.tweetAuthorUsername});

  Finfluencer.fromJson(Map<String, dynamic> json) {
    fraudScore = json['fraud_score'];
    socialScore = json['social_score'];
    tweetAuthorDisplayName = json['name'];
    tweetAuthorId = json['id'];
    tweetAuthorUsername = json['username'];
  }
}
