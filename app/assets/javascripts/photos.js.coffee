# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ->
  $('#photo_uploaded_file').attr('name','upload[photo]')
  $('#new_photo').fileupload
    dataType: 'script'
    add: (e, data) ->
      types = /(\.|\/)(gif|jpe?g|png|mov|mpeg|mpeg4|avi)$/i
      file = data.files[0]
      if types.test(file.type) || types.test(file.name)
        data.context = $(tmpl("template-upload", file))
        $('#new_uploaded_box').append(data.context)
        $('.actions input[type="submit"]').click (e) ->
          $('body').prepend('<div id="waiting" class="blink_c" style="color: #FFFFFF"><h1>uploading...</h1></div>')
          data.submit()
          e.preventDefault()
      else
        alert("#{file.name} is not a gif, jpg or png image file")
    progress: (e, data) ->
      if data.context
        progress = parseInt(data.loaded / data.total * 100, 10)
        data.context.find('.bar').css('width', progress + '%')
    done: (e, data) ->
      $('#waiting').remove();
      $('#new_uploaded_box').html("")


