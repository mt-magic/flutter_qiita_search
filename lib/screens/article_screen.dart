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

  // ステートクラスを生成
  @override
  State<ArticleScreen> createState() => _ArticleScreenState();
}

/// 記事画面のステートクラス。
class _ArticleScreenState extends State<ArticleScreen> {
  late WebViewController controller = WebViewController()
    // カスケードオペレータ(..)を使って、コンストラクタの後にloadRequestを実行
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
