## Group Group API

**Note**

* グループには2つの参加方式が存在する
    + public
        - `is_private` = false
        - 自由参加型
        - `グループ検索` にヒットする
        - 誰でも参加/脱退が自由に行える

    + private
        - `is_private` = true
        - 完全招待型
        - `グループ検索` にヒットしない
        - グループメンバがユーザ検索をし、特定のユーザに対して `招待` を送信する
        - 招待を受けたユーザは `参加` と `招待拒否` を選択することができる

* Request

    + 全てのリクエスト ヘッダーにアクセストークンを付加する必要がある

    + Headers Attributes
        - Authorization (string, required) - アクセストークン

    + Headers

            Authorization: Bearer eyJhbGciOiJIUzI1NiIsI6IkpXVCJ9.eyJleHAi...

##  Group Collection [/groups]

### 新規グループ作成 [POST]

**Note**

* 必須項目が未設定の場合 => 422
* ログイン中ユーザは作成したグループに参加する
* user_idsに値が入っていた場合は、該当するユーザを招待する

* Request (multipart/form-data)

    + Body Attributes
        * name: `IS-07` (number, required) - グループ名
        * note: `ITスペシャリスト学科 7期のグループ` (string, optinal) - 備考
        * is_private: `true` (boolean, optional) - 非公開フラグ
        * group_image: (file) - グループ画像
        * user_ids[]: 1 (array[number], optional) - 招待ユーザID

    + Body

            {
                "name": "IS-07",
                "is_private": false,
                "note": "ITスペシャリスト学科 7期のグループ",
                "group_image": グループ画像,
                "user_ids": [
                    1,
                    2
                ]
            }

* Response 201 (application/json)

    + Body Attributes
        * group_id: (number) - グループID
        * name: (string) - グループ名
        * note: (string) - 備考
        * is_private: (boolean) - 非公開フラグ
        * group_image: (string) - グループ画像URL

    + Body

            {
                "group_id": 1,
                "name": "IS-07",
                "note": "ITスペシャリスト学科 7期のグループ",
                "is_private": false,
                "group_image": "https://static.neec.ooo/hogehoge.png"
            }

* Response 422

### 所属するグループ一覧取得 [GET]

**Note**

* ログイン中のユーザが所属するグループを返す

* Response 200 (application/json)

    + Body Attributes
        * groups: (array[group]) - グループ一覧
            + group_id: (number) - グループID
            + name: (string) - グループ名
            + note: (string) - 備考
            + is_private: (boolean) - 非公開フラグ
            + group_image: (string) - グループ画像URL
        * invitations: (array[group]) - 招待を受けているグループ一覧

    + Body

            {
                "groups": [
                    {
                        "group_id": 1,
                        "name": "IS-07",
                        "note": "ITスペシャリスト科 7期のグループ",
                        "is_private": false,
                        "group_image": "https://static.neec.ooo/hoehoge.png"

                    },
                    {
                        "group_id": 3,
                        "name": "テニスサークル",
                        "note": "",
                        "is_private": true,
                        "group_image": "https://static.neec.ooo/fugafuga.jpg"
                    }
                ],
                "invitation": [
                    {
                        "group_id": 2,
                        "name": "IS-07-Systems",
                        "note": "ITスペシャリスト科 7期 システム専攻",
                        "is_private": true,
                        "group_image": "https://static.neec.ooo/aiueo.png"

                    },
                    {
                        "group_id": 4,
                        "name": "ITカレッジ Vimmerの会",
                        "note": "Vim大好きクラブ",
                        "is_private": false,
                        "group_image": "https://static.neec.ooo/vim.png"

                    }
                ]
            }

##  Group Search [/groups/search{?keyword,page,per}]

### グループ検索 [GET]

**Note**

* `public` のグループの中から検索する
* 検索キーワードが未入力の場合は `public` のものを全て返す

* Parameters
    + keyword: `IS` (string) - 検索キーワード
    + page: 1 (number, required) - ページ番号
    + per: 10 (number, required) - 1ページあたりの件数

* Response 200 (application/json)

    + Body Attributes
        * page: (number) - ページ番号
        * per: (number) - 1ページあたりの件数
        * total_count: 2 (number) - 総件数
        * groups: (array[group]) - グループ一覧
            + group_id: (integer) - グループID
            + name: (string) - グループ名
            + note: (string) - 備考
            + is_private: (boolean) - 非公開フラグ
            + group_image: (string) - グループ画像URL

    + Body

            {
                "page": 1,
                "per": 10,
                "groups": [
                    {
                        "group_id": 1,
                        "name": "IS-07",
                        "note": "ITスペシャリスト科 7期のグループ",
                        "is_private": false,
                        "group_image": "https://static.neec.ooo/hoehoge.png"

                    },
                    {
                        "group_id": 4,
                        "name": "IS-08",
                        "note": "ITスペシャリスト科 8期のグループ",
                        "is_private": true,
                        "group_image": "https://static.neec.ooo/fugafuga.jpg"
                    }
                ]
            }

##  Group [/groups/{group_id}]

### グループ詳細取得 [GET]

**Note**

* `public` && グループメンバ以外 => 403
* `private` && グループメンバ以外 => 404
* 対象グループが見つからない => 404

+ Parameters
    + group_id: 1 (number) - グループID

