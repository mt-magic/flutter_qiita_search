// 画面ライブラリのインポート
import 'package:flutter/material.dart';

/// 記事モデルのインポート
import 'package:flutter_qiita_search/models/article.dart';
// 日付フォーマットライブラリのインポート
import 'package:intl/intl.dart';
// 記事画面のインポート
import 'package:flutter_qiita_search/screens/article_screen.dart';

/// 記事を表示するコンテナのステートレスエンドポイント。
// UI パーツは、名前をxxxContainerにして、widgetsディレクトリに配置。
class ArticleContainer extends StatelessWidget {
  // コンストラクタ。記事モデルも受け取る
  const ArticleContainer({
    super.key,
    required this.article, // 記事モデル
  });

  // 記事モデル
  final Article article;

  // Widget
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 16,
        ),
        child: GestureDetector(
          // GestureDetectorでContainerを囲う
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: ((context) => ArticleScreen(article: article)),
              ),
            );
          },
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: ((context) => ArticleScreen(article: article)),
                ),
              );
            },
            child: Container(
                height: 180, // 高さを指定
                padding: const EdgeInsets.symmetric(
                  // 内側の余白を指定
                  horizontal: 20,
                  vertical: 16,
                ),
                decoration: const BoxDecoration(
                  // Boxの装飾
                  color: Color(0xFF55C500), // ← 背景色を指定
                  borderRadius: BorderRadius.all(
                    Radius.circular(32), // ← 角丸を設定
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 投稿日
                    Text(
                      DateFormat('yyyy/MM/dd').format(article.createdAt),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                    // タイトル
                    Text(
                      article.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    // タグ
                    Text(
                      '#${article.tags.join(' #')}',
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    // 記事の下の部分
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        // ハートアイコンといいね数
                        Column(
                          children: [
                            const Icon(
                              Icons.favorite,
                              color: Colors.white,
                            ),
                            Text(
                              article.likesCount.toString(),
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        // 投稿者のアイコンと投稿者名
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            CircleAvatar(
                              radius: 26,
                              backgroundImage:
                                  NetworkImage(article.user.profileImageUrl),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              article.user.id,
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                )),
          ),
        ));
  }
}
