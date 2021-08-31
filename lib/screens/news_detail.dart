import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:url_launcher/url_launcher.dart' as url;

class NewsDetail extends StatelessWidget {
  static const routeName = '/news-detail-screen';

  _launchUrl(String urlString) async {
    if (await url.canLaunch(urlString)) {
      await url.launch(urlString);
    } else {
      throw 'Counld not launch URL $urlString';
    }
  }
  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args = ModalRoute.of(context).settings.arguments;
    final news = args['news'];
    final publishedAt = DateTime.parse(news.publishedAt);
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding:
              const EdgeInsets.only(left: 15, right: 10, top: 20, bottom: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(left: 10, bottom: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                        icon: Icon(Icons.arrow_back_ios),
                        onPressed: () => Navigator.of(context).pop()),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      news.author == null ? 'Anonymous' : news.author,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
              if (news.publishedAt != null)
                Container(
                  margin: const EdgeInsets.only(left: 15, right: 15),
                  child: Text(
                    "Published - ${publishedAt.day}-${publishedAt.month}-${publishedAt.year}",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
                  ),
                ),
              SizedBox(height: 15),
              if(news.description != null)
              Container(
                margin: const EdgeInsets.only(left: 15, right: 15),
                child: Text(
                  news.description,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 25),
              Hero(
                tag: news.title,
                child: Container(
                  margin: const EdgeInsets.only(left: 12, right: 15),
                  width: double.infinity,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: CachedNetworkImage(
                          imageUrl: news.imageUrl,
                          fit: BoxFit.fitWidth,
                          placeholder: (context, url) => Image.asset("images/placeholder.png"),
                          errorWidget: (context, url, error) => new Icon(Icons.error),
                        ),
                      
                    ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.25),
                        spreadRadius: 3,
                        blurRadius: 3,
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              if (news.content != null)
              Container(
                margin: const EdgeInsets.only(left: 12, right: 15),
                child: Text(
                  news.content,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              SizedBox(height: 50),
              Center(
                child: OutlinedButton(
                  onPressed: news.more != null ? ()=> _launchUrl(news.more) : null,
                  style: OutlinedButton.styleFrom(
                      shape: StadiumBorder(),
                      side: BorderSide(width: 2, color: Colors.black),
                      ),
                  child: Text(
                    'Full Coverage',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black54,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      )),
    );
  }
}
