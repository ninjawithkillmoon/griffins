# == Schema Information
#
# Table name: players
#
#  id             :integer          not null, primary key
#  name_family    :string(255)
#  name_given     :string(255)
#  student_number :integer
#  email          :string(255)
#  date_of_birth  :date
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  sex            :integer
#  number         :integer
#

class Player < ActiveRecord::Base
  attr_accessible :date_of_birth, :email, :sex, :name_family, :name_given, :student_number, :student_ceased, :active_ceased, :number, :team_ids

  has_and_belongs_to_many :teams
  has_many :invoices

  before_save { |player| player.email = email.downcase unless player.email.nil? }

  validates(:name_family, {
      presence: true,
      length: {maximum: 50}
    }
  )

  validates(:name_given, {
      presence: true,
      length: {maximum: 50}
    }
  )

  validates(:email, {
      format: {with: VALID_EMAIL_REGEX},
      uniqueness: {case_sensitive: false},
      allow_blank: true
    }
  )

  validates(:sex, {
      presence: true,
      format: {with: VALID_SEX_REGEX_PLAYER}
    }
  )

  validates(:active_ceased, {
      inclusion: {in: [true, false]},
      presence: true
    }
  )

  def full_name
    return name_given + " " + name_family
  end

  def sex_string
    case sex
    when SEX_MALE
      return "Male"
    when SEX_FEMALE
      return "Female"
    end

    return nil
  end

  def male?
    if sex == SEX_MALE
      return true
    end

    return false
  end

  def female?
    if sex == SEX_FEMALE
      return true
    end

    return false
  end

  def active?
    if active_ceased
      return false
    else
      return true
    end
  end

  # Returns the player's student number when student_ceased is false, empty string otherwise.
  #
  # * *Args*    :
  #   - ++ -> 
  # * *Returns* :
  #   - 
  #
  def student_number_if_student
    unless student_ceased
      return student_number
    end

    return ""
  end

  def student?
    return !student_number_if_student.blank?
  end

  def self.played_in_season(p_season_id)
    unless p_season_id.blank?
      joins(teams: :season).where("season_id = ?", p_season_id)
    else
      scoped
    end
  end

  def self.with_name_like(p_name)
    unless p_name.blank?
      where("name_family like '%?%' OR name_given like '%?%'", p_name, p_name)
    else
      scoped
    end
  end

  def self.active(p_active)


    if p_active.blank?
      scoped
    elsif ActiveRecord::ConnectionAdapters::Column.value_to_boolean(p_active)
      where("active_ceased != ?", true)
    else
      where("active_ceased = ?", true)
    end
  end

  def self.with_sex(p_sex)
    unless p_sex.blank?
      where("sex = ?", p_sex)
    else
      scoped
    end
  end
end
