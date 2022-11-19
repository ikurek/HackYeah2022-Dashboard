class Post {
  int? fraudScore;
  int? id;
  int? socialScore;
  String? tweetAuthorDisplayName;
  String? tweetAuthorId;
  bool? tweetAuthorIsVerified;
  String? tweetAuthorUsername;
  String? tweetDate;
  String? tweetId;
  String? tweetText;

  Post(
      {this.fraudScore,
        this.id,
        this.socialScore,
        this.tweetAuthorDisplayName,
        this.tweetAuthorId,
        this.tweetAuthorIsVerified,
        this.tweetAuthorUsername,
        this.tweetDate,
        this.tweetId,
        this.tweetText});

  Post.fromJson(Map<String, dynamic> json) {
    fraudScore = json['fraud_score'];
    id = json['id'];
    socialScore = json['social_score'];
    tweetAuthorDisplayName = json['tweet_author_display_name'];
    tweetAuthorId = json['tweet_author_id'];
    tweetAuthorIsVerified = json['tweet_author_is_verified'];
    tweetAuthorUsername = json['tweet_author_username'];
    tweetDate = json['tweet_date'];
    tweetId = json['tweet_id'];
    tweetText = json['tweet_text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fraud_score'] = this.fraudScore;
    data['id'] = this.id;
    data['social_score'] = this.socialScore;
    data['tweet_author_display_name'] = this.tweetAuthorDisplayName;
    data['tweet_author_id'] = this.tweetAuthorId;
    data['tweet_author_is_verified'] = this.tweetAuthorIsVerified;
    data['tweet_author_username'] = this.tweetAuthorUsername;
    data['tweet_date'] = this.tweetDate;
    data['tweet_id'] = this.tweetId;
    data['tweet_text'] = this.tweetText;
    return data;
  }
}