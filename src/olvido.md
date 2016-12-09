## Group Secret Q & A API

## Questions Collection [/questions]

* Request

    * 全てのリクエスト ヘッダーにアクセストークンを付加する必要がある

    * Headers Attributes
        - Authorization (string, required) - アクセストークン

    * Headers

            Authorization: Bearer eyJhbGciOiJIUzI1NiIsI6IkpXVCJ9.eyJleHAi...

###  ログイン中ユーザの秘密の質問一覧取得 [GET]

* Response 200 (application/json)

    * Body Attributes
        * questions: (array) - 質問一覧
          - id: (number) - 質問ID
          - message: (string) - 質問内容

    * Body

            {
                "questions": [
                    {
                        "id": 1,
                        "message": "好きな食べ物は？"
                    },
                    {
                        "id": 2,
                        "message": "出身校は？"
                    }
                ]
            }

### 秘密の質問・答え作成 [POST]

**Note**
* 未入力(or 空文字)の項目がある => 422

* Request (application/x-www-form-urlencoded)

    * Body Attributes
        * message: (string, required) - 質問内容
        * answer: (string, required) - 回答

    * Body

            {
                "message": "ペットの名前は？",
                "answer": "タマ"
            }

* Response 201 (application/json)

    * Body Attributes
        * id: 1 (number) - 質問ID
        * message: ペットの名前は？ (string) - 質問内容

    * Body

            {
                "id": 1,
                "message": "ペットの名前は？"
            }

* Response 422

## Question [/questions/{question_id}]

###  秘密の質問・答え更新 [PATCH]

**Note**
* 自分の質問ではない => 403
* 該当の質問がない => 404
* message = 空文字 => 422

* Parameters
    * question_id: 1 (number) - 質問ID

* Request (application/x-www-form-urlencoded)

    * Body Attributes
        * message: (string, required) - 質問内容
        * answer: (string, required) - 質問内容

    * Body

            {
                "message": "ペットの名前は？",
                "answer": "タマ"
            }

* Response 204
* Response 403
* Response 404
* Response 422

### 秘密の質問・答え削除 [DELETE]

**Note**
* 自分の質問ではない => 403
* 該当の質問がない => 404

* Parameters
    * question_id: 1 (number) - 質問ID

* Response 204
* Response 403
* Response 404

## Internal Random Question [/internal/questions{?user_id}]

### 指定ユーザの秘密の質問ランダム取得 [GET]

**Note**
* 内部向けAPI(認証の必要がない)
* cuentaが呼ぶ

* Parameters
    * user_id: 1 (number) - ユーザID

* Response 200 (application/json)

    * Body Attributes
        * id: (number) - 質問ID
        * message: (string) - 質問内容

    * Body

            {
                "id": 1,
                "message": "好きな食べ物は？"
            }

## Internal Check Question [/internal/questions/{question_id}]

### 回答確認-内部 [POST]

**Note**
* 内部向けAPI(認証の必要がない)
* cuentaが呼ぶ
* 正答 => 200
* 誤答 => 400
* 対象の質問がない => 404

* Parameters
    * question_id: 1 (number) - 質問ID

* Request (application/x-www-form-urlencoded)

    * Body Attributes
        * answer: タマ (string, required) - 回答

    * Body

            {
                "answer": "タマ"
            }

* Response 200
* Response 400
* Response 404
