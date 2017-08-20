var add_r_button = document.getElementById("add_r_button");
var substi_r_button = document.getElementById("substi_r_button")
var view_r_button = document.getElementById("view_r_button")

var add_view = document.getElementById("add");
var substi_view = document.getElementById("substi")
var view_view = document.getElementById("view")

var status_div = document.getElementById('status_div')

var button_list = [add_r_button, substi_r_button, view_r_button];
var div_list = [add_view, substi_view, view_view];

var base_link = 'http://127.0.0.1:5000/'

var button_index = -1;
//
// function upd_display(){
// 	var leng = div_list.length;
// 	var i;
// 	for (i=0;i<leng;i++)
// 		div_list[i].style.display = 'none';
// 	for (i=0;i<leng;i++){
// 		if (button_list[i].checked)
// 			div_list[i].style.display = 'block';
// 	}
// }


function upd_display(thiss){
	var leng = div_list.length;
	var i;
	for (i=0;i<leng;i++)
		div_list[i].style.display = 'none';
	for (i=0;i<leng;i++) {
        if (thiss == button_list[i]) {
            div_list[i].style.display = 'block';
            button_index = i;
            if (thiss == add_r_button)
              populate_for_add();
            else if (thiss == substi_r_button)
              populate_for_substitution1();
        }
    }
}

function populate_for_add(){
  var s_id = document.getElementById('s_id').value;
  var api_link = "";
  if (s_id == ""){
    alert('Enter Student ID');
    return
  }
  api_link = base_link + 'availablecourselist/' + String(s_id)
  var xhttp = new XMLHttpRequest();
    xhttp.onreadystatechange = function() {
    if (this.readyState == 4 && this.status == 200) {
      var arr = JSON.parse(this.responseText)
      var str = "";
      for (index in arr){
        item = arr[index];
        str += '<option value = "' + item[0] + '">' + item[1] + "</option>"
      }
      document.getElementById('add_c_no').innerHTML = str;
    }
  };
  xhttp.open("GET", api_link, true);
  xhttp.send();
}

function populate_for_substitution1(){
  var s_id = document.getElementById('s_id').value;
  var api_link = "";
  if (s_id == ""){
    alert('Enter Student ID');
    return
  }
  api_link = base_link + 'availablecourselist/' + String(s_id)
  var xhttp = new XMLHttpRequest();
    xhttp.onreadystatechange = function() {
    if (this.readyState == 4 && this.status == 200) {
      var arr = JSON.parse(this.responseText)
      var str = "";
      for (index in arr){
        item = arr[index];
        str += '<option value = "' + item[0] + '">' + item[1] + "</option>"
      }
      document.getElementById('substi_new_c_no').innerHTML = str;
      populate_for_substitution2();
    }
  };
  xhttp.open("GET", api_link, true);
  xhttp.send();
}

function populate_for_substitution2(){
  var s_id = document.getElementById('s_id').value;
  var api_link = base_link + 'unavailablecourselist/' + String(s_id)
  var xhttp = new XMLHttpRequest();
    xhttp.onreadystatechange = function() {
    if (this.readyState == 4 && this.status == 200) {
      var arr = JSON.parse(this.responseText)
      var str = "";
      for (index in arr){
        item = arr[index];
        str += '<option value = "' + item[0] + '">' + item[1] + "</option>"
      }
      document.getElementById('substi_old_c_no').innerHTML = str;
    }
  };
  xhttp.open("GET", api_link, true);
  xhttp.send();
}

function add_api_call(){
  var e = document.getElementById("add_c_no");
  var c_no = e.options[e.selectedIndex].value;
	var s_id = document.getElementById('s_id').value;
	var passwd = document.getElementById('passwrd').value;
	var api_link = base_link + String(s_id) + "/" + String(c_no);
	var xhttp = new XMLHttpRequest();
  	xhttp.onreadystatechange = function() {
    if (this.readyState == 4 && this.status == 200) {
     	status_div.innerHTML = JSON.parse(this.responseText).response;
    }
  };
  xhttp.open("PUT", api_link, true);
  xhttp.send();
}

function substi_api_call(){
  var e = document.getElementById("substi_old_c_no");
  var old_c_no = e.options[e.selectedIndex].value;
  e = document.getElementById("substi_new_c_no");
  var new_c_no = e.options[e.selectedIndex].value;
	var s_id = document.getElementById('s_id').value;
	var passwd = document.getElementById('passwrd').value;
	var api_link = base_link + String(s_id) + "/" + String(old_c_no) + "/" + String(new_c_no);
	var xhttp = new XMLHttpRequest();
  	xhttp.onreadystatechange = function() {
    if (this.readyState == 4 && this.status == 200) {
     	status_div.innerHTML = JSON.parse(this.responseText).response;
    }
  };
  xhttp.open("PUT", api_link, true);
  xhttp.send();
}
// function clear_status(){
// 	var statusDiv= document.getElementById('status_div');
// 	statusDiv.innerHTML = "";
// }
function view_api_call(){
	var s_id = document.getElementById('s_id').value;
	var api_link = base_link + String(s_id);
	var xhttp = new XMLHttpRequest();
  	xhttp.onreadystatechange = function() {
    if (this.readyState == 4 && this.status == 200) {
     	var table_data = JSON.parse(this.responseText)
     	table_data = table_data.data;
     	console.log(table_data)
     	var str = "<tr>\n" +
            "    <th>Course ID</th>\n" +
            "<th> Course Title </th>\n" +
            "<th> Credits </th>\n" +
            "</tr>\n";
     	for (index in table_data){
     		row = table_data[index]
     		console.log(row);
     		str += "<tr><td>"+row[0] + "</td><td>" + row[1]+ "</td><td>" + row[2] + "</td></tr>";
     	}
     	document.getElementById("view_table").innerHTML = str;
    }
  };
  xhttp.open("GET", api_link, true);
  xhttp.send();
}

function gen_api_call(){
	if (button_index == 0) {
		add_api_call();
	}
	else if (button_index == 1){
		substi_api_call();
	}
	else if (button_index == 2){
		view_api_call();
	}
}


upd_display();
