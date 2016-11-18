## Group Folder / File API

**Note**
* すべてのファイルとフォルダは1つのグループに紐づく
* グループメンバのみCreate, Read権限を持つ
* ファイルのアップロード者のみUpdate, Delete権限を持つ
* ファイルやフォルダの変更(Create, Update, Delete)時に親フォルダの更新日時及び更新者を更新する

**Request**
* 全てのリクエスト ヘッダーにアクセストークンを付加する必要がある
* Headers Attributes
    * Authorization (string, required) - アクセストークン
* Headers

        Authorization: Bearer eyJhbGciOiJIUzI1NiIsI6IkpXVCJ9.eyJleHAi...

## Folder Collection [/folders]

### TOPフォルダ一覧取得 [GET]

**Note**
* 自分が所属しているグループに紐づいているTOPフォルダを返す

* Response 200 (application/json)

    * Body Attributes

        * folders: (array[folder]) - TOPフォルダ一覧
            * folder_id: (string) - フォルダID
            * name: (string) - フォルダ名
            * updated_user (user) - 更新者
            * updated_at: (datetime) - 更新日時

    * Body

            {
                "folders": [
                    {
                        "folder_id": "abreveurygbeurveru...",
                        "name": "IS-07",
                        "updated_user": {
                            "user_id": 1,
                            "name": "田中 太郎",
                            "number": "G099C0001",
                            "note": "Hello",
                            "user_image": "https://static.neec.ooo/hoge.png",
                            "college": {
                                "code": "c",
                                "name": "IT"
                            }
                        },
                        "updated_at": "2017-01-09T16:00:00.000Z"
                    },
                    {
                        "folder_id": "abreveurygbeurveru...",
                        "name": "IS-08",
                        "updated_user": {
                            "user_id": 2,
                            "name": "山田 花子",
                            "number": "G099C0001",
                            "note": "Hello",
                            "user_image": "https://static.neec.ooo/hoge.png",
                            "college": {
                                "code": "c",
                                "name": "IT"
                            }
                        },
                        "updated_at": "2017-01-09T16:00:00.000Z"
                    }
                ]
            }

### フォルダ追加 [POST]

**Note**
* 本APIで作成するフォルダは必ず上階層のフォルダが存在する
* フォルダは階層構造を表現するためのものであり, 実際にはフォルダは作成しない
* Cread権限がない => 403
* 必須項目がない => 422
* 同名のフォルダ/ファイルが存在する場合 => 422

* Request (multipart/form-data)

    * Body Attributes
        * name: `ビジネススキル` (string, required) - グループ名
        * parent_id: `abreveurygbeurveru...` (string, required) - 親フォルダID

    * Body

            {
                "name": "ビジネススキル",
                "parent_id": `abreveurygbeurveru...`
            }

* Response 201 (application/json)

    * Body Attributes
        * folder_id: (string) - フォルダID
        * name: (string) - フォルダ名
        * created_user: (user) - 作成者
        * created_at: (datetime) - 作成日時
        * updated_user: (user) - 更新者
        * updated_at: (datetime) - 更新日時

    * Body

            {
                "folder_id": "neriungerbqoeurgber...",
                "name": "ビジネススキル(2)",
                "created_user": {
                    "user_id": 1,
                    "name": "田中 太郎",
                    "number": "G099C0001",
                    "note": "Hello",
                    "user_image": "https://static.neec.ooo/hoge.png",
                    "college": {
                        "code": "c",
                        "name": "IT"
                    }
                },
                "created_at": "2017-01-09T16:00:00.000Z",
                "updated_user": {
                    "user_id": 1,
                    "name": "田中 太郎",
                    "number": "G099C0001",
                    "note": "Hello",
                    "user_image": "https://static.neec.ooo/hoge.png",
                    "college": {
                        "code": "c",
                        "name": "IT"
                    }
                },
                "updated_at": "2017-01-09T16:00:00.000Z"
            }

* Response 403

* Response 422

## Folder [/folders/{folder_id}]

### フォルダ情報取得 [GET]

**Note**
* Read権限がない => 403
* フォルダが見つからない => 404

* Parameters
    * folder_id: `neriungerbqoeurgber...` (string, required) -フォルダID

