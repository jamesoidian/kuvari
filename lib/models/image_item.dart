class KuhaImage {
  final String author;
  final String name;
  final String thumb;
  final String url;
  final int uid;

  KuhaImage({
    required this.author,
    required this.name,
    required this.thumb,
    required this.url,
    required this.uid,
  });

  // Tehdään tehtaan konstruktori, joka luo olion JSONista.
  factory KuhaImage.fromJson(Map<String, dynamic> json) {
    return KuhaImage(
      author: json['author'] ?? '',
      name: json['name'] ?? '',
      thumb: json['thumb'] ?? '',
      url: json['url'] ?? '',
      uid: json['uid'] ?? 0,
    );
  }
}
