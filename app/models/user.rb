class User < ApplicationRecord
    has_secure_password
  
    #associations
    has_many :blog_posts, foreign_key: :author_id, dependent: :destroy
    has_many :comments, dependent: :destroy
    has_many :courses, foreign_key: :author_id, dependent: :destroy
    has_many :recipes, foreign_key: :author_id, dependent: :destroy
    has_many :course_progresses, dependent: :destroy
    has_many :lesson_completions, dependent: :destroy
    has_one :subscription, dependent: :destroy
    has_many :purchases, dependent: :destroy
  
    #validations
    #make sure username present, unique and between 3 and 20 characters in length
    validates :username, presence: true, uniqueness: true, length: { minimum: 3, maximum: 20 }
    #make sure email present, unique, in valid format
    validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
    #password min 6 chars, only validate if pw preseent (if not present then don't check)
    validates :password, length: { minimum: 6 }, allow_nil: true
    #require password confirmation only if password is being set
    validates :password_confirmation, presence: true, if: -> { password.present? }

    #scopes
    #defining a scope called "active" to find users who are active (active: true)
    scope :active, -> { where(active: true) }

    #methods
    #mark the user as inactive instead of hard deleting them from the database
    def soft_delete
      update(active: false)
    end

    #return true if user has been soft-deleted
    def deleted?
      !active
    end

    #return true if user is admin 
    def admin?
      self.admin
    end

  end
  
