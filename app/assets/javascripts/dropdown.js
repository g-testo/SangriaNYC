
function dropdownFunction(dropdownList) {

  function dropdownAction(action, id){
    if (action == "remove"){
      document.getElementById(id).classList.remove("show");
    } else if (action == "toggle"){
      document.getElementById(id).classList.toggle("show");
    }
  }
  if (dropdownList == "flavor"){
    dropdownAction("toggle", "flavorDropdown")
    dropdownAction("remove", "accountDropdown")
    dropdownAction("remove", "contactDropdown")
  } else if (dropdownList == "account"){
    dropdownAction("toggle", "accountDropdown")
    dropdownAction("remove", "flavorDropdown")
    dropdownAction("remove", "contactDropdown")
  } else if (dropdownList == "contact"){
    dropdownAction("toggle", "contactDropdown")
    dropdownAction("remove", "flavorDropdown")
    dropdownAction("remove", "accountDropdown")
  }
}

window.onclick = function(event) {
  if (!event.target.matches('.dropbtn')) {
    var dropdowns = document.getElementsByClassName("dropdown-content");
    for (var i=0; i<dropdowns.length;i++) {
      var openDropdown = dropdowns[i];
      if (openDropdown.classList.contains('show')) {
        openDropdown.classList.remove('show');
      }
    }
  }
}
