onPageReady( function() {

  $('.js-export-csv').on('click', function() {
    var url = $(this).data('patentUrl');
    var newPath = "/patents.csv?url=" + encodeURI(url);
    location.href = newPath
  });

  function processFile(link, cb) {
    $.ajax({
      url: link
    }).success(function(data){
      cb(null, link)
    }).error(function(data) {
      cb("Failed to process")
    })
  }
  
  if (typeof queue == 'undefined') {
    console.log("Queue is not available on this page")
    return;
  }
  var q = queue(1)
  $('.unprocessed').each(function() {
    var row = $(this).closest('tr');
    var link = row.find(".scrape a").attr('href')
    if (link)
      q.defer(processFile, link)
  })
  q.awaitAll(function(error, results) {
    console.log('done', error, results)
  });

  
});
             
