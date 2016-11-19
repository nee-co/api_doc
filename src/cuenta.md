## Group Token API

##  Token Create [/token]

**Note**
* アクセストークン関連API
* ログアウトAPIは存在せず、クライアントがアクセストークンを破棄することでログアウトしたとみなす

### アクセストークン発行API [POST]

**Note**
* アクセストークンを必要としない
* 学籍番号(大文字/小文字問わない)とパスワードで認証を行う
* 認証成功時: Kongと連携しアクセストークンを作成する
    + アクセストークンの有効期限は1週間
    + アクセストークンが作成済みであっても、追加で作成する(複数デバイス対応)
    + APIクライアントはアクセストークンを保持する必要がある。
* 認証失敗時: 404を返す
* パラメータ不正時: 400を返す

* Request (multipart/form-data)

    + Body Attributes
        * number: `g011a1111` (string, required) - 学籍番号
        * password: `g011a1111password` (string, required) - パスワード

    + Body

            {
                "number": "g011a1111",
                "password": "g011a1111password"
            }

* Response 201 (application/json)

    + Body Attributes
        * token: (string) - アクセストークン
        * expires_at: (string) - アクセストークン有効期限(ISO 8601)

    + Body

            {
                "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9....",
                "expires_at" "2016-11-27T00:50:23.883467+09:00"
            }

* Response 400

* Response 404

##  Token Refresh [/token/refresh]

### アクセストークンの再生成 [POST]

**Note**
* アクセストークンの有効期限を1週間延長する(トークン再生成)

* Request

    + Headers Attributes
        + Authorization (string, required) - アクセストークン

    + Headers

            Authorization: Bearer eyJhbGciOiJIUzI1NiIsI6IkpXVCJ9.eyJleHAi...

* Response 200 (application/json)
    + Body Attributes
        * token: (string) - アクセストークン
        * expires_at: (string) - アクセストークン有効期限(ISO 8601)

    + Body

            {
                "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9....",
                "expires_at" "2016-11-27T00:50:23.883467+09:00"
            }

## Group Login User API

**Note**
* ログイン中のユーザを操作するAPI

**Request**
* 全てのリクエスト ヘッダーにアクセストークンを付加する必要がある
* Headers Attributes
    + Authorization (string, required) - アクセストークン
* Headers

        Authorization: Bearer eyJhbGciOiJIUzI1NiIsI6IkpXVCJ9.eyJleHAi...

##  Login User [/user]

### ユーザ情報取得 [GET]

* Response 200 (application/json)

    + Body Attributes
        * id: (number) - ユーザID
        * number: (string) - 学籍番号
        * name: (string) - ユーザ名
        * note: (string) - 備考
        * image: (string) - ユーザ画像URL
        * college: (object) - 所属カレッジ
            + code: (string) - カレッジ一意のコード
            + name: (string) - カレッジ名

    + Body

            {
                "id": 1,
                "number": "G099C1001",
                "name": "田中 太郎",
                "note": "ハロー",
                "image": "https://static.neec.ooo/user/sample1.jpg",
                "college": {
                  "code": "c",
                  "name": "IT"
                }
            }

##  Login User Password [/user/password]

### ユーザパスワード変更 [PATCH]

**Note**
* パスワード変更成功時 => 204
* current_passwordが正しく無い => 403

* Request (multipart/form-data)

    + Body Attributes
        * current_password: `current_password` (string, required) - 現在のパスワード
        * new_password: `new_password` (string, required) - 変更後パスワード

    + Body

            {
                "current_password": "current_password",
                "new_password": "new_password"
            }

* Response 204
* Response 403

##  Login User Note [/user/note]

### ユーザ備考変更 [PATCH]

**Note**
* 備考変更成功時 => 204

* Request (multipart/form-data)

    + Body Attributes
        * note: `ボーリング得意です` (string, required) - 変更後備考

    + Body

            {
                "note": "ボーリング得意です",
            }

* Response 204

##  Login User Image [/user/image]

### ユーザ画像更新 [POST]

* Request (multipart/form-data)

    + Body Attributes
        * image: (file) - アップロード画像

    + Body

            {
                "image": アップロード画像
            }

* Response 200 (application/json)

    + Body Attributes
        * id: (number) - ユーザID
        * number: (string) - 学籍番号
        * name: (string) - ユーザ名
        * note: (string) - 備考
        * image: (string) - ユーザ画像URL
        * college: (object) - 所属カレッジ
            + code: (string) - カレッジ一意のコード
            + name: (string) - カレッジ名

    + Body

            {
                "id": 1,
                "number": "G099C1001",
                "name": "田中 太郎",
                "note": "Hello",
                "image": "https://static.neec.ooo/user/sample2.jpg",
                "college": {
                  "code": "c",
                  "name": "IT"
                }
            }

## Group User API

## User Name Search [/users/search{?name,limit,offset,except_ids}]

### ユーザ名LIKE検索 [GET]

**Note**
* 氏名を対象にLIKE検索
* 検索結果が0件の場合 => 200(空配列)
* パラメータ不正 => 400

