## Group Event API

## Events Collection [/events]
### イベント全件取得 [GET]
+ Response 200 (application/json)

        {
            "page": 1,
            "per": 10,
            "total_count": 2,
            "events": [
                {
                    "event_id": 1,
                    "title": "第1会もくもく会",
                    "event_image": "http://example.com/image/sample1.jpg",
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
                    "tags": [
                        "Ruby",
                        "Ruby on Rails"
                    ]
                }
            ]
        }

+ Response 404 (application/json)

### 新規イベント作成 [POST]
+ Request (application/json)

        {
            "title": "第1会もくもく会", - 必須項目
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
            "entry_upper_limit": 10,
        }

+ Response 201 (application/json)

        {
            "message": "新規イベント作成が正常に行われました"
        }

+ Response 400 (application/json)

        {
            "message": "新規イベント作成が正常に行われませんでした"
        }


## Event [/events/{event_id}]
### イベント情報取得 [GET]
+ Parameters
    + event_id: 1 (number) - 取得対象イベントid

+ Response 200 (application/json)

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

+ Response 404 (application/json)

### イベント更新 [PATCH]
+ Parameters
    + event_id: 1 (number) - 更新対象イベントid

+ Request (application/json)

        {
            "title": "第2会もくもく会",
            "event_image": "sample2.jpg",
            "tags": {
                "もくもく会",
                "Ruby",
                "Scala",
                "Elixir"
            },
            "body": "第2回もくもく会を開催いたします",
            "started_at": "2016/06/03 13:00",
            "ended_at": "2016/06/03 16:00",
            "venue": "研究棟B 402",
            "entry_upper_limit": 11,
        }
 
+ Response 200 (application/json)

        {
            "message": "更新が正常に行われました。"
        }

### イベント削除 [DELETE]
+ Parameters
    + event_id: 1 (number) - 削除対象イベントid

+ Response 200 (application/json)

        {
            "message": "削除が正常に行われました。"
        }

## Event Join [/events/{event_id}/join]
### イベント参加 [PUT]
+ Parameters
    + event_id: 1 (number) - 参加イベントid

+ Response 200 (application/json)

        {
            "message": "イベントに参加しました。"
        }

+ Response 400 (application/json)

        {
            "message": "イベントに参加済です。"
        }

## Event Public [/events/{event_id}/public]
### イベント公開 [PUT]
+ Parameters
    + event_id: 1 (number) - 公開対象イベントid

+ Response 200 (application/json)

        {
            "message": "イベントが公開されました。"
        }

## Comment Post [/events/{event_id}/comment]
### コメント投稿 [POST]
+ Parameters
    + event_id: 1 (number) - コメント対象イベントid
+ Request (application/json)

        {
            "comment": "こんにちは。"
        }

+ Response 200 (application/json)

        {
            "message": "コメントが投稿されました。"
        }

## Event Search [/events/search{?keyword,started_on,ended_on}]
### イベント検索 [GET]
+ Parameters
    + keyword: 'もくもく' (string, optional) - 検索キーワード
    + started_on: '2016/06/03' (date, optional) - 開始日
    + ended_on: '2016/06/03' (date, optional) - 終了日

+ Response 200 (application/json)

        {
            "event_id": 1,
            "title": "第1会もくもく会",
            "event_image": "http://example.com/image/sample1.jpg",
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
            "tags": [
                "Ruby",
                "Ruby on Rails"
            ]
        }
