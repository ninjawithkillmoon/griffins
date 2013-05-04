# == Schema Information
#
# Table name: teams
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  division_id :integer
#

class Team < ActiveRecord::Base
  attr_accessible :name, :division_id, :player_ids

  has_and_belongs_to_many :players
  belongs_to :division

  after_commit do |team|
    team.players.each do |player|

      invoice = nil
      unless team.division.nil? || team.division.season.nil?
        invoice = Invoice.where({player_id: player.id, season_id: team.division.season.id}).first

        cost = team.division.season.cost
        unless player.student_number.blank?
          cost = team.division.season.cost_student
        end

        notes = "Automatically generated invoice for #{team.division.season.name}"

        if invoice.nil?
          invoice = Invoice.new(player_id: player.id, season_id: team.division.season.id, amount: cost, notes: notes)
          invoice.save!
        end
      end
    end
  end

  validates(:name, {
      presence: true,
      length: {maximum: 50}
    }
  )
end
