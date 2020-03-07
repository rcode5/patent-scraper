onPageReady( function() {

  $('.js-export-all-csv, .js-export-csv').on('click', function() {
    var url = location.pathname + ".csv"
    location.href = url;
  });


  function linkForProcessed(data) {
    return $("<a>", {href: data.show_path, title: "View"}).html($('<ion-icon name="checkmark-outline" />'))
  }
  
  function setRowProcessed(data, row) {
    var anchor = linkForProcessed(data)
    $(row).find('.js-processing-link').remove();
    $(row).find('a[title="Process"]').after(anchor).remove();
    $(row).find('.title').removeClass('unprocessed').html(data.title)
    $(row).find('.patent-number').html(data.patent_number);
    $(row).removeClass('processing');
  }

  function setRowProcessing(row) {
    $(row).addClass('processing');
  }

  function setRowError(data, row) {
    $(row).addClass('error').removeClass('processing');
    $(row).find('.title').removeClass('unprocessed').html('Failed to process...')
  }
  
  function processFile(link, row, cb) {
    setRowProcessing(row);
    $.ajax({
      url: link,
      method: "POST"
    }).success(function(data){
      setRowProcessed(data, row)
      cb(null, link)
    }).error(function(data) {
      setRowError(data, row)
      cb("Failed to process")
    })
  }
  
  if (typeof queue == 'undefined') {
    console.log("Queue is not available on this page")
    return;
  }

  $(".js-start-scraping").on('click', function() {
    console.log("Start")
    var q = queue(1)
    $(".js-processing-link").each(function() {
      var row = $(this).closest('tr');
      var link = $(this).data('link');
      if (link)
        q.defer(processFile, link, row)
    });
    q.awaitAll(function(error, results) {
      console.log('done', error, results)
    });
  });
  
});
             