* Response 200 (application/json)
    + Body Attributes
        * groups: (array[group]) - グループ一覧
            + group_id: (number) - グループID
            + name: (string) - グループ名
            + note: (string) - 備考
            + is_private: (boolean) - 非公開フラグ
            + group_image: (string) - グループ画像URL
            + members: (array[user])

    + Body

            {
                "group_id": 1,
                "name": "IS-07",
                "note": "ITスペシャリスト科 7期のグループ",
                "is_private": false,
                "group_image": "https://static.neec.ooo/hoehoge.png",
                "members": [
                    {
                        "user_id": 1,
                        "name": "田中 太郎",
                        "number": "G099C0001",
                        "note": "こんにちわ",
                        "user_image": "https://static.neec.ooo/tanaka.png",
                        "college": {
                            "code": "c",
                            "name": "IT"
                        }
                    },
                    {
                        "user_id": 2,
                        "name": "山田 花子",
                        "number": "G099C0002",
                        "note": "はーい",
                        "user_image": "https://static.neec.ooo/yamada.png",
                        "college": {
                            "code": "c",
                            "name": "IT"
                        }
                    }
                ],
                "invitations": [
                    {
                        "user_id": 3,
                        "name": "ビル・ジョブズ",
                        "number": "G099C0004",
                        "note": "パソコンは友達",
                        "user_image": "https://static.neec.ooo/jobs.png",
                        "college": {
                            "code": "c",
                            "name": "IT"
                        }
                    }
                ]
            }

* Response 403
* Response 400

### グループ更新 [PATCH]

**Note**

* `public` && グループメンバ以外 => 403
* `invite` && グループメンバ以外 => 404
* 対象グループが見つからない => 404

* Parameters
    + group_id: 1 (number) - グループID

* Request (multipart/form-data)

    + Body Attributes
        * name: (string) - グループ名
        * note: (string) - 備考
        * is_private: (boolean) - 非公開フラグ
        * group_image: (string) - グループ画像URL

    + Body

            {
                "name": "IS-07_Systems",
                "note": "ISスペシャリスト科 システム専攻",
                "is_private": true,
                "group_image": グループ画像
            }

* Response 200 (application/json)

    + Body Attributes
        + group_id: (number) - グループID
        + name: (string) - グループ名
        + note: (string) - 備考
        + group_image: (string) - グループ画像URL

    + Body

            {
                    "group_id": 1,
                    "name": "IS-07_Systems",
                    "note": "ISスペシャリスト科 システム専攻",
                    "is_private": true,
                    "group_image": "https://static.neec.ooo/hoehoge.png",
            }

* Response 403
* Response 404

##  Group Join [/groups/{group_id}/join]

### グループ参加 [POST]

**Note**

* `public` => 204
* `private` && 招待されている => 204
* `private` && 招待さてれてない => 404
* ログイン中のユーザ is グループメンバ => 403
* 対象グループが見つからない => 404

* Parameters
    + group_id: 1 (number) - グループID


* Response 204
* Response 403
* Response 404

##  Group Left [/groups/{group_id}/left]

### グループ脱退 [POST]

**Note**

*  ログイン中のユーザ == グループメンバ => 204
* `public` && ログイン中のユーザ is グループメンバ以外 => 403
* `private` && ログイン中のユーザ is グループメンバ以外 => 404
* 対象グループが見つからない => 404

* Parameters
    + group_id: 1 (number) - グループID

* Response 204
* Response 403
* Response 404

##  Group Invite [/groups/{group_id}/invite]

### グループ招待 [POST]

**Note**

* 招待対象ユーザのいずれかが (招待済み || グループメンバ) => 403
* `public` && ログインユーザ is グループメンバ以外 => 403
* `private` && ログインユーザ is グループメンバ以外 => 404
* 対象グループが見つからない => 404

* Parameters
    + group_id: 1 (number) - グループID

* Request

    + Body Attributes
        * user_ids: (array[number]) - ユーザID配列

    + Body

            {
                "user_ids": [
                    1,
                    2
                ]
            }

* Response 204
* Response 403
* Response 404

##  Group Invitation Reject [/groups/{group_id}/reject]

### グループ招待拒否 [POST]

**Note**

* 招待を受けたユーザが招待を拒否する
* ログイン中のユーザ is グループメンバ => 403
* `public` && 招待を受けていない => 403
* `private` && 招待を受けていない => 404
* 対象グループが見つからない => 404

* Parameters
    + group_id: 1 (number) - グループID

* Response 204
* Response 403
* Response 404

##  Group Invitation Cancel [/groups/{group_id}/cencel]

### グループ招待キャンセル [POST]

**Note**

* グループメンバが招待を取り消す
* `public` && (グループメンバ以外) => 403
* `private` && (グループメンバ以外) => 404
* 招待を出していない => 403
* 対象グループが見つからない => 404

* Parameters
    + group_id: 1 (number) - グループID

* Request

    + Body Attributes
        * user_id: (array[number]) - ユーザID

    + Body

            {
                "user_id": 1
            }

* Response 204
* Response 403
* Response 404

##  Group Create Folder [/groups/{group_id}/folder]

### グループフォルダ作成 [PUT]

**Note**

* ログイン中のユーザがグループメンバかどうかのチェックをし、Cajaの `TOPフォルダ作成API` を呼ぶ
* すでにTOPフォルダが作成されている場合でも同じ扱いをする(重複は気にしない)
* `public` && グループメンバ以外 => 403
* `private` && グループメンバ以外 => 404
* 対象グループが見つからない => 404

* Parameters
    + group_id: 1 (number) - グループID

* Response 204
* Response 403
* Response 404

##  Internal Group [/internal/groups/{group_id}]

### グループメンバID取得+内部 [GET]

**Note**

* 内部向けAPI(認証の必要がない)
* 対象グループが見つからない => 404

* Parameters
    + group_id: 1 (number) - グループID

* Response 200 (application/json)
    + Body Attributes
        - member_ids: (array[number]) - グループメンバID一覧

    + Body

            {
                "member_ids": [
                    1,
                    2,
                ]
            }

* Response 400
