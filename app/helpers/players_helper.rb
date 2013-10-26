module PlayersHelper
  def full_name(p_player)
    return p_player.name_given + " " + p_player.name_family
  end

  def sex_types_player
    {"Male" => SEX_MALE, "Female" => SEX_FEMALE}
  end
end
