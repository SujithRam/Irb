# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20161023030655) do

  create_table "irbs", force: :cascade do |t|
    t.integer  "user_id"
    t.text     "abstract"
    t.string   "proposalno"
    t.text     "status"
    t.text     "poputype"
    t.text     "responsibility"
    t.string   "apptype"
    t.string   "titleofproject"
    t.string   "acc1"
    t.string   "date1"
    t.string   "acc2"
    t.string   "date2"
    t.string   "acc3"
    t.string   "date3"
    t.string   "projtype"
    t.string   "fund"
    t.string   "fundingdetails"
    t.string   "datetobegindc"
    t.string   "statusofprininv"
    t.string   "typeofreview"
    t.string   "rationale"
    t.string   "noofsub"
    t.string   "assowithsub"
    t.string   "natureofassociation"
    t.string   "subjectselection"
    t.string   "ressubcomp"
    t.string   "adforresparti"
    t.string   "confidentiality"
    t.string   "voluntaryparticipation"
    t.string   "howwhereconsent"
    t.string   "methodproceduresubjectparti"
    t.string   "childrenpermission"
    t.string   "infowithheld"
    t.string   "risk"
    t.string   "riskbenefitratio"
    t.string   "minimizingrisk"
    t.string   "otherapptype"
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
    t.string   "faculty_status",              default: "0"
    t.string   "committee_status",            default: "2"
    t.string   "student_name"
    t.string   "faculty_name"
    t.string   "committee_name"
    t.index ["user_id", "created_at"], name: "index_irbs_on_user_id_and_created_at"
    t.index ["user_id"], name: "index_irbs_on_user_id"
  end

  create_table "messages", force: :cascade do |t|
    t.text     "msg"
    t.integer  "user_id"
    t.string   "irbappid"
    t.string   "receiverid"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id", "created_at"], name: "index_messages_on_user_id_and_created_at"
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.string   "ulid"
    t.string   "password_digest"
    t.boolean  "admin",           default: false
    t.boolean  "faculty",         default: false
    t.boolean  "committee",       default: false
    t.datetime "lastlogin"
  end

end
