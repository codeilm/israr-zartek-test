class RestaurantModel {
  RestaurantModel({
    this.restaurantId,
    this.restaurantName,
    this.restaurantImage,
    this.tableId,
    this.tableName,
    this.branchName,
    this.nexturl,
    this.tableMenuList,
  });

  String restaurantId;
  String restaurantName;
  String restaurantImage;
  String tableId;
  String tableName;
  String branchName;
  String nexturl;
  List<TableMenuList> tableMenuList;

  factory RestaurantModel.fromJson(Map<String, dynamic> json) =>
      RestaurantModel(
        restaurantId: json["restaurant_id"],
        restaurantName: json["restaurant_name"],
        restaurantImage: json["restaurant_image"],
        tableId: json["table_id"],
        tableName: json["table_name"],
        branchName: json["branch_name"],
        nexturl: json["nexturl"],
        tableMenuList: List<TableMenuList>.from(
            json["table_menu_list"].map((x) => TableMenuList.fromJson(x))),
      );
}

class TableMenuList {
  TableMenuList({
    this.menuCategory,
    this.menuCategoryId,
    this.menuCategoryImage,
    this.nexturl,
    this.categoryDishes,
  });

  String menuCategory;
  String menuCategoryId;
  String menuCategoryImage;
  String nexturl;
  List<CategoryDish> categoryDishes;

  factory TableMenuList.fromJson(Map<String, dynamic> json) => TableMenuList(
        menuCategory: json["menu_category"],
        menuCategoryId: json["menu_category_id"],
        menuCategoryImage: json["menu_category_image"],
        nexturl: json["nexturl"],
        categoryDishes: List<CategoryDish>.from(
            json["category_dishes"].map((x) => CategoryDish.fromJson(x))),
      );
}

class AddonCat {
  AddonCat({
    this.addonCategory,
    this.addonCategoryId,
    this.addonSelection,
    this.nexturl,
    this.addons,
  });

  String addonCategory;
  String addonCategoryId;
  int addonSelection;
  String nexturl;
  List<CategoryDish> addons;

  factory AddonCat.fromJson(Map<String, dynamic> json) => AddonCat(
        addonCategory: json["addon_category"],
        addonCategoryId: json["addon_category_id"],
        addonSelection: json["addon_selection"],
        nexturl: json["nexturl"],
        addons: List<CategoryDish>.from(
            json["addons"].map((x) => CategoryDish.fromJson(x))),
      );
}

class CategoryDish {
  CategoryDish({
    this.dishId,
    this.dishName,
    this.dishPrice,
    this.dishImage,
    this.dishCurrency,
    this.dishCalories,
    this.dishDescription,
    this.dishAvailability,
    this.dishType,
    this.nexturl,
    this.addonCat,
  });

  String dishId;
  String dishName;
  double dishPrice;
  String dishImage;
  DishCurrency dishCurrency;
  double dishCalories;
  String dishDescription;
  bool dishAvailability;
  int dishType;
  String nexturl;
  List<AddonCat> addonCat;
  int orderQuantity = 0;

  factory CategoryDish.fromJson(Map<String, dynamic> json) => CategoryDish(
        dishId: json["dish_id"],
        dishName: json["dish_name"],
        dishPrice: json["dish_price"].toDouble(),
        dishImage: json["dish_image"],
        dishCurrency: dishCurrencyValues.map[json["dish_currency"]],
        dishCalories: json["dish_calories"],
        dishDescription: json["dish_description"],
        dishAvailability: json["dish_Availability"],
        dishType: json["dish_Type"],
        nexturl: json["nexturl"] == null ? null : json["nexturl"],
        addonCat: json["addonCat"] == null
            ? null
            : List<AddonCat>.from(
                json["addonCat"].map((x) => AddonCat.fromJson(x))),
      );

  void increaseOrderQuantity() {
    orderQuantity++;
  }

  void decreaseOrderQuantity() {
    if (orderQuantity > 0) orderQuantity--;
  }
}

enum DishCurrency { SAR }

final dishCurrencyValues = EnumValues({"SAR": DishCurrency.SAR});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
