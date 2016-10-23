## Group Event API

**Note**

* ステータス: { 0: `非公開` , 1: `公開/受付中` , 2: `満員` , 3: `受付終了` }

* Request

    + 全てのリクエスト ヘッダーにアクセストークンを付加する必要がある

    + Headers Attributes
        - Authorization (string, required) - アクセストークン

    + Headers

            Authorization: Bearer eyJhbGciOiJIUzI1NiIsI6IkpXVCJ9.eyJleHAi...

## Events Collection [/events]

### 新規イベント作成 [POST]

**Note**

* body: Markdown形式
* tag: 各タグidの配列
* event_image: json値ではなくイベント画像ファイル
* 必須項目(title)が未設定の場合 => 400

+ Request (application/json)

        {
            "title": "第1会もくもく会",
            "event_image": イベント画像(type=file),
            "tags": [
                "1",
                "2",
                "3"
            ],
            "body": "第1回もくもく会を開催いたします",
            "started_at": "2016/06/03 12:00",
            "ended_at": "2016/06/03 15:00",
            "venue": "研究棟B 401",
            "entry_upper_limit": 10
        }

+ Response 201 (application/json)

        {
            "event_id": 1,
            "title": "第1会もくもく会",
            "event_image": "sample1.jpg",
            "tags": [
                "もくもく会",
                "Ruby",
                "Scala"
            ],
            "body": "第1回もくもく会を開催いたします",
            "started_at": "2016/06/03 12:00",
            "ended_at": "2016/06/03 15:00",
            "venue": "研究棟B 401",
            "entry_upper_limit": 10
        }

+ Response 400

## Event [/events/{event_id}]

### イベント詳細取得 [GET]

**Note**

* body: Markdown形式
* 対象イベントが見つからない => 404

+ Parameters
    + event_id: 1 (number) - 取得対象イベントid

