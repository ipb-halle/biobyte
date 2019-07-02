# Biobyte
Training example for Biobyte training event.

Metabolite profiling was performed on different samples of red stuff: Blood and Ketchup from 10 different commercial manufacturers. Mass Spectrometry is not always as simple as it looks on TV. This data was acquired for the science night at the IPB Halle.

## Example data
Example data is available as MTBLS655 (Metabolite Profiling: Blood or Ketchup).
From the example data, peak picking was performed with XCMS and standard settings to give the feature list.

The example feature list can be imported from this url: `https://ogy.de/lsep`

## Galaxy workflow
Below is a screenshot of the full Galaxy workflow which includes data import, log-transformation, and modules for plotting a heatmap, dendrogram and histogram.

![Screenshot of Galaxy workflow](galaxy/biobyte_results_workflow.png)

The example workflow for training can be imported from this url: `https://ogy.de/w6zr`

## Processing of the workflow
Processing the feature list (in tabular format) in the Galaxy workflow management system results in the following plots.

![Dendrogram plot with expected results](results_dendrogram.png)
![Heatmap plot with expected results](results_heatmap.png)

## Acknowlegements
- Kristian Peters
- Hendrik Treutler
- Rene Meier
- Steffen Neumann
- Edda Roepenack (for the dataset on MetaboLights)

