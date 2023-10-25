import 'article_model.dart';

enum LoadStates {
  loading,
  success,
  error
}

class Result {
  LoadStates loadState = LoadStates.loading;
  List<ArticleModel> data = [];

  Result(this.loadState,
      this.data);
}