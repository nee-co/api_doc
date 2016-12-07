## Group Image API

**Note**
* 内部向けAPI(認証の必要がない)
* 許可拡張子(jpeg, jpg, png, gif)以外の場合 -> 422
* 許可フォーマット('image/png', 'image/jpeg', 'image/gif')以外の場合 -> 422
* イメージのサイズが設定した許容サイズを超えた場合 -> 413
* ファイル名はUUIDに変更される。
* `PUT /internal/images/<image_name>` で `image_name` がUUID形式かは判別しない。
* イメージはすべてPNGに変換される。

##  images [/internal/images]

### Upload Image - Internal [POST]

* Request (multipart/form-data)

    + Body Attributes
        * image: (file, required) - アップロード対象画像

    + Body

            {
                "image": アップロード画像
            }

* Response 201 (application/json)

    + Body Attributes
        * image_name: (string) - Image file name

    + Body

            {
                "image_name": "ce8a61c3-9ab0-4d7c-b38b-667273fe44f8.png"
            }

* Response 400 (application/json)

    + Body Attributes
        * message: (string) - Error Message

    + Body

            {
                "message": "Invalid URL extension"
            }

* Response 413 (application/json)

    + Body Attributes
        * message: (string) - Error Message

    + Body

            {
                "message": "The data value transmitted exceeds the capacity limit."
            }

* Response 422 (application/json)

    + Body Attributes
        * message: (string) - Error Message

    + Body

            {
                "message": "Invalid Image"
            }

##  image [/internal/images/{image_name}]

### Overwrite Image - Internal [PUT]

* Parameters
    + image_name: `ce8a61c3-9ab0-4d7c-b38b-667273fe44f8.png` (string, required) - Image file name

* Request (multipart/form-data)

    + Body Attributes
        * image: (file, required) - アップロード対象画像

    + Body

            {
                "image": アップロード画像
            }

* Response 201 (application/json)

    + Body Attributes
        * image_name: (string) - Image file name

    + Body

            {
                "image_name": "ce8a61c3-9ab0-4d7c-b38b-667273fe44f8.png"
            }

* Response 400 (application/json)

    + Body Attributes
        * message: (string) - Error Message

    + Body

            {
                "message": "Invalid URL extension"
            }

* Response 413 (application/json)

    + Body Attributes
        * message: (string) - Error Message

    + Body

            {
                "message": "The data value transmitted exceeds the capacity limit."
            }

* Response 422 (application/json)

    + Body Attributes
        * message: (string) - Error Message

    + Body

            {
                "message": "Invalid Image"
            }

### Delete Image - Internal [DELETE]

* Parameters
    + image_name: `ce8a61c3-9ab0-4d7c-b38b-667273fe44f8.png` (string, required) - Image file name

* Response 204

