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

  jQuery("#transaction_paid_at_1i").select2()
  jQuery("#transaction_paid_at_2i").select2()
  jQuery("#transaction_paid_at_3i").select2()

  jQuery("#transaction_credit").change(update_credit_colour)

  update_credit_colour()

update_credit_colour = () ->
  if jQuery("#transaction_credit").val() == "true"
    jQuery("#transaction_credit").toggleClass("errorColour", false)
    jQuery("#transaction_credit").toggleClass("successColour", true)
  else
    jQuery("#transaction_credit").toggleClass("errorColour", true)
    jQuery("#transaction_credit").toggleClass("successColour", false)