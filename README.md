## usersテーブル

| Column             | Type     | Options                   |
| ------------------ | -------- | ------------------------- |
| nickname           | string   | null: false               |
| email              | string   | null: false, unique: true |
| encrypted_password | string   | null: false               |
| age                | integer  | null: false               |
| gender             | integer  | null: false               |

### Association

- has_many :training_records
- has_many :body_records


## Training_recordsテーブル

| Column          | Type       | Options           |
| --------------- | ---------- | ----------------- |
| date            | date       | null: false       |
| training_event  | integer    | null: false       |
| training_weight | float      | null: false       |
| reps            | integer    | null: false       |
| set             | integer    | null: false       |
| user            | references | foreign_key: true |


### Association

- belongs_to :user
- has_many :training_genres

## Body_recordsテーブル

| Column           | Type       | Options           |
| ---------------- | ---------- | ----------------- |
| date             | date       | null: false       |
| body_weight      | float      | null: false       |
| fat              | float      | null: false       |
| todays_condition | string     |                   |
| user             | references | foreign_key: true |

### Association

- belongs_to :user

## Training_genresテーブル

| Column           | Type       | Options           |
| ---------------- | ---------- | ----------------- |
| part             | string     | null: false       |
| event            | string     | null: false       |

### Association

- belongs_to :training_record