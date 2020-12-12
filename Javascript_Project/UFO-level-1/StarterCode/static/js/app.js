// from data.js
var tableData = data;

// YOUR CODE HERE!

console.log(tableData)

//select the body
let tbody = d3.select("tbody");
// loop through  each object in the data
tableData.forEach(ufo => {
    // append the row to the body
    let tr = tbody.append("tr");
    // for each key value pair
    Object.entries(ufo).forEach(function([key,value]){
        // append the cell information
        let cell = tr.append("td");
        //since we already have the key only get the value part of the cell
        cell.text(value)
});
});

// get reference for the table 
///d3.select("table").attr("class","table table-striped");
var drtable =  data


// click the button
// create a variable for the button
var button = d3.select("#filter-btn");

button.on("click",function(){
   // Prevent the page from refreshing
    d3.select("tbody").html("");

    d3.event.preventDefault();
  // get reference to the input field
    var inputField = d3.select("#datetime");

    var inputValue = inputField.property("value");

    //print the value that was input
    console.log(inputValue);

    var Filtered_table = drtable.filter(result => result.datetime === inputValue);

    console.log(Filtered_table);

    Filtered_table.forEach((ufo) => {
      // append the row to the body
      let tr = tbody.append("tr");

    Object.entries(ufo).forEach(([key,value]) => {
       console.log(key, value);
      // append the cell information
      let cell = tr.append("td");
      //since we already have the key only get the value part of the cell
      cell.text(value);
     });
   }); 
});
 


