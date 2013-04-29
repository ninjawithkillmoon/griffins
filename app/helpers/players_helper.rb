module PlayersHelper
  def full_name(p_player)
    return p_player.name_given + " " + p_player.name_family
  end
end
