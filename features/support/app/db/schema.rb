# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20091103193154) do

  create_table "chards", :force => true do |t|
    t.string   "name"
    t.integer  "terrace_id", :null => false
    t.integer  "weight"
    t.string   "variety"
    t.integer  "length"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "crops", :force => true do |t|
    t.string   "name"
    t.string   "season"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "fertilizers", :force => true do |t|
    t.string   "name"
    t.integer  "price"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "lettuces", :force => true do |t|
    t.string   "name"
    t.integer  "orchard_of_birth_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "orchards", :force => true do |t|
    t.string   "name"
    t.date     "since"
    t.integer  "area"
    t.string   "longitude"
    t.string   "latitude"
    t.time     "start_watering"
    t.time     "stop_watering"
    t.integer  "fertilizer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "cultivated"
  end

  create_table "pepinos", :force => true do |t|
    t.integer  "terrace_id", :null => false
    t.integer  "weight"
    t.string   "variety"
    t.integer  "diameter"
    t.integer  "length"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title"
  end

  create_table "sprinklers", :force => true do |t|
    t.string   "name"
    t.integer  "flow"
    t.string   "flow_units"
    t.integer  "sprinklerable_id"
    t.string   "sprinklerable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "terraces", :force => true do |t|
    t.string   "name"
    t.integer  "orchard_id"
    t.integer  "crop_id"
    t.integer  "length"
    t.integer  "plants"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tomatoes", :force => true do |t|
    t.string   "name"
    t.integer  "terrace_id", :null => false
    t.integer  "weight"
    t.string   "variety"
    t.integer  "diameter"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
