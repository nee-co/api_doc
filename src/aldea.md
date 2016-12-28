## Group Event API

**ステータスコード表**
| 操作(イベント公開状況)  | 開催者  | 参加者  | その他  |
|:------------------------|:-------:|:-------:|:-------:|
| 詳細取得(public)        | **200** | **200** | **200** |
| 詳細取得(private)       | **200** | **200** |   404   |
| 更新(public)            | **200** |   403   |   403   |
| 更新(private)           | **200** |   403   |   404   |
| 削除(public)            | **204** |   403   |   403   |
| 削除(private)           | **204** |   403   |   404   |
| 公開(public)            |   403   |   403   |   403   |
| 公開(private)           | **204** |   403   |   404   |
| 参加(public)            |   403   |   403   | **204** |
| 参加(private)           |   403   |   403   |   404   |
| 参加キャンセル(public)  |   403   | **204** |   404   |
| 参加キャンセル(private) |   403   | **204** |   404   |
| 非公開(public)          | **204** |   403   |   403   |
| 非公開(private)         |   403   |   403   |   404   |
| コメント(public)        | **201** | **201** | **201** |
| コメント(private)       | **201** | **201** |   404   |

* Request

    * 全てのリクエスト ヘッダーにアクセストークンを付加する必要がある

    * Headers Attributes
        - Authorization (string, required) - アクセストークン

    * Headers

            Authorization: Bearer eyJhbGciOiJIUzI1NiIsI6IkpXVCJ9.eyJleHAi...

## Events Collection [/events]

### 新規イベント作成 [POST]

**Note**
* 作成直後 is_public == false
* image未設定時はデフォルト画像が登録される
* 必須項目(title, body, start_date)が未設定の場合 => 422
* 開催日 < 今日 => 422

* Request (multipart/form-data)

        {
            "title": "第1会もくもく会",
            "image": イベント画像(type=file),
            "body": "第1回もくもく会を開催いたします",
            "start_date": "2017/01/01"
        }

* Response 201 (application/json)

        {
            "id": 1,
            "title": "第1会もくもく会",
            "image": "sample1.jpg",
            "body": "第1回もくもく会を開催いたします",
            "start_date": "2017-01-01",
            "is_public": "false"
        }

* Response 422

## Event [/events/{event_id}]

### イベント詳細取得 [GET]

* Parameters
    * event_id: 1 (number) - イベントID

* Response 200 (application/json)

    * Body Attributes
      * id: (number) - イベントID
      * title: (string) - イベントタイトル
      * image: (string) - イベント画像URL
      * body: (string) - イベント内容(Markdown形式)
      * start_date: (date) - 開催日
      * is_public: (boolean) - 公開フラグ
      * owner: (user) - イベント管理者
      * entries: (array[user]) - 参加者一覧
      * comments: (array) - コメント一覧
          - body: (string) - コメント内容(Markdown形式)
          - posted_at: (datetime) - 投稿日時
          - user: (user) - コメント投稿者

    * Body

            {
                "id": 1,
                "title": "第1会もくもく会",
                "image": "http://example.com/image/sample1.jpg",
                "body": "第1回もくもく会を開催いたします",
                "start_date": "2017-01-01",
                "is_public": "true",
                "owner": {
                    "id": 1,
                    "name": "sasaki",
                    "number": "G099C0001",
                    "image": "http://example.com/image/sasaki.jpg",
                    "college": {
                        "code": "c",
                        "name": "IT"
                    }
                },
                "entries": [
                    {
                        "id": 2,
                        "name": "tanaka",
                        "number": "G099C0002",
                        "image": "http://example.com/image/tanaka.jpg",
                        "college": {
                            "code": "c",
                            "name": "IT"
                        }
                    },
                    {
                        "id": 3,
                        "name": "satou",
                        "number": "G099G0003",
                        "image": "http://example.com/image/satou.jpg",
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
                            "id": 2,
                            "name": "tanaka",
                            "number": "G099G0002",
                            "image": "http://example.com/image/tanaka.jpg",
                            "college": {
                                "code": "g",
                                "name": "デザイン"
                            }
                        }
                    },
                    {
                        "body": "参加を考えてます!",
                        "posted_at": "2016/06/01 15:12",
                        "user": {
                            "id": 4,
                            "name": "yamada",
                            "number": "G099C0004",
                            "image": "http://example.com/image/yamada.jpg",
                            "college": {
                                "code": "c",
                                "name": "IT"
                            }
                        }
                    }
                ]
            }

* Response 404

### イベント更新 [PATCH]

**Note**
* 開催日 < 今日 => 422

* Parameters
    * event_id: 1 (number) - イベントid

* Request (multipart/form-data)

        {
            "title": "第2会もくもく会",
            "image": "sample2.jpg",
            "body": "第2回もくもく会を開催いたします",
            "start_date": "2016-06-03"
        }

* Response 200 (application/json)

        {
            "id": 1,
            "title": "第2会もくもく会",
            "image": "sample2.jpg",
            "body": "第2回もくもく会を開催いたします",
            "start_date": "2016/06/03",
            "is_public": true
        }

* Response 403
* Response 404
* Response 422

### イベント削除 [DELETE]

**Note**
* 参加者がいる => 403

* Parameters
    * event_id: 1 (number) - イベントid

* Response 204
* Response 403
* Response 404

## Event Public [/events/{event_id}/public]
### イベント公開 [PUT]

