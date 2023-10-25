import 'package:flutter/material.dart';

import '../helper/news.dart';
import '../models/article_model.dart';
import '../models/load_state.dart';
import 'blog_view.dart';
import 'error_view.dart';

class CategoryView extends StatefulWidget {
  final String category;

  CategoryView({required this.category});

  @override
  State<CategoryView> createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {
  Result result = Result(LoadStates.loading, []);
  late String category;

  @override
  void initState() {
    super.initState();
    getCategoryNews();
  }

  getCategoryNews() async {
    result.loadState = LoadStates.loading;
    category = widget.category;
    News news = News();
    await news.getNews("category");
    setState(() {
      result = news.result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("Flutter"),
                Text("News", style: TextStyle(color: Colors.blue))
              ]),
          actions: <Widget>[
            Opacity(
              opacity: 0,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Icon(Icons.save),
              ),
            )
          ],
          centerTitle: true,
          elevation: 0.0,
        ),
        body: conditionalWidget(
            () => getCategoryNews(), result.loadState, category, result.data));
  }
}

Widget conditionalWidget(Function()? onErrorTapped, LoadStates loadStates,
    String category, List<ArticleModel> articles) {
  switch (loadStates) {
    case LoadStates.loading:
      return Center(
        child: Container(
          child: CircularProgressIndicator(),
        ),
      );

    case LoadStates.success:
      return SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Text(category.toUpperCase())],
            ),
            SizedBox(width: 0, height: 8),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: ListView.builder(
                  physics: ClampingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: articles.length,
                  itemBuilder: (context, index) {
                    return BlogTitle(
                        imageUrl: articles[index].urlToImage ?? "",
                        title: articles[index].title ?? "",
                        desc: articles[index].description ?? "",
                        url: articles[index].url ?? "");
                  }),
            )
          ],
        ),
      );
    case LoadStates.error:
      return ErrorView(onErrorTapped: onErrorTapped);
  }
}
