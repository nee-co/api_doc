## Group News API

* Request

    * 全てのリクエスト ヘッダーにアクセストークンを付加する必要がある

    * Headers Attributes
        - Authorization (string, required) - アクセストークン

    * Headers

            Authorization: Bearer eyJhbGciOiJIUzI1NiIsI6IkpXVCJ9.eyJleHAi...

## News Collection [/news{?limit,offset}]

### 最新ニュース一覧取得 [GET]

**Note**
* トレイ対応API
* Nee-coシステム全体の更新情報

* Parameters
    + limit: 1 (number, required) - 取得数
    + offset: 0 (number, required) - 取得開始位置 (0 origin)

* Response 200 (application/json)

    * Body Attributes
        * elements: (array[event]) - ニュース一覧
          + id: (number) - 要素ID
          + type (string) - 要素タイプ(遷移先の決定に利用)
          + title: (string) - ニュースタイトル
          + image: (string) - ニュース画像URL
          + meta: (object) - メタ情報
            - type: (string) - `datetime` 固定
            - body: (string) - 日時 (ISO 8601)

    * Body

            {
                "elements": [
                    {
                        "id": 1,
                        "type": "event",
                        "title": "第1会もくもく会",
                        "image": "http://example.com/image/sample1.jpg",
                        "meta": {
                          "type": "datetime",
                          "body": "2017-01-10T16:00:00.000Z"
                        }
                    },
                    {
                        "id": 2,
                        "type": "group",
                        "title": "Rails初心者の会",
                        "image": "http://example.com/image/sample2.jpg",
                        "meta": {
                          "type": "datetime",
                          "body": "2017-01-10T16:00:00.000Z"
                        }
                    }
                ]
            }

## Internal News [/internal/news]

### 新規ニュース作成 [POST]

**Note**
* 常に204を返す
* APIではなく何かしらqueue(SQSとか)使ったほうがよさそう

* Request (application/x-www-form-urlencoded)

        {
            "id": 3,
            "type": "event",
            "title": "第2会もくもく会",
            "image": "http://example.com/image/sample3.jpg"
        }

* Response 204
