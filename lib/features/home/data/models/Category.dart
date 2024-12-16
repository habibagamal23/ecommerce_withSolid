class Category {
  final String name;

  Category(this.name);



  /// Converts a JSON list of category names into a list of Category objects
  static List<Category> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((name) => Category(name)).toList();
  }


  @override
  String toString() => name;
}
