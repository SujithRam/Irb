class CreateIrbs < ActiveRecord::Migration[5.0]
  def change
    create_table :irbs do |t|
      t.references :user, foreign_key: true
      t.text :abstract
      t.string :proposalno
      t.text   :status
      t.text   :poputype
      t.text   :responsibility
      t.string :apptype
      t.string :titleofproject
      t.string :acc1
      t.string :date1
      t.string :acc2
      t.string :date2
      t.string :acc3
      t.string :date3
      t.string :projtype
      t.string :fund
      t.string :fundingdetails
      t.string :datetobegindc
      t.string :statusofprininv
      t.string :typeofreview
      t.string :rationale
      t.string :noofsub
      t.string :assowithsub
      t.string :natureofassociation
      t.string :subjectselection
      t.string :ressubcomp
      t.string :adforresparti
      t.string :confidentiality
      t.string :voluntaryparticipation
      t.string :howwhereconsent
      t.string :methodproceduresubjectparti
      t.string :childrenpermission
      t.string :infowithheld
      t.string :risk
      t.string :riskbenefitratio
      t.string :minimizingrisk
      t.string :otherapptype
      t.timestamps
    end
    add_index :irbs, [:user_id, :created_at]
  end
end
