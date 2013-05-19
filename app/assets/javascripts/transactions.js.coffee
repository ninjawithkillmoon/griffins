# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->
  jQuery("#transaction_category_id").select2()

  jQuery("#transaction_invoice_id").select2(
    placeholder: "Select an Invoice",
    allowClear: true
  )
  
  jQuery("#transaction_method").select2()