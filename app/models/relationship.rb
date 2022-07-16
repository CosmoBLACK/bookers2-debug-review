class Relationship < ApplicationRecord
  belongs_to :follower, class_name: "User" # モデル名を指定し、usersテーブルを参照する
  belongs_to :followed, class_name: "User" # モデル名を指定し、usersテーブルを参照する
end