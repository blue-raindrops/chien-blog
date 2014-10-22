document.user_id = document.URL.split('/').slice(-1)[0];

if((document.URL.substring(0, document.URL.indexOf('/', 14))+"/" == document.URL) || ((document.URL.indexOf("/users/") > -1) && !isNaN(parseInt(document.user_id)))){

document.time = new Date();
document.current_length = 0;
document.funct_call = (document.user_id == "") ? "/append_index/?" : "/append_feed/?"
function k(){
    if (document.body.scrollHeight == document.body.scrollTop + window.innerHeight) {
  var xmlhttp = new XMLHttpRequest();
  xmlhttp.onreadystatechange = function() {
      if (xmlhttp.readyState == 4 ) {
         if(xmlhttp.status == 200){
      console.log(xmlhttp.responseText);
      document.getElementById("posts_div").innerHTML += xmlhttp.responseText;
      document.current_length += 20;
         }else if(xmlhttp.status == 400) {
      alert('There was an error 400')
         }
      else {
        alert('something else other than 200 was returned')
      }
    }
  } 
  xmlhttp.open("GET", document.funct_call +"time=" + encodeURI(document.time.toString()) + "&current_length=" + encodeURI(document.current_length.toString()) + "&user_id=" + encodeURI(document.user_id.toString()), true);
  xmlhttp.send();
    }
}


document.addEventListener('scroll', function (event) {
  k();
});

window.onload = function() {
  k();
};

}