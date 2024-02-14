import '../../../../entity/category.dart';
import '../../api_client/category_api.dart';

class CategoriesBlocModel {
  final _categoryApiClient = CategoryApiClient();
  List<Category> categories = [];
  List<Category> allCategories = [];

  getCategories() async {
    categories = await _categoryApiClient.getLimitCategories();
  }

  getAllCategories() async {
      allCategories = await _categoryApiClient.getAllCategories();
  }

  returnCategoryByName(categories, categoryName) {
    return categories.where((category) => category.title == categoryName).toList();
  }
}
