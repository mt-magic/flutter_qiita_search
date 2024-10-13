// 画面ライブラリのインポート
import 'package:flutter/material.dart';
// json変換で使用
import 'dart:convert';
// http通信で使用。httpという変数を通して、httpパッケージにアクセス
import 'package:http/http.dart' as http;
// 秘匿化したアクセストークンの取得に使用
import 'package:flutter_dotenv/flutter_dotenv.dart';
// 記事モデルのインポート
import 'package:flutter_qiita_search/models/article.dart';
// 記事コンテナのインポート
import 'package:flutter_qiita_search/widgets/article_container.dart';

/// 検索画面のステートフルエンドポイント。
class SearchScreen extends StatefulWidget {
  // コンストラクタ。キーを振るだけ
  const SearchScreen({super.key});

  // 実際はステートレスの検索画面を呼ぶだけ
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

/// 検索画面のステートレスエンドポイント。
class _SearchScreenState extends State<SearchScreen> {
  // 検索結果を格納する変数
  List<Article> articles = []; 
  // Widget
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 画面にAppBarを作成
      appBar: AppBar(
        title: const Text('Qiita Search Test'),
      ),
      body: Column(
        children: [
          // 検索ボックス
          Padding( // ← Paddingで囲む
            padding: const EdgeInsets.symmetric(
              vertical: 12,
              horizontal: 36,
            ),
            child: TextField(
              style: TextStyle( // ← TextStyleを渡す
              fontSize: 18,
                color: Colors.black,
              ),
              decoration: InputDecoration( // ← InputDecorationを渡す。Inputの装飾
                hintText: '検索ワードを入力してください',
              ),
              onSubmitted: (String value) async {
                final results = await searchQiita(value); // ← 検索処理を実行する
                setState(()=>articles = results); // 検索結果を代入
              },
            ),
          ),
          // 検索結果一覧
          Expanded(
            child: ListView(
              children: articles
                  .map((article) => ArticleContainer(article: article))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }

  Future<List<Article>> searchQiita(String keyword) async {
    // 1. http通信に必要なデータを準備をする
    //   - URL、クエリパラメータの設定
    final uri = Uri.https('qiita.com', '/api/v2/items', {
      'query': 'title:$keyword',
      'per_page': '10',
    });
    //   - アクセストークンの取得
    final String token = dotenv.env['QIITA_ACCESS_TOKEN'] ?? '';

    // 2. Qiita APIにリクエストを送る
    final http.Response res = await http.get(uri, headers: {
      'Authorization': 'Bearer $token',
    });

    // 3. 戻り値をArticleクラスの配列に変換
    // 4. 変換したArticleクラスの配列を返す(returnする)
    if (res.statusCode == 200) {
      // レスポンスをモデルクラスへ変換
      final List<dynamic> body = jsonDecode(res.body);
      return body.map((dynamic json) => Article.fromJson(json)).toList();
    } else {
      return [];
    }
  }
}

