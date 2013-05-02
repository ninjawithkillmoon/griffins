# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->
  jQuery("#team_division_id").select2()
  jQuery("#team_player_ids").select2(
    placeholder: "No players selected"
  )