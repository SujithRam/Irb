class Irb < ApplicationRecord
  belongs_to :user
  default_scope -> { order(created_at: :desc) } #will display the newest application first(orders the users application in the descending order of their creation) for display
  validates :user_id, presence: true
  serialize :status, Hash
  serialize :responsibility, Hash
  serialize :poputype, Hash
  
  validates_acceptance_of :acc, message: "You must sign the form by Checking the Checkbox."
  
  validates :titleofproject, presence: true, length: { maximum: 50 }
  validates :datetobegindc, presence: true
  validates :rationale, presence: true
  validates :abstract, presence: true
  validates :noofsub, presence: true, numericality: true
  validates_length_of :natureofassociation, :minimum => 1, :allow_blank => true 
  validates :subjectselection, presence: true
  validates :confidentiality, presence: true
  validates_length_of :howwhereconsent, :minimum => 1, :allow_blank => true
  validates_length_of :methodproceduresubjectparti, :minimum => 1, :allow_blank => true
  validates_length_of :childrenpermission, :minimum => 1, :allow_blank => true
  validates_length_of :infowithheld, :minimum => 1, :allow_blank => true
  validates_length_of :riskbenefitratio, :minimum => 1, :allow_blank => true
  validates_length_of :minimizingrisk, :minimum => 1, :allow_blank => true
end
