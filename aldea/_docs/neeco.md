FORMAT: 1A
HOST: http://neeco.api/

# neeco

## Events Collection [/events]
### イベント全件取得 [GET]
+ Response 200 (application/json)

        {
            "event_id": 1,
            "title": "第1会もくもく会",
            "event_image": "image/sample1.jpg",
            "tags": [
                "もくもく会",
                "Ruby",
                "Scala"
            ]
        }
        {
            "event_id": 2,
            "title": "Rails勉強会",
            "event_image": "image/sample2.jpg",
            "tags": [
                "Ruby",
                "Ruby on Rails"
            ]
        }
 
+ Response 404 (application/json)

### 新規イベント作成 [POST]
+ Request (application/json)

        {
            "title": "第1会もくもく会", - 必須項目
            "event_image": "sample1.jpg",
            "tags": {
                "もくもく会",
                "Ruby",
                "Scala"
            },
            "body": "第1回もくもく会を開催いたします",
            "register_id": "sasaki",
            "started_at": "2016/06/03 12:00",
            "ended_at": "2016/06/03 15:00",
            "venue": "研究棟B 401",
            "entry_upper_limit": 10,
        }

+ Response 201 (application/json)

        {
            "massage": "新規イベント作成が正常に行われました"
        }

+ Response 400 (application/json)

        {
            "massage": "新規イベント作成が正常に行われませんでした"
        }


## Event [/events/{id}]
### イベント情報取得 [GET]
+ Parameters
    + event_id (number) - 取得対象イベントid
 
+ Response 200 (application/json)

        {
            "title": "第1会もくもく会",
            "event_image": "image/sample1.jpg",
            "tags": {
                "もくもく会",
                "Ruby",
                "Scala"
            },
            "body": "第1回もくもく会を開催いたします",
            "register_id": "sasaki",
            "published_at": "2016/06/01 09:00",
            "started_at": "2016/06/03 12:00",
            "ended_at": "2016/06/03 15:00",
            "venue": "研究棟B 401",
            "entry_upper_limit": 10,
            "status": 1,
            "entries": [
                {
                    "user_id": 2,
                    "name": "tanaka",
                    "image": "image/tanaka.jpg"
                }, {
                    "user_id": 3,
                    "name": "satou",
                    "image": "image/satou.jpg"
                }
            ],
            "comments": [
                {
                    "user_id": 2,
                    "name": "tanaka",
                    "body": "こんにちは！",
                    "posted_at": "2016/06/01 12:02",
                    "image": "image/tanaka.jpg"
                }, {
                    "user_id": 4,
                    "name": "yamada",
                    "body": "参加を考えてます!",
                    "posted_at": "2016/06/01 15:12",
                    "image": "image/yamada.jpg"
                }
            ]
        }

+ Response 404 (application/json)

### イベント更新 [PATCH]
+ Parameters
    + event_id (number) - 更新対象イベントid

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
            "massage": "更新が正常に行われました。"
        }

### イベント削除 [DELETE]
+ Parameters
    + event_id (number) - 削除対象イベントid

+ Response 204 (application/json)

        {
            "massage": "削除が正常に行われました。"
        }
