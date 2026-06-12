---
title: Software Sustainability
date: 2021-01-10 09:00:00 +1000
categories: [Explanation, Engineering]
tags: [sustainability, 'green-software']
author: Jamie Clayton
redirect_from:
  - /Sustainability.md
  - /Sustainability
  - /Sustainability.html
---
## Why I bother measuring carbon

Software runs on electricity, and electricity has a carbon cost. Most of us never see it, so we don't optimise for it. My stance is simple: the same habits that make software cheaper to run — fewer servers, less data over the wire, higher utilisation — also make it greener. You rarely have to choose between the two, which is why I think this is worth your attention even if the climate argument leaves you cold.

What follows are the eight principles I lean on, two philosophies worth arguing about, and a back-of-envelope figure that makes the cost of moving data concrete.

## Eight Principles

1. **Carbon**: Build applications that are carbon efficient.
2. **Electricity**: Build applications that are energy-efficient.
3. **Carbon Intensity**: Consume electricity with the lowest carbon intensity.
4. **Embodied Carbon**: Build applications that are hardware efficient.
5. **Energy Proportionality**: Maximize the energy efficiency of hardware.
6. **Networking**: Reduce the amount of data and distance it must travel across the network.
7. **Demand Shaping**: Build carbon-aware applications.
8. **Optimization**: Focus on step-by-step optimizations that increase the overall carbon efficiency.

## Two Philosophies

1. Everyone has a part to play in the climate solution.
2. Sustainability is enough, all by itself, to justify our work.

## The cost of moving a gigabyte

Here's the figure that made this real for me. Transferring 1GB of data over a network produces roughly 1.22kg of carbon.

![Equation](https://latex.codecogs.com/svg.latex?\fn_jvn&space;\large&space;1024&space;\times&space;0.0023&space;\times&space;0.519&space;=&space;1.22)

How you get there:

> - A 2019 study by The Shift Project proposed a 1-byte model for estimating the energy used in the transmission of data. To estimate the kWh, multiply the total megabytes of your traffic by 0.0023.
> - To convert to carbon, we use the average global carbon intensity of 519 gCO2eq/kWh, multiply with 0.519 to get kilograms of carbon. Using this model, we estimate transmitting 1 GB would result in 1024 ✕ 0.0023 ✕ 0.519 = 1.22 kilos of carbon emitted.

The principles behind it, in the source's own words:

> - The more you utilize a computer, the more efficient it becomes at converting electricity to useful computing operations.
> - Running your work on as few servers as possible with the highest utilization rate maximizes their energy efficiency.
> - So carbon-efficient applications focus on reducing the amount of data and distance it travels.
> - Sustainability isn't one optimization, it's thousands.
> - The key to success in optimization is to choose a measurement criterion that will give clear signals as to where best to put optimization efforts.
> - There are devices, tools, and libraries available to measure the energy consumed by an application.

## Resources

[The Principles of Sustainable Software Engineering (25 min)](https://docs.microsoft.com/en-gb/learn/modules/sustainable-software-engineering-overview)

