class Contribution{
  final String author;
  final String category;
  final String moderator;
  final String repository;
  final String created;
  final String reviewDate;
  final String title;
  final double totalPayout;
  final String url;
  final String status;

  Contribution({
    this.author,
    this.category,
    this.moderator,
    this.created,
    this.repository,
    this.reviewDate,
    this.status,
    this.title,
    this.totalPayout,
    this.url
  });

  Contribution.fromJson(Map json)
    :author = json['author'],
    category = (json['category'] as String)
    .replaceFirst('-task', '').replaceFirst("task-", ''),
    moderator = json['moderator'],
    repository = (json['repository'] as String)
      .replaceFirst("http://github.com", ""),
    title = json['title'],
    totalPayout = json["total_payout"] as double,
    url = json["url"],
    created = json["created"],
    reviewDate = json["review_date"],
    status = json["status"];
}

class GitHubModel{
  final String tagName;
  final String htmlUrl;

  GitHubModel(this.tagName, this.htmlUrl);

  GitHubModel.fromJson(Map json)
  : this.tagName = json["tag_name"],
  this.htmlUrl = json["html_url"];
}