* Response 200 (application/json)

    * Body Attributes

        * current_folder: (folder) - カレントフォルダ
            * folder_id: (string) - フォルダID
            * name: (string) - フォルダ名
            * created_user: (user) - 作成者
            * created_at: (datetime) - 作成日時
            * updated_user: (user) - 更新者
            * updated_at: (datetime) - 更新日時
        * elements: (array[folder or file]) - カレントフォルダ配下の要素配列
            * type: (string) - 要素タイプ( `folder` or `file` )
            * file_id: (string) - ファイルID(type == `file` )
            * folder_id: (string) - フォルダID(type == `folder` )
            * name: (string) - フォルダ/ファイル名
            * created_user: (user) - 作成者
            * created_at: (datetime) - 作成日時
            * updated_user: (user) - 更新者
            * updated_at: (datetime) - 更新日時

    * Body

            {
                "current_folder": {
                    "folder_id": "nireubverlugbreg...",
                    "name": "IS-07",
                    "created_user": {
                        "user_id": 1,
                        "name": "田中 太郎",
                        "number": "G099C0001",
                        "note": "Hello",
                        "user_image": "https://static.neec.ooo/hoge.png",
                        "college": {
                            "code": "c",
                            "name": "IT"
                        }
                    },
                    "created_at": "2017-01-09T16:00:00.000Z",
                    "updated_user": {
                        "user_id": 1,
                        "name": "田中 太郎",
                        "number": "G099C0001",
                        "note": "Hello",
                        "user_image": "https://static.neec.ooo/hoge.png",
                        "college": {
                            "code": "c",
                            "name": "IT"
                        }
                    },
                    "updated_at": "2017-01-09T16:00:00.000Z"
                },
                "elements": [
                    {
                        "type": "file",
                        "file_id": "abreveurygbeurveru...",
                        "name": "後期時間割",
                        "created_user": {
                            "user_id": 1,
                            "name": "田中 太郎",
                            "number": "G099C0001",
                            "note": "Hello",
                            "user_image": "https://static.neec.ooo/hoge.png",
                            "college": {
                                "code": "c",
                                "name": "IT"
                            }
                        },
                        "created_at": "2017-01-09T16:00:00.000Z",
                        "updated_user": {
                            "user_id": 1,
                            "name": "田中 太郎",
                            "number": "G099C0001",
                            "note": "Hello",
                            "user_image": "https://static.neec.ooo/hoge.png",
                            "college": {
                                "code": "c",
                                "name": "IT"
                            }
                        },
                        "updated_at": "2017-01-09T16:00:00.000Z"
                    },
                    {
                        "type": "folder",
                        "folder_id": "abreveurygbeurveru...",
                        "name": "ビジネススキル",
                        "created_user": {
                            "user_id": 1,
                            "name": "田中 太郎",
                            "number": "G099C0001",
                            "note": "Hello",
                            "user_image": "https://static.neec.ooo/hoge.png",
                            "college": {
                                "code": "c",
                                "name": "IT"
                            }
                        },
                        "created_at": "2017-01-09T16:00:00.000Z",
                        "updated_user": {
                            "user_id": 1,
                            "name": "田中 太郎",
                            "number": "G099C0001",
                            "note": "Hello",
                            "user_image": "https://static.neec.ooo/hoge.png",
                            "college": {
                                "code": "c",
                                "name": "IT"
                            }
                        },
                        "updated_at": "2017-01-09T16:00:00.000Z"
                    }
                ]
            }

* Response 403

* Response 404

### フォルダ名変更 [PATCH]

**Note**
* Update権限がない => 403
* フォルダが見つからない => 404

* Parameters
    * folder_id: `neriungerbqoeurgber...` (string, required) - フォルダID

* Request (multipart/form-data)

    * Body Attributes
        * name: `ビジネススキル(2) ` (string, required) - フォルダ名

    * Body

            {
                "name": "ビジネススキル(2)"
            }

* Response 200 (application/json)

    * Body Attributes

        * folder_id: (string) - フォルダID
        * name: (string) - フォルダ名
        * created_user: (user) - 作成者
        * created_at: (datetime) - 作成日時
        * updated_user: (user) - 更新者
        * updated_at: (datetime) - 更新日時

    * Body

            {
                "folder_id": "neriungerbqoeurgber...",
                "name": "ビジネススキル(2)",
                "created_user": {
                    "user_id": 1,
                    "name": "田中 太郎",
                    "number": "G099C0001",
                    "note": "Hello",
                    "user_image": "https://static.neec.ooo/hoge.png",
                    "college": {
                        "code": "c",
                        "name": "IT"
                    }
                },
                "created_at": "2017-01-09T16:00:00.000Z",
                "updated_user": {
                    "user_id": 1,
                    "name": "田中 太郎",
                    "number": "G099C0001",
                    "note": "Hello",
                    "user_image": "https://static.neec.ooo/hoge.png",
                    "college": {
                        "code": "c",
                        "name": "IT"
                    }
                },
                "updated_at": "2017-01-09T16:00:00.000Z"
            }

* Response 403

* Response 404

### フォルダ削除 [DELETE]

**Note**
* 配下にあるフォルダ/ファイルも同時に削除する(配下は権限問わず)
* Delete権限がない => 403
* フォルダが見つからない => 404

* Parameters
    * folder_id: `neriungerbqoeurgber...` (string, required) -フォルダID

* Response 204

* Response 403

* Response 404

## File [/files]

### ファイルアップロード [POST]

**Note**
* アップロードされたファイルからファイル名を抽出する
* 必須項目がない => 422
* アップロード先フォルダが見つからない => 404
* 同名のフォルダ/ファイが存在する場合 => 422
* Create権限がない => 403

