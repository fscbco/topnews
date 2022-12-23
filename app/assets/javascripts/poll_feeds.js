var spinnerIndex = -1;
const spinner = [];

spinner.push("-", "\\", "|", "/");

function getSpinner() {
  if (++spinnerIndex == spinner.length) {
    spinnerIndex = 0;
  }
  return spinner[spinnerIndex];
}

var pollFeedsIntervalId = 0;
var spinnerIntervalId = 0;

$(function() {
  function startPollFeeds() {
    console.log('Polling started...');
    pollFeedsIntervalId = setInterval(pollFeeds, feedsPollMilliseconds);
  }

  function stopPollFeeds() {
    console.log('Polling stopped.');
    clearInterval(pollFeedsIntervalId);
  }

  function startSpinner() {
    spinnerIntervalId = setInterval(updateFeedsPollStatusMessage, 250);
  }

  function stopSpinner() {
    clearInterval(spinnerIntervalId);
  }

  function updateFeedsPollStatusMessage() {
    $(`.${feedsPollSpinnerCssClass}`).text(getSpinner());
  }

  function pollFeeds() {
    $.ajax({
      url : feedsPollStatusPath,
      type : 'GET',
      dataType : 'json',
      success : function(data, textStatus, jqXHR) {
        stopPollFeeds();
        if (data.running) {
          console.log('Feed job is still running...');
          startPollFeeds();
        } else {
          console.log('Feed job is complete!');
          window.location = feedsRedirectPath
        }
      },
      error : function(jqXHR, textStatus, errorThrown )
      {
        stopPollFeeds();
        alert("Error: " + JSON.stringify(jqXHR));
      }
    });
  }
  startPollFeeds();
  startSpinner();
});
