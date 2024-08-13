import 'dart:convert';

CategoryModels categoryModelFromJson(String str) =>
    CategoryModels.fromJson(jsonDecode(str));
String categoryModelToJson(CategoryModels data) => jsonEncode(data.toJson());

class CategoryModels {
  List<Categories>? categories;

  CategoryModels({this.categories});

  CategoryModels.fromJson(Map<String, dynamic> json) {
    if (json['categories'] != null) {
      categories = <Categories>[];
      json['categories'].forEach((v) {
        categories!.add(Categories.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.categories != null) {
      data['categories'] = this.categories!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Categories {
  String? name;
  List<String>? subcategory;

  Categories({this.name, this.subcategory});

  Categories.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    subcategory = json['subcategory'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = this.name;
    data['subcategory'] = this.subcategory;
    return data;
  }
}
