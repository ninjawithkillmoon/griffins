# Ripped shamelessly from https://github.com/railscasts/396-importing-csv-and-excel
class PlayerImport
  # switch to ActiveModel::Model in Rails 4
  extend ActiveModel::Naming
  include ActiveModel::Conversion
  include ActiveModel::Validations

  attr_accessor :file

  def initialize(attributes = {})
    unless attributes.nil?
      attributes.each { |name, value| send("#{name}=", value) }
    end
  end

  def persisted?
    false
  end

  def save
    unless imported_players.nil?
      # if they're all valid, then save them all
      if imported_players.map { |imported_player| imported_player.valid?}.all?
        imported_players.each { |imported_player| imported_player.save!}
        return true
      else
        imported_players.each_with_index do |player, index|
          player.errors.full_messages.each do |message|
            errors.add :base, "Row #{index+2}: #{message}"
          end
        end
        return false
      end
    end
  end

  def imported_players
    @imported_players ||= load_imported_players
  end

  def load_imported_players
    spreadsheet = open_spreadsheet

    unless spreadsheet.nil?
      header = spreadsheet.row(1)
      (2..spreadsheet.last_row).map do |i|
        row = Hash[[header, spreadsheet.row(i)].transpose]
        player = Player.find_by_id(row["id"]) || Player.new
        player.attributes = row.to_hash.slice(*Player.accessible_attributes)
        player
      end
    end
  end

  def open_spreadsheet
    unless file.nil?
      case File.extname(file.original_filename)
      when ".csv" then Roo::Csv.new(file.path, nil, :ignore)
      when ".xls" then Roo::Excel.new(file.path, nil, :ignore)
      when ".xlsx" then Roo::Excelx.new(file.path, nil, :ignore)
      else
        errors.add :base, "Unknown file type: #{file.original_filename}"
        return nil
      end
    else
      errors.add :base, "No file uploaded"
      return nil
    end
  end
end