class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :timeoutable

  #validations
  validates :full_name, presence: true

  #associations
  has_and_belongs_to_many :roles, uniq: true
  has_many :permissions, through: :roles

  def super_admin?
    roles.include?(Role.super_admin)
  end

  def assign_role(role)
    roles.push(role) unless roles.include? role
  end

  def unassign_role(role)
    roles.delete(role)
  end

end
