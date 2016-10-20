## Group File API

**Note**

* 公開対象はカレッジかユーザのいずれかが設定される
* カレッジとユーザの両方が設定されることはない
* 一番上階層に `top(全カレッジ閲覧可能)` のディレクトリが存在する

* Request

    + 全てのリクエスト ヘッダーにアクセストークンを付加する必要がある

    + Headers Attributes
        - Authorization (string, required) - アクセストークン

    + Headers

            Authorization: Bearer eyJhbGciOiJIUzI1NiIsI6IkpXVCJ9.eyJleHAi...

## Files Collection [/files/{file_dir_path}]
### ファイルダウンロード [GET]

**Note**

* 指定されたファイルを返す(ダウンロードさせる)

+ Parameters
    + file_dir_path: `example/neeco.txt` (string, required) -現在のディレクトリ階層/ファイル名

+ Response 200

        ファイルを直接返す

### ファイル追加 [POST]

**Note**

* fileはjson値ではなく、アップロード対象ファイル

+ Parameters
    + file_dir_path: `example/` (string, required) -現在のディレクトリ階層(末尾は/)

+ Request (application/json)

        {
            "file": ファイル(type=file),
        >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> college
            "target_type": "college",
            "public_ids": [
                "a",
                "c"
            ]
        ========================================
            "target_type": "user",
            "public_ids": [
                "1",
                "2"
            ]
        >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> user
        }

+ Response 201

### ファイル公開対象更新 [PATCH]

**Note**

* 自分が追加したファイルのみ更新可能 => 204
* 自分が追加したファイル以外を更新しようとした場合 => 403

+ Parameters
    + file_dir_path: `example/neeco.txt` (string, required) -現在のディレクトリ階層/ファイル名

+ Request (application/json)

        {
        >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> college
            "target_type": "college",
            "public_ids": [
                "b",
                "c"
            ]
        ========================================
            "target_type": "user",
            "public_ids": [
                "1",
                "2"
            ]
        >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> user
        }

+ Response 204
+ Response 403

### ファイル削除 [DELETE]

**Note**

* 自分が追加したファイルのみ削除可能 => 204
* 自分が追加したファイル以外を削除しようとした場合 => 403

+ Parameters
    + file_dir_path: `example/neeco.txt` (string, required) -現在のディレクトリ階層/ファイル名

+ Response 204
+ Response 403

## Directories Collection [/files/{file_dir_path}]

### ディレクトリ配下情報取得 [GET]

**Note**

* 現在ログイン中のユーザが閲覧できるディレクトリとファイルを返す

+ Parameters
    + file_dir_path: `example/neeco/` (string, required) -現在のディレクトリ階層(末尾は/)

+ Response 200 (application/json)

    + Body Attributes

        + current_dir: (object) - カレントディレクトリ
            - name: (string) - ディレクトリ名
            - target_type: (string) - 公開対象type( `user` or `college` )
            - targets: (array) - 公開対象一覧
        + elements: (array) - カレントディレクトリ配下の要素配列
            - type: (string) - 要素タイプ( `file` or `dir` )
            - name: (string) - 要素名
            - created_user: (object) - 作成者
            - created_at: (datetime) - 作成日時
            - updated_at: (datetime) - 更新日時

    + Body

            {
                "current_dir": {
                  "name": "neeco",
            >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> college
                  "target_type": "college",
                  "targets": [
                      {
                          code: "a",
                          name: "クリエイター"
                      },
                      {
                          code: "c",
                          name: "IT"
                      }
                  ]
            ========================================
                  "target_type": "user",
                  "targets": [
                      {
                          "user_id": 1,
                          "name": "田中 太郎",
                          "number": "G099C0001"
                          "user_image": "http://example.com/image/tanaka.jpg",
                          "college": {
                              "code": "c",
                              "name": "IT"
                          }
                      },
                      {
                          "user_id": 2,
                          "name": "山田 花子",
                          "number": "G099G0002"
                          "user_image": "http://example.com/image/yamada.jpg",
                          "college": {
                              "code": "g",
                              "name": "デザイン"
                          }
                      }
                  ]
            >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> user
                },
                "elements": [
                    {
                        "type": "file",
                        "name": "example.txt",
                        "created_user": {
                            "user_id": 1,
                            "name": "田中 太郎",
                            "number": "G099C0001"
                            "user_image": "http://example.com/image/tanaka.jpg",
                            "college": {
                                "code": "c",
                                "name": "IT"
                            }
                        },
                        "created_at": "2016/06/03 15:00",
                        "updated_at": "2016/06/03 15:00"
                    },
                    {
                        "type": "dir",
                        "name": "exampleDir",
                        "created_user": {
                            "user_id": 1,
                            "name": "田中 太郎",
                            "number": "G099C0001"
                            "user_image": "http://example.com/image/tanaka.jpg",
                            "college": {
                                "code": "c",
                                "name": "IT"
                            }
                        },
                        "created_at": "2016/06/03 15:00",
                        "updated_at": "2016/06/30 15:00"
                    }
                ]
            }

### ディレクトリ追加・更新 [PUT]

**Note**

* 正常に追加できた場合 => 201
* 既に存在する場合
    + 自分が追加したディレクトリなら更新する => 204
    + 自分が追加したディレクトリ以外なら更新しない => 403

+ Parameters
    + file_dir_path: `example/` (string, required) -現在のディレクトリ階層(末尾は/)

+ Request (application/json)

        {
            "name": "neeco",
        >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> college
            "target_type": "college",
            "public_ids": [
                "a",
                "c"
            ]
        ========================================
            "target_type": "user",
            "public_ids": [
                "1",
                "2"
            ]
        >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> user
        }

+ Response 201
+ Response 204
+ Response 403

### ディレクトリ削除 [DELETE]

**Note**

* 配下のファイル/ディレクトリも削除する(他人が追加したものも含む)
* 自分が追加したディレクトリのみ削除可能 => 204
* 自分が追加したディレクトリ以外の場合 => 403

+ Parameters
    + file_dir_path: `example/neeco/` (string, required) -現在のディレクトリ階層(末尾は/)

+ Response 204

+ Response 403
