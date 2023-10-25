import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_flutter/helper/data.dart';
import 'package:news_flutter/helper/news.dart';
import 'package:news_flutter/models/load_state.dart';
import 'package:news_flutter/views/article_view.dart';
import 'package:news_flutter/views/error_view.dart';

import '../models/article_model.dart';
import '../models/category_model.dart';
import '../views/category_view.dart';
import 'blog_view.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<CategoryModel> categories = [];
  Result result = Result(LoadStates.loading, []);


  getNews() async {
    result.loadState = LoadStates.loading;
    News news = News();
    await news.getNews("");
    setState(() {
      result = news.result;
    });
  }

  @override
  void initState() {
    super.initState();
    categories = getCategories();
    getNews();
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
          centerTitle: true,
          elevation: 0.0,
        ),
        body: conditionalWidget(() => getNews(), result.loadState, categories,
            result.data)
    );
  }

}

Widget conditionalWidget(Function()? onErrorTapped, LoadStates loadStates,
    List<CategoryModel> categories, List<ArticleModel> articles) {
  switch (loadStates) {
    case LoadStates.loading:
      return Center(
        child: Container(
          child: CircularProgressIndicator(),
        ),
      );

    case LoadStates.success:
      return SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: <Widget>[
// categories
            Container(
              height: 70,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    return CategoryTitle(
                      imageUrl: categories[index].imageUrl,
                      categoryName: categories[index].categoryName,
                    );
                  }),
            ),

//   blogs
            Container(
              padding: EdgeInsets.only(top: 16),
              child: ListView.builder(
                  physics: ClampingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: articles.length,
                  itemBuilder: (context, index) {
                    return BlogTitle(
                      imageUrl: articles[index].urlToImage ?? "",
                      title: articles[index].title ?? "",
                      desc: articles[index].description ?? "",
                      url: articles[index].url ?? "",);
                  }),
            )
          ],
        ),
      );
    case LoadStates.error:
      return ErrorView(onErrorTapped: onErrorTapped);
  }
}

class CategoryTitle extends StatelessWidget {
  final String imageUrl, categoryName;

  CategoryTitle({required this.imageUrl, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) =>
              CategoryView(
                  category: categoryName.toLowerCase()
              )));
        },
        child: Container(
            margin: EdgeInsets.only(right: 16),
            child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
              ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: CachedNetworkImage(
                      imageUrl: imageUrl,
                      width: 120,
                      height: 60,
                      fit: BoxFit.cover)),
              Container(
                alignment: Alignment.center,
                child: Text(
                  categoryName,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      backgroundColor: Colors.black54),
                ),
              )
            ])));
  }
}

