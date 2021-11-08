class Post < ApplicationRecord
    include PgSearch
    pg_search_scope :search_by_title_and_content, :against => [:title, :content],
      using: {
        :tsearch => {:prefix => true}
      }
end
