$(function() {
  var $input      = $('#js-query-field'),
      $output     = $('#js-query-output'),
      $queryForm  = $('#js-query-form'),
      $settings   = $('#js-api-settings .col-md-2');

  // TODO
  if ($('#token').val().trim() !== '') {
    $settings.hide();
  }

  function toggleSubmit() {
    var $submitBtn = $('#js-run-btn');

    if ($submitBtn.attr('disabled') === 'disabled') {
      $submitBtn.removeAttr('disabled');
    } else {
      $submitBtn.attr('disabled', 'disabled');
    }
  }

  $('kbd').attr('title', 'Click to execute this query');

  $('kbd').click(function() {
    $input.val($(this).text());
    $queryForm.submit();
  });

  $('#js-clear-btn').click(function(e) {
    e.preventDefault();
    $output.html('<div><span class="point">gitlab&gt;</span></div>');
  });

  $('#js-api-settings a').click(function(e) {
    e.preventDefault();
    $settings.slideToggle(300);
  });

  $queryForm.submit(function(e) {
    e.preventDefault();
    NProgress.start();
    toggleSubmit();

    if ($input.val().trim() === "") {
      $input.val('');
      return;
    }

    $.post('/query', $(this).serialize(), function(data) {
      NProgress.done();
      $('.text-danger').remove();
      toggleSubmit();
      var htmlOutput = '<div><span class="point">gitlab&gt;</span> ' + data.query + '</div><div>' + data.output + '</div>';
      $output.append(htmlOutput);
      $output.stop().animate({ scrollTop: $output[0].scrollHeight }, 700);
      $input.val('');
    }).fail(function() {
      NProgress.done();
      toggleSubmit();
      $queryForm.find('.col-md-10').append('<p class="text-danger">Query execution failed</p>');
    });
  });
});