* Request (multipart/form-data)

    * Body Attributes
        * file: (file, required) - アップロードファイル
        * parent_id: `abreveurygbeurveru...` (string, required) - 親フォルダID

    * Body

            {
                "file": アップロードファイル,
                "parent_id": `abreveurygbeurveru...`
            }

* Response 200 (application/json)

    * Body Attributes

        * file_id: (string) - ファイルID
        * name: (string) - フォルダ/ファイル名
        * created_user: (user) - 作成者
        * created_at: (datetime) - 作成日時
        * updated_user: (user) - 更新者
        * updated_at: (datetime) - 更新日時

    * Body

            {
                "file_id": "abreveurygbeurveru...",
                "name": "後期時間割",
                "created_user": {
                    "user_id": 1,
                    "name": "田中 太郎",
                    "number": "G099C0001",
                    "note": "Hello",
                    "user_image": "https://static.neec.ooo/hoge.png",
                    "college": {
                        "code": "c",
                        "name": "IT"
                    }
                },
                "created_at": "2017-01-09T16:00:00.000Z",
                "updated_user": {
                    "user_id": 1,
                    "name": "田中 太郎",
                    "number": "G099C0001",
                    "note": "Hello",
                    "user_image": "https://static.neec.ooo/hoge.png",
                    "college": {
                        "code": "c",
                        "name": "IT"
                    }
                },
                "updated_at": "2017-01-09T16:00:00.000Z"
            }

* Response 403

* Response 404

* Response 422

## File [/files/{file_id}]

### ファイルダウンロード [GET]

**Note**
* S3へのパスではなく, 直接バイナリを返す
* ファイルがみつからない => 404
* Read権限がない => 403

* Parameters
    * file_id: `neriungerbqoeurgber...` (string, required) - ファイルID

* Response 200

        ファイルデータ

* Response 403

* Response 404

### ファイル名変更 [PATCH]

**Note**
* 必須項目がない => 422
* ファイルがみつからない => 404
* Update権限がない => 403

* Parameters
    * file_id: `neriungerbqoeurgber...` (string, required) - ファイルID

* Request (multipart/form-data)

    * Body Attributes
        * name: `後期時間割システム専攻のみ` (string, required) - フォルダ名

    * Body

            {
                "name": "後期時間割システム専攻のみ"
            }

* Response 200 (application/json)

    * Body Attributes

        * file_id: (string) - ファイルID
        * name: (string) - フォルダ/ファイル名
        * created_user: (user) - 作成者
        * created_at: (datetime) - 作成日時
        * updated_user: (user) - 更新者
        * updated_at: (datetime) - 更新日時

    * Body

            {
                "file_id": "abreveurygbeurveru...",
                "name": "後期時間割システム専攻のみ",
                "created_user": {
                    "user_id": 1,
                    "name": "田中 太郎",
                    "number": "G099C0001",
                    "note": "Hello",
                    "user_image": "https://static.neec.ooo/hoge.png",
                    "college": {
                        "code": "c",
                        "name": "IT"
                    }
                },
                "created_at": "2017-01-09T16:00:00.000Z",
                "updated_user": {
                    "user_id": 1,
                    "name": "田中 太郎",
                    "number": "G099C0001",
                    "note": "Hello",
                    "user_image": "https://static.neec.ooo/hoge.png",
                    "college": {
                        "code": "c",
                        "name": "IT"
                    }
                },
                "updated_at": "2017-01-10T16:00:00.000Z"
            }

* Response 403

* Response 404

* Response 422

### ファイル削除 [DELETE]

**Note**
* ファイルが見つからない => 404
* Delete権限がない => 403

* Parameters
    * file_id: `neriungerbqoeurgber...` (string, required) - ファイルID

* Response 204

* Response 403

* Response 404

## Internal Top Folder [/internal/folders]

### Topフォルダ作成-内部 [POST]

**Note**
* 内部向けAPI(認証の必要がない)
* cadenaが呼ぶ
* 指定されたグループのトップフォルダを作成する
* `id: 生成, name: "top", group_id: params['group_id'], parent_id: 0`
* すでに作成されている => 何もせず204を返す

* Request (multipart/form-data)

    * Body Attributes
        * group_id: 1 (number, required) - グループID

    * Body

            {
                "group_id": 1
            }

* Response 204

## Internal Cleanup Folder [/internal/folders/cleanup]

### Topフォルダ全削除-内部 [POST]

**Note**
* 内部向けAPI(認証の必要がない)
* cadenaが呼ぶ
* 指定されたグループのフォルダ/ファイルをすべて削除する
* 存在しない => 何もせずに204を返す

* Request (multipart/form-data)

    * Body Attributes
        * group_id: 1 (number, required) - グループID

    * Body

            {
                "group_id": 1
            }

* Response 204
