---
name: common templace
about: issueを記入してください
labels: develop
---

## 🎉 概要
ユーザーに紐づく企業情報を追加できるようにCompanyモデルを追加してください。


## 💪 なぜ必要なのか？
ユーザーに紐づく企業情報を取り扱うため

## 📖 参考資料 (optional)

(参考リンクなどあれば、なければ消す)

## 📎 TODO

- [ ] `Company`モデルの作成

## DB設計
timestampは自動で入るので記載していません。

カラム名   |  型
----- | -----
id  | pk
name   |  string NOT NULL
user_id | FK NOT NULL
