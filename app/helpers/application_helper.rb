module ApplicationHelper

  # Returns the full title for a page - eliminating the '|' if not required.
  #
  # Base title comes from Settings.title
  #
  # * *Args*    :
  #   - +p_titlePage+ -> The individual page's title.
  # * *Returns* :
  #   - The page title (if it exists) with the site base title appended to it. Separated by pipe character.
  #
  def fullTitle(p_titlePage)
    titleBase = Settings.title

    if(p_titlePage.empty?)
      return titleBase
    else
      return "#{p_titlePage} | #{titleBase}"
    end
  end

  # Calculates and returns the number of full years since p_date.
  #
  # Stolen from: http://stackoverflow.com/questions/819263/get-persons-age-in-ruby.
  #
  # * *Args*    :
  #   - +p_date+ -> The date to start counting from.
  # * *Returns* :
  #   - The number of full years since p_date.
  #
  def age(p_date)
    unless p_date.nil?
      now = Time.now.utc.to_date
      return now.year - p_date.year - ((now.month > p_date.month || (now.month == p_date.month && now.day >= p_date.day)) ? 0 : 1)
    end
  end

  # Returns a full text representation of the integer parameter as a sex type.
  #
  # Sex types are found in /config/initializers/constants.rb.
  #
  # * *Args*    :
  #   - ++ -> 
  # * *Returns* :
  #   - 
  #
  def sex_string(p_sex)
    case p_sex
    when SEX_MALE
      return "Male"
    when SEX_FEMALE
      return "Female"
    when SEX_MIXED
      return "Mixed"
    end
  end

  def dtdd(p_dt, p_dd)
    return render 'layouts/components/dt_dd', dt: (p_dt.blank? ? raw("&nbsp;") : p_dt), dd: (p_dd.blank? ? raw("&nbsp;") : p_dd)
  end

  def active_tab?(p_id)
    unless params.nil?
      if params[:active] == p_id
        return true
      end
    end

    return false
  end

  def active_tab_default?(p_id)
    if params[:active].nil?
      return true
    else
      return active_tab?(p_id)
    end
  end

end
