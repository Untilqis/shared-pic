# ベースイメージを指定
FROM ruby:2.6.5

# Exiftoolをインストール
RUN apt-get update && apt-get install -y libimage-exiftool-perl

# アプリケーションのディレクトリを作成
WORKDIR /app

# アプリケーションのコードをコピー
COPY . /app

# 依存関係をインストール
RUN bundle install

# アプリケーションを実行
CMD ["rails", "server", "-b", "0.0.0.0"]