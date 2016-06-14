## Group User API

## User List [/users/list{?user_ids}]
### ユーザリスト取得 [GET]

**Use Case**
- イベント管理システム>参加者一覧+コメント投稿者一覧

+ Parameters
    + user_ids: `1+2+3` (array[string]) - 取得対象ユーザID一覧

+ Response 200 (application/json)

        {
            "user_id": 1,
            "number": "G099C1001",
            "name": "田中 太郎",
            "user_image": "user/sample1.jpg",
            "college": "it"
        },
        {
            "user_id": 2,
            "number": "G099C1002",
            "name": "山本 二郎",
            "user_image": "user/sample2.jpg",
            "college": "it"
        },
        {
            "user_id": 3,
            "number": "G099C1003",
            "name": "山田 花子 ",
            "user_image": "user/sample3.jpg",
            "college": "design"
        }

## User Search [/users/search{?name,target_ids}]
### ユーザLIKE検索 [GET]

**Use Case**
- ファイル管理システム>公開対象追加

+ Parameters
    + name: `田` (string) - 氏名
    + target_ids: `1+2+3` (array[string], optional) - 検索対象ユーザID一覧

+ Response 200 (application/json)

        {
            "user_id": 1,
            "number": "G099C1001",
            "name": "田中 太郎",
            "user_image": "user/sample1.jpg",
            "college": "it"
        },
        {
            "user_id": 3,
            "number": "G099C1003",
            "name": "山田 花子 ",
            "user_image": "user/sample3.jpg",
            "college": "design"
        }
