// svg definitions
let svgWidth = 960;
let svgHeight = 620;

// borders in svg
let margin = {
  top: 20, 
  right: 40, 
  bottom: 200,
  left: 100
};

// chart height and width
let width = svgWidth - margin.right - margin.left;
let height = svgHeight - margin.top - margin.bottom;

// add a div class to the scatter element
let chart = d3.select('#scatter')
  .append('div')
  .classed('chart', true);

//add an svg element to the chart 
let svg = chart.append('svg')
  .attr('width', svgWidth)
  .attr('height', svgHeight);

//add an svg group
let chartG = svg.append('g')
  .attr('transform', `translate(${margin.left}, ${margin.top})`);

//poverty and healthcare parameters; x and y axis
let povXAxis = 'poverty';
let healYAxis = 'healthcare';



//Updating the circles with a transition to new circles 
function getCircles(circlesall, xscale_new, povXAxis, yscale, healYAxis) {

  circlesall.transition()
      .duration(2000)
      .attr('cx', data => xscale_new(data[povXAxis]))
      .attr('cy', data => yscale(data[healYAxis]))

    return circlesall;
}

//function to stylize x-axis values for tooltips
function styleX(value, povXAxis) {

    //style based on variable
    //poverty
    if (povXAxis === 'poverty') {
        return `${value}%`;
    }
    //household income
    else if (povXAxis === 'income') {
        return `${value}`;
    }
    else {
      return `${value}`;
    }


}
//retrieve data
d3.csv('./assets/data/data.csv').then(function(allData) {

    console.log(allData);
    
    //Parse data
    allData.forEach(function(data){

        data.healthcare = +data.healthcare;
        data.poverty = +data.poverty;
    });

    // linear scales
    var xLin = xScale(allData, povXAxis);
    var yLin = yScale(allData, healYAxis);

    //x axis
    var bottomAxis = d3.axisBottom(xLin);
    var leftAxis = d3.axisLeft(yLin);

    //add X values
    var xAxis = chartG.append('g')
      .classed('x-axis', true)
      .attr('transform', `translate(0, ${height})`)
      .call(bottomAxis);

    //add Y
    var yAxis = chartG.append('g')
      .classed('y-axis', true)
      //.attr
      .call(leftAxis);
    
    //add Circles
    var circles = chartG.selectAll('circle')
      .data(allData)
      .enter()
      .append('circle')
      .classed('stateCircle', true)
      .attr('cx', d => xLin(d[povXAxis]))
      .attr('cy', d => yLin(d[healYAxis]))
      .attr('r', 14)
      .attr('opacity', '.8');

    //append Initial Text
    var textint = chartG.selectAll('.stateText')
      .data(allData)
      .enter()
      .append('text')
      .classed('stateText', true)
      .attr('x', d => xLin(d[povXAxis]))
      .attr('y', d => yLin(d[healYAxis]))
      .attr('dy', 10)
      .attr('font-size', '14px')
      .text(function(d){return d.abbr});

    //make a group for the x axis labels
    var xLabels = chartG.append('g')
      .attr('transform', `translate(${width / 2}, ${height + 10 + margin.top})`);

    var povertyLabs = xLabels.append('text')
      .classed('aText', true)
      .classed('active', true)
      .attr('x', 0)
      .attr('y', 20)
      .attr('value', 'poverty')
      .text('In Poverty (%)');
      
    //make a group for Y labels
    var yLabels = chartG.append('g')
      .attr('transform', `translate(${0 - margin.left/4}, ${height/2})`);

    var healthcareLabs = yLabels.append('text')
      .classed('aText', true)
      .classed('active', true)
      .attr('x', 0)
      .attr('y', 0 - 20)
      .attr('dy', '1em')
      .attr('transform', 'rotate(-90)')
      .attr('value', 'healthcare')
      .text('Lacks Healthcare (%)');

    
    
});