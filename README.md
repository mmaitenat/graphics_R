# R graphics

This repository contains a collection of graphics I have been working on
with the aim to learn how to make fancy visualizations using R. Used
data covers a variety of topics.

## Streetmap

The first plot is a streetmap. I bet you have seen such pictures as
elements of decoration and you may have even thought of buying one
yourself. Well, I
[here](https://github.com/mmaitenat/graphics_R/blob/master/01_streetmap/streetmap.R)
show you how I made a NYC streetmap for myself following [this
tutorial](https://ggplot2tutor.com/streetmaps/streetmaps/) and using
[OpenStreetMap database](https://en.wikipedia.org/wiki/OpenStreetMap).
Below you can see the final result. As said, this was NYC but you can
just use any other spot you like in the world. Besides, you can easily
customize the design elements with some notions of ggplot2.
![](https://github.com/mmaitenat/graphics_R/blob/master/01_streetmap/NYC_streetmap.png)

## Radarchart

This time I am doing a radar chart, also known as spider or star chart.
According to [Wikipedia](https://en.wikipedia.org/wiki/Radar_chart),
this chart *consists of a sequence of equi-angular spokes, called radii,
with each spoke representing one of the variables. The data length of a
spoke is proportional to the magnitude of the variable for the data
point relative to the maximum magnitude of the variable across all data
points. A line is drawn connecting the data values for each spoke. This
gives the plot a star-like appearance*. Here I will be plotting the
macronutrient composition of the most common cereals. I’ll obtain food
information from the Spanish Food Composition Database (BEDCA) using the
[NutrienTracker
package](https://cran.r-project.org/web/packages/NutrienTrackeR/index.html).
For the chart I’ll be using the [radarchart
package](https://cran.r-project.org/web/packages/radarchart/radarchart.pdf),
which provides an interface to the radar chart making function within
Chart.js Javascript library. Now you can choose the best cereal for your
own needs at a glance\!
![](https://github.com/mmaitenat/graphics_R/blob/master/02_radarchart/radarchart.png)
