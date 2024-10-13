// 画面ライブラリのインポート
import 'package:flutter/material.dart';
// 検索画面のインポート
import 'package:flutter_qiita_search/screens/search_screen.dart';
// Envファイルの読み込みライブラリのインポート
import 'package:flutter_dotenv/flutter_dotenv.dart';

///　メイン処理
// void main() {
Future<void> main() async { // 非同期処理となる為、main関数をFutureに変更
  await dotenv.load(fileName: '.env'); // .envファイルを読み込み
  runApp(const MainApp());
}

// メイン処理のステートレスエンドポイント。
class MainApp extends StatelessWidget {
  // コンストラクタ。キーを振るだけ
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Qiita Search Test', // titleを追加
      theme: ThemeData( // themeを追加
        primarySwatch: Colors.green, 
        fontFamily: 'Hirogino Sans',
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF55C500),
        ),
        textTheme: Theme.of(context).textTheme.apply(
          bodyColor: Colors.white,
        ),
      ),
      home: const SearchScreen(),
    );
  }
}
