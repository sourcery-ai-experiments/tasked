class Category {
  int pageid;
  String lang;
  String title;
  int pages;
  int files;
  int subcats;

  Category({
    this.pageid = 0,
    this.lang = 'en',
    this.title = '',
    this.pages = 0,
    this.files = 0,
    this.subcats = 0});

  Category.fromJson(Map<String, dynamic> json) {
    pageid = json['pageid'] ?? 0;
    lang = json['lang'] ?? 'en';
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lang'] = this.lang;
    data['title'] = this.title;
    return data;
  }
}
