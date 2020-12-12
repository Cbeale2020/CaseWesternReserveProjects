function Plotd(id) {
    d3.json("data/samples.json").then((data)=> {
        console.log(data)
          
        var fil_samples = data.samples.filter(samps => samps.id.toString() === id)[0];
        
        console.log(fil_samples);
  
        var samvalues = samples.sample_values.slice(0, 10).reverse();
  
        var otu = (samples.otu_ids.slice(0, 10)).reverse();
        
        var oid = otu.map(d => "OTU " + d)
  
      console.log(`otu ids: ${oid}`)
  
  
        var labels = samples.otu_labels.slice(0, 10);
  
         console.log(`sample Values: ${samvalues}`)
        var trace = {
            x: samvalues,
            y: oid,
            text: labels,
            type:"bar",
            orientation: "h",
        };
  
        var data = [trace];
  
        var layout = {
            title: "Bar of Top 10",
            
        };
  
        Plotly.newPlot("bar", data, layout);
  
        console.log(`id: ${samples.otu_ids}`)
      
        var trace1 = {
            x: samples.otu_ids,
            y: samples.sample_values,
            marker: {
                size: samples.sample_values,
                color: samples.otu_ids
            },
            text: samples.otu_labels
  
        };
  
        var layout_bub = {
            xaxis:{title: "OTU"},
            
        };
  
        var databub = [trace1];
  
        Plotly.newPlot("bubble", databub, layout_bub); 
  
    
      });
  }  

function render() {
    var dropdown = d3.select("#selDataset");

    d3.json("samples.json").then((read_data)=> {
        console.log(read_data);

        data.names.forEach(function(idname) {
            dropdown.append("option").text(idname).property("value");
        });

        Plotd(data.names[0]);
    
    });
}

render();
