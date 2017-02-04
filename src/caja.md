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
            * id: (string) - フォルダID(uuid)
            * name: (string) - フォルダ名(=グループ名)
            * image: (string) - フォルダ画像(=グループ画像)
            * created_user: (user) - 作成者
            * created_at: (datetime) - 作成日時
            * updated_user: (user) - 更新者
            * updated_at: (datetime) - 更新日時

    * Body

            {
                "folders": [
                    {
                        "id": "abreveurygbeurveru...",
                        "name": "IS-07",
                        "image": "https://static.neec.ooo/hoehoge.png",
                        "created_user": {
                            "id": 1,
                            "name": "田中 太郎",
                            "number": "G099C0001",
                            "note": "Hello",
                            "image": "https://static.neec.ooo/hoge.png",
                            "college": {
                                "code": "c",
                                "name": "IT"
                            }
                        },
                        "created_at": "2017-01-09T16:00:00.000Z",
                        "updated_user": {
                            "id": 1,
                            "name": "田中 太郎",
                            "number": "G099C0001",
                            "note": "Hello",
                            "image": "https://static.neec.ooo/hoge.png",
                            "college": {
                                "code": "c",
                                "name": "IT"
                            }
                        },
                        "updated_at": "2017-01-09T16:00:00.000Z"
                    },
                    {
                        "id": "abreveurygbeurveru...",
                        "name": "IS-08",
                        "image": "https://static.neec.ooo/fugafuga.png",
                        "created_user": {
                            "id": 1,
                            "name": "田中 太郎",
                            "number": "G099C0001",
                            "note": "Hello",
                            "image": "https://static.neec.ooo/hoge.png",
                            "college": {
                                "code": "c",
                                "name": "IT"
                            }
                        },
                        "created_at": "2017-01-09T16:00:00.000Z",
                        "updated_user": {
                            "id": 1,
                            "name": "田中 太郎",
                            "number": "G099C0001",
                            "note": "Hello",
                            "image": "https://static.neec.ooo/hoge.png",
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

* Request (application/x-www-form-urlencoded)

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
        * id: (string) - フォルダID
        * name: (string) - フォルダ名
        * created_user: (user) - 作成者
        * created_at: (datetime) - 作成日時
        * updated_user: (user) - 更新者
        * updated_at: (datetime) - 更新日時

    * Body

            {
                "id": "neriungerbqoeurgber...",
                "name": "ビジネススキル(2)",
                "created_user": {
                    "id": 1,
                    "name": "田中 太郎",
                    "number": "G099C0001",
                    "note": "Hello",
                    "image": "https://static.neec.ooo/hoge.png",
                    "college": {
                        "code": "c",
                        "name": "IT"
                    }
                },
                "created_at": "2017-01-09T16:00:00.000Z",
                "updated_user": {
                    "id": 1,
                    "name": "田中 太郎",
                    "number": "G099C0001",
                    "note": "Hello",
                    "image": "https://static.neec.ooo/hoge.png",
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

        * parents: (array) - 親フォルダ (TOPまで)
            * id: (string) - フォルダID
            * name: (string) - フォルダ名 (TOPの場合はグループ名)
        * current_folder: (folder) - カレントフォルダ
            * id: (string) - フォルダID
            * name: (string) - フォルダ名
            * created_user: (user) - 作成者
            * created_at: (datetime) - 作成日時
            * updated_user: (user) - 更新者
            * updated_at: (datetime) - 更新日時
        * elements: (array[folder or file]) - カレントフォルダ配下の要素配列
            * type: (string) - 要素タイプ( `folder` or `file` )
            * id: (string) - フォルダ or ファイルID
            * name: (string) - フォルダ/ファイル名
            * created_user: (user) - 作成者
            * created_at: (datetime) - 作成日時
            * updated_user: (user) - 更新者
            * updated_at: (datetime) - 更新日時
            * size: (number) - ファイルサイズ(byte/typeが"file"のみ)

    * Body

            {
                "parents": [
                  {
                    "id": "nireubverlugbreg...",
                    "name": "IS-07"
                  },
                  {
                    "id": "aaaa...",
                    "name": "システム専攻"
                  },
                  {
                    "id": "bbbb...",
                    "name": "グループ開発演習"
                  }
                ],
                "current_folder": {
                    "id": "nireubverlugbreg...",
                    "name": "1班",
                    "created_user": {
                        "id": 1,
                        "name": "田中 太郎",
                        "number": "G099C0001",
                        "note": "Hello",
                        "image": "https://static.neec.ooo/hoge.png",
                        "college": {
                            "code": "c",
                            "name": "IT"
                        }
                    },
                    "created_at": "2017-01-09T16:00:00.000Z",
                    "updated_user": {
                        "id": 1,
                        "name": "田中 太郎",
                        "number": "G099C0001",
                        "note": "Hello",
                        "image": "https://static.neec.ooo/hoge.png",
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
                        "id": "abreveurygbeurveru...",
                        "name": "開発計画表",
                        "created_user": {
                            "id": 1,
                            "name": "田中 太郎",
                            "number": "G099C0001",
                            "note": "Hello",
                            "image": "https://static.neec.ooo/hoge.png",
                            "college": {
                                "code": "c",
                                "name": "IT"
                            }
                        },
                        "created_at": "2017-01-09T16:00:00.000Z",
                        "updated_user": {
                            "id": 1,
                            "name": "田中 太郎",
                            "number": "G099C0001",
                            "note": "Hello",
                            "image": "https://static.neec.ooo/hoge.png",
                            "college": {
                                "code": "c",
                                "name": "IT"
                            }
                        },
                        "updated_at": "2017-01-09T16:00:00.000Z",
                        "size": 12345
                    },
                    {
                        "type": "folder",
                        "id": "abreveurygbeurveru...",
                        "name": "成果物",
                        "created_user": {
                            "id": 1,
                            "name": "田中 太郎",
                            "number": "G099C0001",
                            "note": "Hello",
                            "image": "https://static.neec.ooo/hoge.png",
                            "college": {
                                "code": "c",
                                "name": "IT"
                            }
                        },
                        "created_at": "2017-01-09T16:00:00.000Z",
                        "updated_user": {
                            "id": 1,
                            "name": "田中 太郎",
                            "number": "G099C0001",
                            "note": "Hello",
                            "image": "https://static.neec.ooo/hoge.png",
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

* Request (application/x-www-form-urlencoded)

    * Body Attributes
        * name: `ビジネススキル(2) ` (string, required) - フォルダ名

    * Body

            {
                "name": "ビジネススキル(2)"
            }

* Response 200 (application/json)

    * Body Attributes

        * id: (string) - フォルダID
        * name: (string) - フォルダ名
        * created_user: (user) - 作成者
        * created_at: (datetime) - 作成日時
        * updated_user: (user) - 更新者
        * updated_at: (datetime) - 更新日時

    * Body

            {
                "id": "neriungerbqoeurgber...",
                "name": "ビジネススキル(2)",
                "created_user": {
                    "id": 1,
                    "name": "田中 太郎",
                    "number": "G099C0001",
                    "note": "Hello",
                    "image": "https://static.neec.ooo/hoge.png",
                    "college": {
                        "code": "c",
                        "name": "IT"
                    }
                },
                "created_at": "2017-01-09T16:00:00.000Z",
                "updated_user": {
                    "id": 1,
                    "name": "田中 太郎",
                    "number": "G099C0001",
                    "note": "Hello",
                    "image": "https://static.neec.ooo/hoge.png",
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

        * id: (string) - ファイルID
        * name: (string) - フォルダ/ファイル名
        * created_user: (user) - 作成者
        * created_at: (datetime) - 作成日時
        * updated_user: (user) - 更新者
        * updated_at: (datetime) - 更新日時
        * size: (number) - ファイルサイズ(byte)

    * Body

            {
                "id": "abreveurygbeurveru...",
                "name": "後期時間割",
                "created_user": {
                    "id": 1,
                    "name": "田中 太郎",
                    "number": "G099C0001",
                    "note": "Hello",
                    "image": "https://static.neec.ooo/hoge.png",
                    "college": {
                        "code": "c",
                        "name": "IT"
                    }
                },
                "created_at": "2017-01-09T16:00:00.000Z",
                "updated_user": {
                    "id": 1,
                    "name": "田中 太郎",
                    "number": "G099C0001",
                    "note": "Hello",
                    "image": "https://static.neec.ooo/hoge.png",
                    "college": {
                        "code": "c",
                        "name": "IT"
                    }
                },
                "updated_at": "2017-01-09T16:00:00.000Z",
                "size": 12345
            }

* Response 403

* Response 404

* Response 422

## File [/files/{file_id}]

### ファイルダウンロードURL取得 [GET]

**Note**
* ファイルがみつからない => 404
* Read権限がない => 403
* Read権限がある場合はワンタイムトークンを発行する

* Parameters
    * file_id: `neriungerbqoeurgber...` (string, required) - ファイルID

* Response 200

    * Body Attributes

        * download_url: (string) - ファイルダウンロードURL(ワンタイムトークン付き)

    * Body

            {
                "download_url": "https://api.neec.ooo/download/neriungerbqoeurgber...?token=aaaaaaaa..."
            }

* Response 403

* Response 404

### ファイル名変更 [PATCH]

**Note**
* 必須項目がない => 422
* ファイルがみつからない => 404
* Update権限がない => 403

* Parameters
    * file_id: `neriungerbqoeurgber...` (string, required) - ファイルID

* Request (application/x-www-form-urlencoded)

    * Body Attributes
        * name: `後期時間割システム専攻のみ` (string, required) - フォルダ名

    * Body

            {
                "name": "後期時間割システム専攻のみ"
            }

* Response 200 (application/json)

    * Body Attributes

        * id: (string) - ファイルID
        * name: (string) - ファイル名
        * created_user: (user) - 作成者
        * created_at: (datetime) - 作成日時
        * updated_user: (user) - 更新者
        * updated_at: (datetime) - 更新日時
        * size: (number) - ファイルサイズ(byte)

    * Body

            {
                "id": "abreveurygbeurveru...",
                "name": "後期時間割システム専攻のみ",
                "created_user": {
                    "id": 1,
                    "name": "田中 太郎",
                    "number": "G099C0001",
                    "note": "Hello",
                    "image": "https://static.neec.ooo/hoge.png",
                    "college": {
                        "code": "c",
                        "name": "IT"
                    }
                },
                "created_at": "2017-01-09T16:00:00.000Z",
                "updated_user": {
                    "id": 1,
                    "name": "田中 太郎",
                    "number": "G099C0001",
                    "note": "Hello",
                    "image": "https://static.neec.ooo/hoge.png",
                    "college": {
                        "code": "c",
                        "name": "IT"
                    }
                },
                "updated_at": "2017-01-10T16:00:00.000Z",
                "size": 12345
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

## Download [/download/{file_id}{?token}]

### ファイルダウンロード [GET]

**Note**
* ワンタイムトークン認証(アクセストークンは不要)
* S3へのパスではなく, 直接バイナリを返す
* ファイルがみつからない => 404
* tokenが不正 => 403
* Read権限がある場合はワンタイムトークンを発行する
* ダウンロード後, トークンを無効化する

* Parameters
    * file_id: `neriungerbqoeurgber...` (string, required) - ファイルID
    * token: `aaaaaaaa...` (string, required) - ワンタイムトークン

* Response 200

        ファイルデータ

* Response 403

* Response 404

## Internal Top Folder [/internal/folders{?group_id}]

### Topフォルダ作成-内部 [POST]

**Note**
* 内部向けAPI(認証の必要がない)
* cadenaが呼ぶ
* 指定されたグループのトップフォルダを作成する
* `id: 生成, name: "top", group_id: group_id, parent_id: 0, inserted_by: user_id, updated_by: user_id`
* すでに作成されている => 何もせず204を返す

* Request (application/x-www-form-urlencoded)

    * Body Attributes
        * group_id: `7a02bf4c-76de-47fc-a530-1ce893d7e490` (string, required) - グループID
        * user_id: `1` (number, required) - 作成ユーザID

    * Body

            {
                "group_id": "7a02bf4c-76de-47fc-a530-1ce893d7e490",
                "user_id": 1
            }

* Response 204

### TopフォルダID取得-内部 [GET]

**Note**
* 内部向けAPI(認証の必要がない)
* cadenaが呼ぶ
* 指定されたグループのトップフォルダIDを作成する

* Parameters
    + group_id: `7a02bf4c-76de-47fc-a530-1ce893d7e490` (string, required) - グループID

* Response 200 (application/json)

    * Body Attributes

        * id: (string) - TopフォルダID

    * Body

            {
                "id": "abreveurygbeurveru...",
            }

* Response 404

## Internal Cleanup Folder [/internal/folders/cleanup]

### Topフォルダ全削除-内部 [POST]

**Note**
* 内部向けAPI(認証の必要がない)
* cadenaが呼ぶ
* 指定されたグループのフォルダ/ファイルをすべて削除する
* 存在しない => 何もせずに204を返す

* Request (application/x-www-form-urlencoded)

    * Body Attributes
        * group_id: `7a02bf4c-76de-47fc-a530-1ce893d7e490` (string, required) - グループID

    * Body

            {
                "group_id": "7a02bf4c-76de-47fc-a530-1ce893d7e490"
            }

* Response 204
