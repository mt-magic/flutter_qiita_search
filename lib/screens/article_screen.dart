// 画面ライブラリのインポート
import 'package:flutter/material.dart';
/// 記事モデルのインポート
import 'package:flutter_qiita_search/models/article.dart';
// webview_flutterライブラリのインポート
 import 'package:webview_flutter/webview_flutter.dart';

/// 記事画面のステートフルエンドポイント。
class ArticleScreen extends StatefulWidget {
  // コンストラクタ。記事モデルも受け取る
  const ArticleScreen({
    super.key,
    required this.article,
  });

    // 記事モデル
  final Article article;

  // 実際はステートレスの記事画面を呼ぶだけ
  @override
  State<ArticleScreen> createState() => _ArticleScreenState();
}

/// 記事画面のステートレスエンドポイント。
class _ArticleScreenState extends State<ArticleScreen> {
  late WebViewController controller = WebViewController()
    ..loadRequest(
      Uri.parse(widget.article.url),
    );
  
  // Widget
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 画面にAppBarを作成
      appBar: AppBar(
        title: const Text('Article Page'),
      ),
      body: WebViewWidget(controller: controller),
    );
  }
}