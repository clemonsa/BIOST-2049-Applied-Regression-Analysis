# Introduction

Medicare Advantage (MA) Plans are a form of Medicare where beneficiaries are covered by a private company, which contracts through Medicare, to provide both Plan A and Part B benefits. 

The advantage to this form of healthcare coverage is that cost sharing may be less in comparison to the standard Medicare and out-of-pocket costs are limited. The result are cost-savings that can encourage people to partake in preventative heatlthcare, reducing the burden of using hospital resources for medical emergencies and extended stays. Many MA plans also included coverage beyond that of standard Medicare such as vision, dental, hearing aids, and prescription drug coverage.

However, there are concerns about the current push towards using MA plans in comparison to traditional Medicare. Medicare Advantage programs come with many restrictions, such as in doctors or facilities that accept beneficiaries in comparison to the standard Medicare. This can lead to obstacles for beneficiaries wishing to seek medical care and could have a negative effect on healthcare outcomes. Furthermore, MA plans are regional instead of national which restricts participating providers to those in which beneficiaries reside in the same area for at least 6 months of the year. This geographic restriction could discourage those who livelihoods require spending time in different locations throughout the year or increases the distance between those in rural areas to healthcare providers that accept their coverage. 

Overall while MA have their advantages for some, it has been observed that many sicker beneficiaries are less likely to use MA plans which could contribute to an increase in use hospital and emergency department resources. 

Our research question is to examine whether we can accurately use metrics of hospital readmissions and emergency department vists to predict the participation of MA enrollees.

# Methods

The data used is the [Centers for Medicare & Medicaid Services](https://www.cms.gov/Research-Statistics-Data-and-Systems/Statistics-Trends-and-Reports/Medicare-Geographic-Variation/GV_PUF) Medicare Geographic Variation Public Use Files, *State Table - Beneficiaries Under 65* dataset. 

We remove the *National* and *(Unknown)* States from analysis. Our research question is whether we can predict the *MA Participation Rate* using all four of the *Readmissions and ED Visit* variables as predictors. The data will be split, using the years 2007 - 2016 as training for the model and will be we evaluated using the year 2017 set to determine the accuracy of the fitted model.

The descriptive statistics of the training data for the outcome and variables will be observed through a table and plots, which display the median and kernal probability density of Medicare Advantage Participation Rate(MA) by each predictor variable.

Next assumptions for our Multiple Linear Regression (MLR) model must be considered before fitting our model. We will perform graphical analysis on the outcome and predictors in order to identify whether there is linearity between outcome and each predictor. This will be followed by testing these same assumptions and possible collinearity with statistical tests.

If necessary, we will make adjustments to the data in order for it to become suitable for fitting a model.

After we have fit the model, we will perform a series of diagnoses to determine if our model is the best.