* Parameters
    + name: `田` (string, required) - ユーザ名
    + limit: 1 (number, required) - 取得数
    + offset: 0 (number, required) - 取得開始位置 (0 origin)
    + except_ids: `4` (array[number], required) - 検索対象外ユーザID

* Response 200 (application/json)

    + Body Attributes
        * users: (array) - ユーザ一覧
          + id: (number) - ユーザID
          + number: (string) - 学籍番号
          + name: (string) - ユーザ名
          + note: (string) - 備考
          + image: (string) - ユーザ画像URL
          + college: (object) - 所属カレッジ
              - code: (string) - カレッジ一意のコード
              - name: (string) - カレッジ名

    + Body

            {
              "users" [
                {
                    "id": 1,
                    "number": "G099C1001",
                    "name": "田中 太郎",
                    "note": "ハロー",
                    "image": "https://static.neec.ooo/user/sample1.jpg",
                    "college": {
                      "code": "c",
                      "name": "IT"
                    }
                },
                {
                    "id": 3,
                    "number": "G099G1003",
                    "name": "山田 花子 ",
                    "note": "Hello",
                    "image": "https://static.neec.ooo/user/sample3.jpg",
                    "college": {
                      "code": "g",
                      "name": "デザイン"
                    }
                }
              ]
            }

* Response 400

## User Number Search [/users/search{?number,except_ids}]

### 学籍番号LIKE検索 [GET]

**Note**
* 学籍番号を対象にLIKE検索
* 学籍番号は大文字・小文字どちらでも良い
* 検索結果が1件の場合にのみユーザ情報を返す(0件 or 2件以上 => 200の空配列)
* パラメータ不正 => 400

* Parameters
    + number: `G099C1001` (string, required) - 学籍番号
    + except_ids: `4` (array[number], required) - 検索対象外ユーザID

* Response 200 (application/json)

    + Body Attributes
        * users: (array) - ユーザ一覧
          + id: (number) - ユーザID
          + number: (string) - 学籍番号
          + name: (string) - ユーザ名
          + note: (string) - 備考
          + image: (string) - ユーザ画像URL
          + college: (object) - 所属カレッジ
              - code: (string) - カレッジ一意のコード
              - name: (string) - カレッジ名

    + Body

            {
              "users" [
                {
                    "id": 1,
                    "number": "G099C1001",
                    "name": "田中 太郎",
                    "note": "ハロー",
                    "image": "https://static.neec.ooo/user/sample1.jpg",
                    "college": {
                      "code": "c",
                      "name": "IT"
                    }
                },
              ]
            }

* Response 400

## Internal User [/internal/users/{user_id}]

### ユーザ情報取得-内部 [GET]

**Note**
* 内部向けAPI(認証の必要がない)
* 指定されたユーザが見つからない => 404

* Parameters
    + user_id: `1` (number, required) - ユーザID

* Response 200 (application/json)

    + Body Attributes
        * id: (number) - ユーザID
        * number: (string) - 学籍番号
        * name: (string) - ユーザ名
        * note: (string) - 備考
        * image: (string) - ユーザ画像URL
        * college: (object) - 所属カレッジ
            + code: (string) - カレッジ一意のコード
            + name: (string) - カレッジ名

    + Body

            {
                "id": 1,
                "number": "G099C1001",
                "name": "田中 太郎",
                "note": "",
                "image": "https://static.neec.ooo/user/sample1.jpg",
                "college": {
                  "code": "c",
                  "name": "IT"
                }
            }

* Response 404

## Internal User List [/internal/users/list{?user_ids}]

### ユーザリスト取得-内部 [GET]

**Use Case**
* イベント管理システム>参加者一覧+コメント投稿者一覧

**Note**
* 内部向けAPI(認証の必要がない)
* 全てのユーザが取得できた場合のみ200を返す
* パラメータ不正 => 400
* 一人でも取得できなかった場合 => 404

* Parameters
    + user_ids: `1+2+3` (array[string], required) - 取得対象ユーザID一覧

* Response 200 (application/json)

    + Body Attributes
        * users: (array) - ユーザ一覧
          + id: (number) - ユーザID
          + number: (string) - 学籍番号
          + name: (string) - ユーザ名
          + note: (string) - 備考
          + image: (string) - ユーザ画像URL
          + college: (object) - 所属カレッジ
              - code: (string) - カレッジ一意のコード
              - name: (string) - カレッジ名

    + Body

            {
              "users": [
                {
                    "id": 1,
                    "number": "G099C1001",
                    "name": "田中 太郎",
                    "image": "https://static.neec.ooo/user/sample1.jpg",
                    "college": {
                      "code": "c",
                      "name": "IT"
                    }
                },
                {
                    "id": 2,
                    "number": "G099C1002",
                    "name": "山本 二郎",
                    "image": "https://static.neec.ooo/user/sample2.jpg",
                    "college": {
                      "code": "c",
                      "name": "IT"
                    }
                },
                {
                    "id": 3,
                    "number": "G099G1003",
                    "name": "山田 花子 ",
                    "image": "https://static.neec.ooo/user/sample3.jpg",
                    "college": {
                      "code": "g",
                      "name": "デザイン"
                    }
                }
              ]
            }

* Response 400

* Response 404
