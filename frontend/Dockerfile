FROM node:18

WORKDIR /app

# package.json, yarn.lockを先にコピーして依存をインストール
COPY package.json /app/
COPY yarn.lock /app/
RUN yarn install

# ソースコードをコピー
COPY . /app

# 開発用のNext.jsサーバ起動
CMD ["yarn", "dev"]