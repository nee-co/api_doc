## Group Image API

##  Internal Imagen [/internal/image]

### 画像アップロード-内部 [POST]

**Note**
* 内部向けAPI(認証の必要がない)
* old_image_pathが設定されている場合は、その画像を削除する
* 許可拡張子(jpeg, jpg, png, gif)以外の場合 => 422

* Request (multipart/form-data)

    + Body Attributes
        * image: (file, required) - アップロード対象画像
        * old_image_path: `/hoghoge.png` (string, optional) - 削除対象画像パス

    + Body

            {
                "image": アップロード画像,
                "old_image_path": "/hogehoge.png"
            }

* Response 201 (application/json)

    + Body Attributes
        * image_path: (string) - アップロード画像保存Path

    + Body

            {
                "image_path": "/fugafuga.png"
            }

* Response 422