* Parameters
    * event_id: 1 (number) - イベントid

* Response 204
* Response 403
* Response 404

## Event Private [/events/{event_id}/private]
### イベント非公開 [PUT]

* Parameters
    * event_id: 1 (number) - イベントid

* Response 204
* Response 403
* Response 404

## Event Join [/events/{event_id}/entry]
### イベント参加 [PUT]

* Parameters
    * event_id: 1 (number) - イベントid

* Response 204
* Response 403
* Response 404

### イベント参加キャンセル [DELETE]

* Parameters
    * event_id: 1 (number) - イベントid

* Response 204
* Response 403
* Response 404

## Comments Collection [/events/{event_id}/comments]
### コメント投稿 [POST]

* Parameters
    * event_id: 1 (number) - コメント対象イベントid

* Request (application/x-www-form-urlencoded)

        {
            "body": "## こんにちは。"
        }

* Response 201 (application/json)

    * Body Attributes
      * body: (string) - コメント内容(Markdown形式)
      * posted_at: (datetime) - 投稿日時
      * user: (user) - コメント投稿者

    * Body

            {
                "body": "こんにちは！",
                "posted_at": "2016/06/01 12:02",
                "user": {
                    "id": 2,
                    "name": "tanaka",
                    "number": "G099G0002"
                    "image": "http://example.com/image/tanaka.jpg",
                    "college": {
                        "code": "g",
                        "name": "デザイン"
                    }
                }
            }

* Response 404

## Event Search [/events/search{?keyword,page,per}]
### イベント検索 [GET]

**Note**
* NOT(開催/参加するイベント) && 開催日 >= 今日 && is_public == true
* 開催日昇順

* Parameters
    * keyword: もくもく (string, required) - 検索キーワード
    * page: 1 (number, required) - ページ番号
    * per: 10 (number, required) - 1ページあたりの件数

* Response 200 (application/json)

    * Body Attributes
        * page: (number) - ページ番号
        * per: (number) - 1ページあたりの件数
        * total_count: (number) - 全イベント数
        * events: (array) - イベント一覧
          - id: (number) - イベントID
          - title: (string) - イベントタイトル
          - image: (string) - イベント画像URL
          - start_date: (date) - 開催日

    * Body

            {
                "page": 1,
                "per": 10,
                "total_count": 2,
                "events": [
                    {
                        "id": 1,
                        "title": "第1会もくもく会",
                        "image": "http://example.com/image/sample1.jpg",
                        "start_date": "2016-06-03"
                    },
                    {
                        "id": 2,
                        "title": "Rails勉強会",
                        "image": "http://example.com/image/sample2.jpg",
                        "start_date": "2016-06-03"
                    }
                ]
            }

* Response 400

## Event Entries [/events/entries{?limit,offset}]
### 参加予定イベント一覧取得 [GET]

**Note**
* トレイ対応API
* 自分が参加している && 開催日 >= 今日

* Parameters
    + limit: 1 (number, required) - 取得数
    + offset: 0 (number, required) - 取得開始位置 (0 origin)

* Response 200 (application/json)

    * Body Attributes
        * elements: (array[event]) - イベント一覧
          + id: (number) - イベントID
          + type (string) - `event` 固定(遷移先の決定に利用)
          + title: (string) - イベントタイトル
          + image: (string) - イベント画像URL
          + meta: (object) - メタ情報
            - type: (string) - `date` 固定
            - body: (string) - 開催日 (ISO 8601)

    * Body

            {
                "elements": [
                    {
                        "id": 1,
                        "type": "event",
                        "title": "第1会もくもく会",
                        "image": "http://example.com/image/sample1.jpg",
                        "meta": {
                          "type": "date",
                          "body": "2017-01-10T16:00:00.000Z"
                        }
                    },
                    {
                        "id": 2,
                        "type": "event",
                        "title": "Rails勉強会",
                        "image": "http://example.com/image/sample2.jpg",
                        "meta": {
                          "type": "date",
                          "body": "2017-01-10T16:00:00.000Z"
                        }
                    }
                ]
            }

## Event Own [/events/own{?limit,offset}]
### 開催予定イベント一覧取得 [GET]

**Note**
* トレイ対応API
* 自分が開催している && 開催日 >= 今日

* Parameters
    + limit: 1 (number, required) - 取得数
    + offset: 0 (number, required) - 取得開始位置 (0 origin)

* Response 200 (application/json)

    * Body Attributes
        * elements: (array[event]) - イベント一覧
          + id: (number) - イベントID
          + type (string) - `event` 固定(遷移先の決定に利用)
          + title: (string) - イベントタイトル
          + image: (string) - イベント画像URL
          + meta: (object) - メタ情報
            - type: (string) - `date` 固定
            - body: (string) - 開催日 (ISO 8601)

    * Body

            {
                "elements": [
                    {
                        "id": 1,
                        "type": "event",
                        "title": "第1会もくもく会",
                        "image": "http://example.com/image/sample1.jpg",
                        "meta": {
                          "type": "date",
                          "body": "2017-01-10T16:00:00.000Z"
                        }
                    },
                    {
                        "id": 2,
                        "type": "event",
                        "title": "Rails勉強会",
                        "image": "http://example.com/image/sample2.jpg",
                        "meta": {
                          "type": "date",
                          "body": "2017-01-10T16:00:00.000Z"
                        }
                    }
                ]
            }
