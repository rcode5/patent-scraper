onPageReady( function() {

  $('.js-export-csv').on('click', function() {
    var url = $(this).data('patentUrl');
    var newPath = "/patents.csv?url=" + encodeURI(url);
    location.href = newPath
  });

  function processFile(link, row, cb) {
    $.ajax({
      url: link,
      method: "POST"
    }).success(function(data){
      console.log("Success", data);
      // replace .processing-link with link to /patents/{data.patent.id]
      // ion-iso-checkmark-outline
      // replace title and patent number
      // cb(null, link)
    }).error(function(data) {
      console.log(row)
      cb("Failed to process")
    })
  }
  
  if (typeof queue == 'undefined') {
    console.log("Queue is not available on this page")
    return;
  }

  $(".js-start-scraping").on('click', function() {
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
             
