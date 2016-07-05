## Group File API

## Files Collection [/files/list{?dir_names}]
### ディレクトリ・ファイル取得 [GET]
**Note**
- 現在ログイン中のユーザが閲覧できるディレクトリとファイルを返す

+ Parameters
    + dir_names: `/example/NEECO` (string, required) -現在のディレクトリ階層

+ Response 200 (application/json)

        {
            "current_dir": "NEECO",
            "public_target": [
                {
                    code: "a",
                    name: "クリエイター"
                },
                {
                    code: "c",
                    name: "IT"
                }
            ],
            "elements": [
                {
                    "type": "file",
                    "name": "example.txt",
                    "path": "file/example/example.txt",
                    "user_name": "田中　太郎",
                    "created_at": "2016/06/03 15:00"
                },
                {
                    "type": "dir",
                    "name": "exampleDir",
                    "user_name": "田中　太郎",
                    "created_at": "2016/06/02 12:12"
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
            "college_ids": [
                "a",
                "c"
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
            "user_ids": [
                "G013C1145",
                "G013C1431"
            ]
        }

+ Response 201 (application/json)

        {
            "message": "正常に追加されました"
        }

### ディレクトリ・ファイル削除 [DELETE]
**Note**
+ 自分が追加したディレクトリ・ファイルのみ削除可能
+ ディレクトリを削除した場合、配下ごと削除する

+ Parameters
    + dir_names: `/example/NEECO` (string, required) -現在のディレクトリ階層
    + type: `dir` (string, required) - 削除対象type(`dir` or `file`)

+ Response 204 (application/json)

        {
            "message": "正常に削除されました。"
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
