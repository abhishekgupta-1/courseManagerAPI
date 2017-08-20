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

function upd_display(){
	var leng = div_list.length;
	var i;
	for (i=0;i<leng;i++)
		div_list[i].style.display = 'none';	
	for (i=0;i<leng;i++){
		if (button_list[i].checked)
			div_list[i].style.display = 'block';
	}
}



function add_api_call(){
	var c_no = document.getElementById('add_c_no').value;
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
	var old_c_no = document.getElementById('substi_old_c_no').value;
	var new_c_no = document.getElementById('substi_new_c_no').value;
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

function view_api_call(){
	var s_id = document.getElementById('s_id').value;
	var api_link = base_link + String(s_id);
	var xhttp = new XMLHttpRequest();
  	xhttp.onreadystatechange = function() {
    if (this.readyState == 4 && this.status == 200) {
     	var table_data = JSON.parse(this.responseText)
     	table_data = table_data.data;
     	console.log(table_data)
     	var str = "";
     	for (index in table_data){
     		row = table_data[index]
     		console.log(row);
     		str += "<tr><td>"+row[0] + "</td><td>" + row[1]+ "</td><td>" + row[2] + "</td></tr>";
     	}
     	document.getElementById("view_table").innerHTML += str;
    }
  };
  xhttp.open("GET", api_link, true);
  xhttp.send();
}

function gen_api_call(){
	if (add_r_button.checked){
		add_api_call();
	}
	else if (substi_r_button.checked){
		substi_api_call();
	}
	else if (view_r_button.checked){
		view_api_call();
	}
}


upd_display();
