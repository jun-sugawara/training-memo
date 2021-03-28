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
| training_weight | integer    | null: false       |
| reps            | integer    | null: false       |
| set             | integer    | null: false       |
| user            | references | foreign_key: true |


### Association

- belongs_to :user

## Body_recordsテーブル

| Column           | Type       | Options           |
| ---------------- | ---------- | ----------------- |
| date             | date       | null: false       |
| body_weight      | integer    | null: false       |
| fat              | integer    | null: false       |
| todays_condition | integer    |                   |
| user             | references | foreign_key: true |

### Association

- belongs_to :user