+ Response 200 (application/json)

    + Body Attributes
      + title: (string) - イベントタイトル
      + event_image: (string) - イベント画像フルパス
      + tags: (array) - タグ名
      + body: (string) - イベント内容(Markdown形式)
      + register: (object) - イベント登録者
          - name: (string) - ユーザ名
          - number: (string) - 学籍番号
          - user_image: (string) - プロフィール画像フルパス
          - college: (object) - 所属カレッジ
              * code: (string) - カレッジ一意のコード
              * name: (string) - カレッジ名
      + published_at: (datetime) - 公開日時
      + started_at: (datetime) - 開催日時
      + ended_at: (datetime) - 終了日時
      + venue: (string) - 会場
      + entry_upper_limit: (integer) - 上限人数
      + status: (integer) - イベントステータス
      + entries: (array) - 参加者一覧(イベント作成者と同じフィールド)
      + comments: (array) - コメント一覧
          - body: (string) - コメント内容(Markdown形式)
          - posted_at: (datetime) - 投稿日時
          - user: (object) - コメント投稿者(イベント作成者と同じフィールド)

    + Body

            {
                "title": "第1会もくもく会",
                "event_image": "http://example.com/image/sample1.jpg",
                "tags": [
                    "もくもく会",
                    "Ruby",
                    "Scala"
                ],
                "body": "第1回もくもく会を開催いたします",
                "register": {
                    "name": "sasaki",
                    "number": "G099C0001"
                    "user_image": "http://example.com/image/sasaki.jpg",
                    "college": {
                        "code": "c",
                        "name": "IT"
                    }
                },
                "published_at": "2016/06/01 09:00",
                "started_at": "2016/06/03 12:00",
                "ended_at": "2016/06/03 15:00",
                "venue": "研究棟B 401",
                "entry_upper_limit": 10,
                "status": 1,
                "entries": [
                    {
                        "name": "tanaka",
                        "number": "G099C0002"
                        "user_image": "http://example.com/image/tanaka.jpg",
                        "college": {
                            "code": "c",
                            "name": "IT"
                        }
                    },
                    {
                        "name": "satou",
                        "number": "G099G0003"
                        "user_image": "http://example.com/image/satou.jpg",
                        "college": {
                            "code": "g",
                            "name": "デザイン"
                        }
                    }
                ],
                "comments": [
                    {
                        "body": "こんにちは！",
                        "posted_at": "2016/06/01 12:02",
                        "user": {
                            "name": "tanaka",
                            "number": "G099G0002"
                            "user_image": "http://example.com/image/tanaka.jpg",
                            "college": {
                                "code": "g",
                                "name": "デザイン"
                        }
                    },
                    {
                        "body": "参加を考えてます!",
                        "posted_at": "2016/06/01 15:12",
                        "user": {
                            "name": "yamada",
                            "number": "G099C0004"
                            "user_image": "http://example.com/image/yamada.jpg",
                            "college": {
                                "code": "c",
                                "name": "IT"
                        }
                    }
                ]
            }

+ Response 404

### イベント更新 [PATCH]

**Note**

* body: Markdown形式
* イベントステータスに関わらず常に更新可能 => 200
* ステータスが `非公開` 以外の場合には参加者に更新通知を送ることができる(任意)
* 対象イベントが見つからない => 404

+ Parameters
    + event_id: 1 (number) - 更新対象イベントid

+ Request (application/json)

        {
            "title": "第2会もくもく会",
            "event_image": "sample2.jpg",
            "tags": [
                "1",
                "2",
                "3",
                "4"
            ],
            "body": "第2回もくもく会を開催いたします",
            "started_at": "2016/06/03 13:00",
            "ended_at": "2016/06/03 16:00",
            "venue": "研究棟B 402",
            "entry_upper_limit": 11,
            "notify": true
        }

+ Response 200 (application/json)

        {
            "event_id": 1,
            "title": "第2会もくもく会",
            "event_image": "sample2.jpg",
            "tags": [
                "もくもく会",
                "Ruby",
                "Scala",
                "Elixir"
            ],
            "body": "第2回もくもく会を開催いたします",
            "started_at": "2016/06/03 13:00",
            "ended_at": "2016/06/03 16:00",
            "venue": "研究棟B 402",
            "entry_upper_limit": 11
        }

+ Response 403
+ Response 404

### イベント削除 [DELETE]

**Note**

* イベント開催者のみ(それ以外 => 403)
* イベントステータスが `非公開` の場合にのみ削除可能 => 204
* イベントステータスが `非公開` 以外の場合 => 403
* 対象イベントが見つからない => 404

+ Parameters
    + event_id: 1 (number) - 削除対象イベントid

+ Response 204
+ Response 403
+ Response 404

## Event Public [/events/{event_id}/public]
### イベント公開 [PUT]

**Note**

* イベント開催者のみ(それ以外 => 403)
* イベントステータスが `非公開` の場合にのみ公開可能 => 204
* イベントステータスが `非公開` 以外の場合 => 403
* 対象イベントが見つからない => 404

+ Parameters
    + event_id: 1 (number) - 公開対象イベントid

+ Response 204
+ Response 403
+ Response 404

## Event Join [/events/{event_id}/entry]
### イベント参加 [PUT]

**Note**

* ステータス= `公開/受付中` && 参加予定人数が参加上限人数を超えた時にステータスを `満員` に変更する
* イベントステータスが `公開/受付中` の場合にのみ参加可能 => 204
* イベントステータスが `公開/受付中` 以外の場合 => 403
* イベント開催者は参加できない => 403
* 対象イベントが見つからない => 404

+ Parameters
    + event_id: 1 (number) - 参加イベントid

+ Response 204
+ Response 403
+ Response 404

### イベント参加キャンセル [DELETE]

**Note**

* ステータス= `満員` && 参加予定人数が参加上限人数を下回った時にステータスを `公開/受付中` に変更する
* イベントステータスが `公開/受付中` `満員` `受付終了` の場合にのみ参加可能 => 204
* イベントステータスが上記以外の場合 or 参加していない場合 => 403
* 対象イベントが見つからない => 404

+ Parameters
    + event_id: 1 (number) - 参加イベントid

+ Response 204
+ Response 403
+ Response 404

## Event Close [/events/{event_id}/close]
### イベント受付終了 [PUT]

**Note**

* イベント開催者のみ(それ以外 => 403)
* これからの参加を停止する(元に戻せないため注意)
* イベントステータスが `公開/受付中` `満員` の場合にのみステータス変更可能 => 204
* イベントステータスが上記以外の場合 => 403
* 対象イベントが見つからない => 404

+ Parameters
    + event_id: 1 (number) - 参加イベントid

+ Response 204
+ Response 403
+ Response 404

## Comment Post [/events/{event_id}/comment]
### コメント投稿 [POST]

**Note**

* comment: Markdown形式
* 開催者のみ, 参加者にコメント投稿通知を送ることができる(任意)
* 参加者のコメントは開催者に通知が送られる
* イベントステータスが `非公開` 以外の場合にのみ投稿可能 => 204
* イベントステータスが `非公開` の場合 => 403
* 対象イベントが見つからない => 404

+ Parameters
    + event_id: 1 (number) - コメント対象イベントid

+ Request (application/json)

        {
            "comment": "## こんにちは。",
            "notify": true
        }

+ Response 204
+ Response 404

## Event Entries [/events/entries{?page,per}]
### 参加予定イベント一覧取得 [GET]

**Note**

* 自分が参加しているイベント(開催日が決定している && 開催日が今日以降)

+ Parameters
    + page: 1 (integer, required) - ページ番号
    + per: 10 (integer, required) - 1ページあたりの件数

+ Response 200 (application/json)

    + Body Attributes
        + page: (integer) - ページ番号
        + per: (integer) - 1ページあたりの件数
        + total_count: (integer) - 全イベント数
        + events: (array) - イベント一覧
          - event_id: (integer) - イベントID
          - title: (string) - イベントタイトル
          - status: (integer) - ステータスID
          - event_image: (string) - イベント画像フルパス
          - tags: (array) - タグ名

    + Body

            {
                "page": 1,
                "per": 10,
                "total_count": 2,
                "events": [
                    {
                        "event_id": 1,
                        "title": "第1会もくもく会",
                        "event_image": "http://example.com/image/sample1.jpg",
                        "status": 1,
                        "tags": [
                            "もくもく会",
                            "Ruby",
                            "Scala"
                        ]
                    },
                    {
                        "event_id": 2,
                        "title": "Rails勉強会",
                        "event_image": "http://example.com/image/sample2.jpg",
                        "status": 2,
                        "tags": [
                            "Ruby",
                            "Ruby on Rails"
                        ]
                    }
                ]
            }

## Event Own [/events/own{?page,per}]
### 自分が開催しているイベント一覧取得 [GET]

**Note**

* 自分が開催しているイベント(過去・未来問わず)

+ Parameters
    + page: 1 (integer, required) - ページ番号
    + per: 10 (integer, required) - 1ページあたりの件数

+ Response 200 (application/json)

    + Body Attributes
        + page: (integer) - ページ番号
        + per: (integer) - 1ページあたりの件数
        + total_count: (integer) - 全イベント数
        + events: (array) - イベント一覧
          - event_id: (integer) - イベントID
          - title: (string) - イベントタイトル
          - status: (integer) - ステータスID
          - event_image: (string) - イベント画像フルパス
          - tags: (array) - タグ名

    + Body

            {
                "page": 1,
                "per": 10,
                "total_count": 2,
                "events": [
                    {
                        "event_id": 1,
                        "title": "第1会もくもく会",
                        "event_image": "http://example.com/image/sample1.jpg",
                        "status": 1,
                        "tags": [
                            "もくもく会",
                            "Ruby",
                            "Scala"
                        ]
                    },
                    {
                        "event_id": 2,
                        "title": "Rails勉強会",
                        "event_image": "http://example.com/image/sample2.jpg",
                        "status": 2,
                        "tags": [
                            "Ruby",
                            "Ruby on Rails"
                        ]
                    }
                ]
            }

## Event Search [/events/search{?keyword,started_on,ended_on,page,per}]
### イベント検索 [GET]

**Note**

* パラメータが不正 => 400

+ Parameters
    + keyword: 'もくもく' (string, required) - 検索キーワード
    + started_on: '2016/06/03' (date, optional) - 開始日
    + ended_on: '2016/06/03' (date, optional) - 終了日
    + page: 1 (integer, required) - ページ番号
    + per: 10 (integer, required) - 1ページあたりの件数

+ Response 200 (application/json)

    + Body Attributes
        + page: (integer) - ページ番号
        + per: (integer) - 1ページあたりの件数
        + total_count: (integer) - 全イベント数
        + events: (array) - イベント一覧
          - event_id: (integer) - イベントID
          - title: (string) - イベントタイトル
          - status: (integer) - ステータスID
          - event_image: (string) - イベント画像フルパス
          - tags: (array) - タグ名

    + Body

            {
                "page": 1,
                "per": 10,
                "total_count": 2,
                "events": [
                    {
                        "event_id": 1,
                        "title": "第1会もくもく会",
                        "event_image": "http://example.com/image/sample1.jpg",
                        "status": 1,
                        "tags": [
                            "もくもく会",
                            "Ruby",
                            "Scala"
                        ]
                    },
                    {
                        "event_id": 2,
                        "title": "Rails勉強会",
                        "event_image": "http://example.com/image/sample2.jpg",
                        "status": 2,
                        "tags": [
                            "Ruby",
                            "Ruby on Rails"
                        ]
                    }
                ]
            }

+ Response 400
