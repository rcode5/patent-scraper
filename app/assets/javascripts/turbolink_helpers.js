window.onPageReady = function(cb) {
  $(document).ready(cb)
  $(document).on('page:load', cb)
};
