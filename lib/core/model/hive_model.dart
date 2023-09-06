class HivePost {
  final int postId;
  final String author;
  final String permlink;
  final String category;
  final String title;
  final String body;
  final HivePostMetadata jsonMetadata;
  final String created;
  final String updated;
  final int depth;
  final int children;
  final int netRshares;
  final bool isPaidout;
  final String payoutAt;
  final double payout;
  final String pendingPayoutValue;
  final String authorPayoutValue;
  final String curatorPayoutValue;
  final String promoted;
  final List<dynamic> replies;
  final double authorReputation;
  final HivePostStats stats;
  final String url;
  final List<dynamic> beneficiaries;
  final String maxAcceptedPayout;
  final int percentHbd;
  final List<dynamic> activeVotes;

  HivePost({
    required this.postId,
    required this.author,
    required this.permlink,
    required this.category,
    required this.title,
    required this.body,
    required this.jsonMetadata,
    required this.created,
    required this.updated,
    required this.depth,
    required this.children,
    required this.netRshares,
    required this.isPaidout,
    required this.payoutAt,
    required this.payout,
    required this.pendingPayoutValue,
    required this.authorPayoutValue,
    required this.curatorPayoutValue,
    required this.promoted,
    required this.replies,
    required this.authorReputation,
    required this.stats,
    required this.url,
    required this.beneficiaries,
    required this.maxAcceptedPayout,
    required this.percentHbd,
    required this.activeVotes,
  });

  factory HivePost.fromJson(Map<String, dynamic> json) {
    return HivePost(
      postId: json['post_id'],
      author: json['author'],
      permlink: json['permlink'],
      category: json['category'],
      title: json['title'],
      body: json['body'],
      jsonMetadata: HivePostMetadata.fromJson(json['json_metadata']),
      created: json['created'],
      updated: json['updated'],
      depth: json['depth'],
      children: json['children'],
      netRshares: json['net_rshares'],
      isPaidout: json['is_paidout'],
      payoutAt: json['payout_at'],
      payout: json['payout'],
      pendingPayoutValue: json['pending_payout_value'],
      authorPayoutValue: json['author_payout_value'],
      curatorPayoutValue: json['curator_payout_value'],
      promoted: json['promoted'],
      replies: json['replies'],
      authorReputation: json['author_reputation'],
      stats: HivePostStats.fromJson(json['stats']),
      url: json['url'],
      beneficiaries: json['beneficiaries'],
      maxAcceptedPayout: json['max_accepted_payout'],
      percentHbd: json['percent_hbd'],
      activeVotes: json['active_votes'],
    );
  }
}

class HivePostStats {
  final bool hide;
  final bool gray;
  final int totalVotes;
  final double flagWeight;

  HivePostStats({
    required this.hide,
    required this.gray,
    required this.totalVotes,
    required this.flagWeight,
  });

  factory HivePostStats.fromJson(Map<String, dynamic> json) {
    return HivePostStats(
      hide: json['hide'],
      gray: json['gray'],
      totalVotes: json['total_votes'],
      flagWeight: json['flag_weight'].toDouble(),
    );
  }
}

class HivePostMetadata {
  final List<dynamic> image;
  HivePostMetadata({
    required this.image,
  });

  factory HivePostMetadata.fromJson(Map<String, dynamic> json) {
    final imageList = json['image'];
    final image = imageList != null ? List<String>.from(imageList) : [];
    return HivePostMetadata(
      image: image,
    );
  }
}
