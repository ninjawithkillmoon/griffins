# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->
  jQuery("#division_season_id").select2()
  
  jQuery("#division_sex").select2()
  
  jQuery("#season_id").select2(
    placeholder: "Select a Season",
    allowClear: true
  )

  jQuery("#sex").select2(
    placeholder: "Select a Sex",
    allowClear: true
  )