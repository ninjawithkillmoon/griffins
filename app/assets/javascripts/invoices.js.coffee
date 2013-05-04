# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->
  jQuery("#invoice_player_id").select2()

  jQuery("#season_id").select2(
    placeholder: "Select a Season",
    allowClear: true
  )

  jQuery("#player_id").select2(
    placeholder: "Select a Player",
    allowClear: true
  )

  jQuery("#status").select2(
    placeholder: "Select a Status",
    allowClear: true
  )