## Group User API

## User Search [/users/search{?str,user_ids,college_codes}]
### ユーザLIKE検索 [GET]

**Use Case**
- ファイル管理システム>公開対象追加>ユーザ登録/検索

**Note**
- 氏名と学籍番号を対象にLIKE検索
- 検索結果が0件の場合でも200を返す
- `str` が指定されなかった場合のみ400を返す
- `user_ids` と `college_codes` はXORの関係、同時に指定されることはない。
- 仮に `user_ids` と `college_codes` の両方が指定された場合は `user_ids` のみ参照する

+ Parameters
    + str: `田` (string, required) - 氏名 or 学籍番号
    + user_ids: `1+2+3` (array[string], optional) - 検索対象ユーザID一覧
    + college_codes: `c+g` (array[string], optional) - 検索対象カレッジCode一覧

+ Response 200 (application/json)

    + Body Attributes
        + total_count: (integer) - ユーザ数
        + users: (array) - ユーザ一覧
          - user_id: (integer) - ユーザID
          - number: (string) - 学籍番号
          - name: (string) - ユーザ名
          - user_image: (string) - プロフィール画像フルパス
          - college: (object) - 所属カレッジ
              * code: (string) - カレッジ一意のコード
              * name: (string) - カレッジ名

    + Body

            {
              "total_count": 2,
              "users" [
                {
                    "user_id": 1,
                    "number": "G099C1001",
                    "name": "田中 太郎",
                    "user_image": "http://example.com/user/sample1.jpg",
                    "college": {
                      "code": "c",
                      "name": "IT"
                    }
                },
                {
                    "user_id": 3,
                    "number": "G099G1003",
                    "name": "山田 花子 ",
                    "user_image": "http://example.com/user/sample3.jpg",
                    "college": {
                      "code": "g",
                      "name": "デザイン"
                    }
                }
              ]
            }

+ Response 400 (application/json)

        {
          "message": "リクエストパラメータが不正です"
        }

## User [/users/{user_id}]
### ユーザ情報取得 [GET]

**Use Case**
- プロフィール画面

**Note**
- 指定されたユーザが見つからなかった場合にのみ404を返す

+ Parameters
    + user_id: `田` (number, required) - ユーザID

+ Response 200 (application/json)

    + Body Attributes
        - user_id: (integer) - ユーザID
        - number: (string) - 学籍番号
        - name: (string) - ユーザ名
        - user_image: (string) - プロフィール画像フルパス
        - college: (object) - 所属カレッジ
            * code: (string) - カレッジ一意のコード
            * name: (string) - カレッジ名

    + Body

            {
                "user_id": 1,
                "number": "G099C1001",
                "name": "田中 太郎",
                "user_image": "http://example.com/user/sample1.jpg",
                "college": {
                  "code": "c",
                  "name": "IT"
                }
            }

+ Response 404 (application/json)

        {
          "message": "指定されたユーザは見つかりませんでした"
        }

## User [/internal/users/{user_id}]
### ユーザ情報取得-内部 [GET]

**Note**
- 内部向けAPI(認証の必要がない)
- 指定されたユーザが見つからなかった場合にのみ404を返す

+ Parameters
    + user_id: `田` (number, required) - ユーザID

+ Response 200 (application/json)

    + Body Attributes
        - user_id: (integer) - ユーザID
        - number: (string) - 学籍番号
        - name: (string) - ユーザ名
        - user_image: (string) - プロフィール画像フルパス
        - college: (object) - 所属カレッジ
            * code: (string) - カレッジ一意のコード
            * name: (string) - カレッジ名

    + Body

            {
                "user_id": 1,
                "number": "G099C1001",
                "name": "田中 太郎",
                "user_image": "http://example.com/user/sample1.jpg",
                "college": {
                  "code": "c",
                  "name": "IT"
                }
            }

+ Response 404 (application/json)

        {
          "message": "指定されたユーザは見つかりませんでした"
        }

## User List [/internal/users/list{?user_ids}]
### ユーザリスト取得-内部 [GET]

**Use Case**
- イベント管理システム>参加者一覧+コメント投稿者一覧

**Note**
- 内部向けAPI(認証の必要がない)
- 全てのユーザが取得できた場合のみ200を返す
- ユーザが指定されなかった場合は400を返す
- 一人でも取得できなかった場合は403を返す

+ Parameters
    + user_ids: `1+2+3` (array[string], required) - 取得対象ユーザID一覧

+ Response 200 (application/json)

    + Body Attributes
        + users: (array) - ユーザ一覧
          - user_id: (integer) - ユーザID
          - number: (string) - 学籍番号
          - name: (string) - ユーザ名
          - user_image: (string) - プロフィール画像フルパス
          - college: (object) - 所属カレッジ
              * code: (string) - カレッジ一意のコード
              * name: (string) - カレッジ名

    + Body

            {
              "users": [
                {
                    "user_id": 1,
                    "number": "G099C1001",
                    "name": "田中 太郎",
                    "user_image": "http://example.com/user/sample1.jpg",
                    "college": {
                      "code": "c",
                      "name": "IT"
                    }
                },
                {
                    "user_id": 2,
                    "number": "G099C1002",
                    "name": "山本 二郎",
                    "user_image": "http://example.com/user/sample2.jpg",
                    "college": {
                      "code": "c",
                      "name": "IT"
                    }
                },
                {
                    "user_id": 3,
                    "number": "G099G1003",
                    "name": "山田 花子 ",
                    "user_image": "http://example.com/user/sample3.jpg",
                    "college": {
                      "code": "g",
                      "name": "デザイン"
                    }
                }
              ]
            }

+ Response 400 (application/json)

        {
          "message": "リクエストパラメータが不正です"
        }

+ Response 404 (application/json)

        {
          "message": "一部または全てのユーザが取得できませんでした"
        }
