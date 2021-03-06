class SpareUniform < ActiveRecord::Base
  attr_accessible :number, :size, :sex

  validates(:sex, {
      presence: true,
      format: {with: VALID_SEX_REGEX_PLAYER}
    }
  )

  def sex_string
    case sex
    when SEX_MALE
      return "Male"
    when SEX_FEMALE
      return "Female"
    end

    return nil
  end

  def self.with_sex(p_sex)
    unless p_sex.blank?
      where("spare_uniforms.sex = ?", p_sex)
    else
      scoped
    end
  end
end
