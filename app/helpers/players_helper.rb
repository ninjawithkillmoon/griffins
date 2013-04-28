module PlayersHelper
  def full_name(p_player)
    return p_player.name_given + " " + p_player.name_family
  end

  def sex_string(p_player)
    case p_player.sex
    when SEX_MALE
      return "Male"
    when SEX_FEMALE
      return "Female"
    end
  end
end
