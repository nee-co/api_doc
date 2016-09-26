## Group Notification API

**Note**

* 通知の新規作成は各サブシステムのみ実施

* Request

    + 全てのリクエスト ヘッダーにアクセストークンを付加する必要がある

    + Headers Attributes
        - Authorization (string, required) - アクセストークン

    + Headers

            Authorization: Bearer eyJhbGciOiJIUzI1NiIsI6IkpXVCJ9.eyJleHAi...


##  Notification List [/notifications]

### ログイン中のユーザ宛の通知一覧取得 [GET]

+ Response 200 (application/json)

    + Body Attributes
        + notifications: (array) - 通知一覧
          - notification_id: (string, required) - 通知ID
          - title: (string, required) - 通知タイトル
          - body: (string, optional) - 通知本文
          - link: (string, optional) - リンク
          - image: (string, optional) - 画像フルパス

    + Body

            {
                "notifications": [
                    {
                        "notification_id": 1,
                        "title": "[更新] もくもく会 #2",
                        "body": "イベント内容が変更されました",
                        "link": "http://example.com/events/2",
                        "image": "http://example.com/images/events/sample1.jpg"
                    },
                    {
                        "notification_id": 2,
                        "title": "[緊急] 台風接近に伴う休講状況",
                        "body": "各自、担任の指示に従うこと",
                        "link": "",
                        "image": ""
                    }
                ]
            }

##  Confirmed Notification [/notifications/{notification_id}]

### 確認済み通知の削除 [DELETE]

**Note**

* 該当する通知がない => 404

+ Parameters
    - notification_id: 1 (numbers) - 削除対象通知ID

+ Response 204
+ Response 404

## Notification [/internal/notifications]

### 通知追加-内部 [POST]

**Note**

* 内部向けAPI(認証の必要がない)

**Request Parameters**

* user_id: (numbers, requird) - 通知対象ユーザID
* title: (string, required) - 通知タイトル
* body: (string, optional) - 通知本文
* link: (string, optional) - リンク
* image: (string, optional) - 画像フルパス

+ Request (application/json)

        {
            "user_id": 1,
            "title": "[更新] もくもく会 #2",
            "body": "イベント内容が変更されました",
            "link": "http://example.com/events/2",
            "image": "http://example.com/images/events/sample1.jpg"
        }

+ Response 204
