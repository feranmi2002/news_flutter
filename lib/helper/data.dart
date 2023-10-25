import '../models/category_model.dart';

List<CategoryModel> getCategories() {
  List<CategoryModel> categoryModels = [];
  var categories = [
    "Business",
    "Entertainment",
    "General",
    "Health",
    "Science",
    "Sports",
    "Technology"
  ];

  var imageUrls = [
    "https://media.istockphoto.com/id/1455959081/photo/two-confident-business-man-shaking-hands-during-a-meeting-in-the-office-success-dealing.webp?b=1&s=170667a&w=0&k=20&c=nxL8v-uakfwIXSK25_DzUiS7dT7_DTngWkYuxDdHGFA=",
    "https://images.unsplash.com/photo-1603190287605-e6ade32fa852?auto=format&fit=crop&q=80&w=870&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    "https://media.istockphoto.com/id/1460916806/photo/city-skyscraper-abstract.jpg?s=612x612&w=is&k=20&c=5lnIuxauNeTlhpaAOIUfYBMgcvc3Q1b6-65gW7MXOr4=",
    "https://images.unsplash.com/photo-1505576399279-565b52d4ac71?auto=format&fit=crop&q=60&w=800&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Nnx8aGVhbHRofGVufDB8fDB8fHww",
    "https://plus.unsplash.com/premium_photo-1676325102105-2986f7f57649?auto=format&fit=crop&q=60&w=800&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8c2NpZW5jZXxlbnwwfHwwfHx8MA%3D%3D",
    "https://plus.unsplash.com/premium_photo-1676634832558-6654a134e920?auto=format&fit=crop&q=60&w=800&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8c3BvcnRzfGVufDB8fDB8fHww",
    "https://images.unsplash.com/photo-1518770660439-4636190af475?auto=format&fit=crop&q=60&w=800&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NHx8dGVjaG5vbG9neXxlbnwwfHwwfHx8MA%3D%3D"
  ];

  var index = 0;
  for (var category in categories) {
    categoryModels
        .add(CategoryModel(categoryName: category, imageUrl: imageUrls[index]));
    index++;
  }
  return categoryModels;
}
