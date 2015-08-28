onPageReady( function() {

  $('.js-export-csv').on('click', function() {
    var url = $(this).data('patentUrl');
    var newPath = "/patents.csv?url=" + encodeURI(url);
    location.href = newPath
  });
});