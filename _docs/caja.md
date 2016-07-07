## Group File API

## Files Collection [/files/list{?dir_names}]
**Note**
- 公開対象はカレッジかユーザのいずれかが設定される
- カレッジとユーザの両方が設定されることはない

### ディレクトリ・ファイル取得 [GET]
**Note**
- 現在ログイン中のユーザが閲覧できるディレクトリとファイルを返す

+ Parameters
    + dir_names: `/example/NEECO` (string, required) -現在のディレクトリ階層

+ Response 200 (application/json)

    + Body Attributes

        + current_dir: (object) - カレントディレクトリ
            - name: (string) - ディレクトリ名
            - target_type: (string) - 公開対象type( `user` or `college` )
            - targets: (array) - 公開対象一覧
        + elements: (array) - カレントディレクトリ配下の要素配列
            - type: (string) - 要素タイプ( `file` or `dir` )
            - name: (string) - 要素名
            - path: (string) - ファイルパス(type == `file` のみ)
            - created_user: (object) - 作成者
            - updated_user: (object) - 更新者
            - created_at: (datetime) - 作成日時
            - updated_at: (datetime) - 更新日時

    + Body

            {
                "current_dir": {
                  "name": "NEECO",
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
                },
                "current_dir": {
                  "name": "NEECO",
                  "target_type": "user",
                  "targets": [
                      {
                          "name": "田中 太郎",
                          "number": "G099C0001"
                          "user_image": "http://example.com/image/tanaka.jpg",
                          "college": {
                              "code": "c",
                              "name": "IT"
                          }
                      },
                      {
                          "name": "山田 花子",
                          "number": "G099G0002"
                          "user_image": "http://example.com/image/yamada.jpg",
                          "college": {
                              "code": "g",
                              "name": "デザイン"
                          }
                      }
                  ]
                },
                "elements": [
                    {
                        "type": "file",
                        "name": "example.txt",
                        "path": "file/example/example.txt",
                        "created_user": {
                            "name": "田中 太郎",
                            "number": "G099C0001"
                            "user_image": "http://example.com/image/tanaka.jpg",
                            "college": {
                                "code": "c",
                                "name": "IT"
                            }
                        },
                        "updated_user": {
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
                            "name": "田中 太郎",
                            "number": "G099C0001"
                            "user_image": "http://example.com/image/tanaka.jpg",
                            "college": {
                                "code": "c",
                                "name": "IT"
                            }
                        },
                        "updated_user": {
                            "name": "山田 花子",
                            "number": "G099G0002"
                            "user_image": "http://example.com/image/yamada.jpg",
                            "college": {
                                "code": "g",
                                "name": "デザイン"
                            }
                        },
                        "created_at": "2016/06/03 15:00",
                        "updated_at": "2016/06/30 15:00"
                    }
                ]
            }

### ディレクトリ追加 [POST]
+ Parameters
    + dir_names: `/example/NEECO` (string, required) -現在のディレクトリ階層

+ Request (application/json)

        {
            "type": "dir",
            "name": "example_dir",
            "target_type": "colleges",
            "public_ids": [
                "a",
                "c"
            ]
        }

+ Request (application/json)

        {
            "type": "dir",
            "name": "example_dir",
            "target_type": "users",
            "public_ids": [
                "G013C1145",
                "G013C1432"
            ]
        }

+ Response 201 (application/json)

        {
            "message": "正常に追加されました"
        }

### ファイル追加 [POST]
+ Parameters
    + dir_names: `/example/NEECO` (string, required) -現在のディレクトリ階層

+ Request (application/json)

        {
            "type": "file",
            "name": "example.txt",
            "body": "Example Text",
            "target_type": "colleges",
            "public_ids": [
                "a",
                "c"
            ]
         }

+ Request (application/json)

        {
            "type": "file",
            "name": "example.txt",
            "body": "Example Text",
            "target_type": "users",
            "public_ids": [
                "G013C1145",
                "G013C1431"
            ]
        }

+ Response 201 (application/json)

        {
            "message": "正常に追加されました"
        }

### ディレクトリ・ファイル公開対象更新 [PUT]
**Note**
+ 自分が追加したディレクトリ・ファイルのみ更新可能

+ Parameters
    + dir_names: `/example/NEECO` (string, required) -現在のディレクトリ階層

+ Request (application/json)

        {
            "type": "file",
            "name": "example.txt",
            "college_ids": [
                "b",
                "c"
            ]
        }

+ Response 200 (application/json)

        {
            "message": "正常に公開対象が更新されました。"
        }

### ディレクトリ・ファイル削除 [DELETE]
**Note**
+ 自分が追加したディレクトリ・ファイルのみ削除可能
+ ディレクトリを削除した場合、配下ごと削除する

+ Parameters
    + dir_names: `/example/NEECO` (string, required) -現在のディレクトリ階層

+ Response 200 (application/json)

        {
            "message": "正常に削除されました。"
        }
