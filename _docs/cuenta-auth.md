## Group Auth API

##  Auth Check [/auth]

**Note**
* 認証確認API

### ログイン中のユーザ情報取得 [GET]

**Note**
- 未ログインの場合は401を返す
    * APIクライアントは401が帰ってきた場合はログイン画面にリダイレクトする

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

+ Response 401 (application/json)

        {
          "message": "ログインしてください"
        }

##  Auth [/auth/login]

**Note**
* 認証API

### ログイン [POST]
**Note**
* アクセストークンを必要としない
* 学籍番号とパスワードで認証を行う
* 認証成功時: Kongと連携しアクセストークンを作成する
    + アクセストークンの有効期限は1週間
    + アクセストークンが作成済みであっても、追加で作成する(複数デバイス対応)
    + APIクライアントはアクセストークンを保持する必要がある。
* 認証失敗時: 404を返す
* パラメータ不正時: 400を返す

+ Request (application/json)

        {
            "number": "g011a1111",
            "password": "g011a1111password"
        }

+ Response 201 (application/json)

        {
            "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9....",
            "user_id": 1,
            "number": "g011c1111",
            "name": "田中 太郎",
            "user_image": "http://example.com/user/sample1.jpg",
            "college": {
              "code": "a",
              "name": "クリエイター"
        }

+ Response 400

+ Response 404
