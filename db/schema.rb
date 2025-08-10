# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2025_06_19_024402) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "blog_posts", force: :cascade do |t|
    t.string "title"
    t.text "body"
    t.integer "author_id"
    t.string "image_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["title"], name: "index_blog_posts_on_title", unique: true
  end

  create_table "blog_posts_tags", id: false, force: :cascade do |t|
    t.bigint "blog_post_id", null: false
    t.bigint "tag_id", null: false
    t.index ["blog_post_id", "tag_id"], name: "index_blog_posts_tags_on_blog_post_id_and_tag_id"
    t.index ["tag_id", "blog_post_id"], name: "index_blog_posts_tags_on_tag_id_and_blog_post_id"
  end

  create_table "comments", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "commentable_type", null: false
    t.bigint "commentable_id", null: false
    t.text "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["commentable_type", "commentable_id"], name: "index_comments_on_commentable"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "course_categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "course_progresses", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "course_id", null: false
    t.bigint "current_lesson_id"
    t.datetime "last_accessed_at"
    t.boolean "completed"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_course_progresses_on_course_id"
    t.index ["current_lesson_id"], name: "index_course_progresses_on_current_lesson_id"
    t.index ["user_id"], name: "index_course_progresses_on_user_id"
  end

  create_table "courses", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.bigint "author_id", null: false
    t.string "image_url"
    t.bigint "category_id", null: false
    t.boolean "requires_purchase", default: true, null: false
    t.decimal "price", precision: 8, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_id"], name: "index_courses_on_author_id"
    t.index ["category_id"], name: "index_courses_on_category_id"
  end

  create_table "lesson_completions", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "lesson_id", null: false
    t.datetime "completed_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["lesson_id"], name: "index_lesson_completions_on_lesson_id"
    t.index ["user_id"], name: "index_lesson_completions_on_user_id"
  end

  create_table "lessons", force: :cascade do |t|
    t.bigint "course_id", null: false
    t.string "title"
    t.string "video_url"
    t.text "content_body"
    t.integer "lesson_order"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_lessons_on_course_id"
  end

  create_table "plants", force: :cascade do |t|
    t.string "common_name"
    t.string "scientific_name"
    t.string "family"
    t.text "description"
    t.text "growing_harvesting"
    t.string "photo_url"
    t.text "parts_used"
    t.text "physiological_actions"
    t.text "energetics"
    t.text "ways_to_use"
    t.text "uses"
    t.text "cautions"
    t.text "history"
    t.text "magical"
    t.boolean "is_sample", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "plants_recipes", id: false, force: :cascade do |t|
    t.bigint "plant_id", null: false
    t.bigint "recipe_id", null: false
    t.index ["plant_id", "recipe_id"], name: "index_plants_recipes_on_plant_id_and_recipe_id"
    t.index ["recipe_id", "plant_id"], name: "index_plants_recipes_on_recipe_id_and_plant_id"
  end

  create_table "purchases", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "course_id", null: false
    t.decimal "price_paid", precision: 8, scale: 2
    t.datetime "purchased_at"
    t.string "payment_provider"
    t.string "provider_transaction_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_purchases_on_course_id"
    t.index ["user_id"], name: "index_purchases_on_user_id"
  end

  create_table "recipes", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.text "ingredients"
    t.text "instructions"
    t.string "image_url"
    t.integer "author_id"
    t.boolean "is_remedy"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "recipes_tags", id: false, force: :cascade do |t|
    t.bigint "recipe_id", null: false
    t.bigint "tag_id", null: false
    t.index ["recipe_id", "tag_id"], name: "index_recipes_tags_on_recipe_id_and_tag_id"
    t.index ["tag_id", "recipe_id"], name: "index_recipes_tags_on_tag_id_and_recipe_id"
  end

  create_table "subscriptions", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "status"
    t.datetime "started_at"
    t.datetime "expires_at"
    t.string "payment_provider"
    t.string "provider_subscription_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_subscriptions_on_user_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "admin", default: false, null: false
    t.boolean "active", default: true, null: false
  end

  add_foreign_key "comments", "users"
  add_foreign_key "course_progresses", "courses"
  add_foreign_key "course_progresses", "lessons", column: "current_lesson_id"
  add_foreign_key "course_progresses", "users"
  add_foreign_key "courses", "course_categories", column: "category_id"
  add_foreign_key "courses", "users", column: "author_id"
  add_foreign_key "lesson_completions", "lessons"
  add_foreign_key "lesson_completions", "users"
  add_foreign_key "lessons", "courses"
  add_foreign_key "purchases", "courses"
  add_foreign_key "purchases", "users"
  add_foreign_key "subscriptions", "users"
end
