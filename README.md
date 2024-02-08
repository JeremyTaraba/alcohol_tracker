# Drink Trackr

A drink tracking app designed to help you monitor and manage your beverage consumption effortlessly.

## Description

This project was made in Android Studio using Flutter. This project compiles into an app that runs on Android and lets users create an account or log in to an existing account. Account authorization is taken care of by using Firebase Auth. The app itself uses TensorFlow Light AI and machine learning to determine what type of drink you have, making logging easy and intuitive. It uses Flutter plugins for tables and calendars to show your drink history and progress.

## Dependencies

- Android Studio Giraffe | 2022.3.1 Patch 2
- Flutter 3.7.6
- Dart 2.19.3
- Android 12.0 Google APIs | x86_64

## Installing On Phone

Compile and run files within Android Studio to make an executable APK

link to instructions: https://developer.android.com/studio/run

google play link: https://play.google.com/store/apps/details?id=com.jeremytaraba.alcoholtracker.alcohol_tracker


## Mock Up

Here is a mock up of the app I made on figma to guide me through the development process
Link to Figma: [Drink Trackr](https://www.figma.com/file/WF63nTwBFEPY1aCSXmdyUa/Alcohol-Tracker?type=design&node-id=0%3A1&mode=design&t=vHm5D6nxer3usyXD-1)


![Figma Mock Up](https://i.imgur.com/DkoxkN1.png)


## Finished Product

Here are screenshots from the finished product

![Drink Trackr Images](https://i.imgur.com/GxAo3x3.jpg)

Google Play Store listing: [Drink Trackr on Play Store](https://play.google.com/store/apps/details?id=com.jeremytaraba.alcoholtracker.alcohol_tracker&hl=en_US&gl=US)




# Research Paper: A Mobile Application to Assist in Tracking Alcohol Consumption using Machine Learning and Object Detection

## Table Of Contents:

Section 1 - Introduction [intro](#section-1)

Section 2 - Challenges

Section 3 - Method Analysis

Section 4 - Experiments

Section 5 - Methodology Comparison

Section 6 - Conclusions

Section 7 - Summaries

Section 8 - References




## Section 1 – Introduction
### 1.1 – Introduction to Problem

Efforts to mitigate the harmful effects of alcohol and reduce overall consumption have recently become paramount in public health discourse and for good reason. Excessive alcohol usage leads to over 100,000 annual deaths in the United States [1], which includes drunk driving as well as chronic misuse [12]. It is ranked third in the United States for preventable deaths [1]. This is nothing new as Egyption historical manuscripts mention alcohol abuse [4]. Previous studies show an increase in alcohol consumption between 1990 and 2017 [5] where younger adults have a higher volume of consumption [7].  Additionally there are increases in alcohol use disorders [6] despite efforts to reduce alcohol consumption by the World Health Organization [13]. Binge drinking has also become more prevalent [2] especially with adults in their 20s [3]. These numbers are projected to grow as we go deeper into the twenty-first century. This issue is not just isolated to America, the largest increase in consumption comes from Asian regions [8]. With all of this data on the dangers of alcohol there have been multiple methods proposed to study and reduce consumption, although with little success [11]. Unfortunately, some of the greatest obstacles are lobbying from those that benefit from the sale of alcohol [10]. While various strategies have been put forth to address this and mitigate alcohol consumption, formidable challenges still persist. The alarming rise in alcohol consumption among younger demographics and the concurrent surge in alcohol-related fatalities underline the urgent need for effective measures aimed at reducing alcohol consumption.

### 1.2 – Method Proposal

We propose a method for solving this issue by creating a mobile application that tracks and records daily alcohol intake. The main feature of this application is that by simply taking photos of the alcoholic drink, users can log their individual consumption. By only needing to take a photo of the alcoholic beverage, there is much less hassle and users will be more encouraged to use the application. The incorporation of a drink history would allow drinkers to see their daily alcohol intake trends, such as on what days they consume the most alcohol and which types of alcohol are consumed the most. With this information they can see if their consumption has decreased for the purpose of gradually abstaining from alcohol.  Additionally, with the implementation of a blood alcohol level estimation, users will easily be able to know if they have had too much to drink or if they are fit to drive. An application would be easy to implement using Flutter which facilitates the development of both Android and IOS apps in one code base. The accessibility of an application makes it more attractive than other solutions since most people have a smartphone. The application is also free to use for anyone. With the low amount of effort needed to snap a picture of the alcoholic beverage, users will be more incentivized to take photos. Compared to other forms of alcohol tracking, this application is easy to utilize. The goal is to revolutionize how individuals monitor and regulate their alcohol consumption, promoting responsible drinking habits and fostering user well-being while contributing to a culture of informed and mindful alcohol consumption.


## Section 2 – Challenges

### 2.2 – Challenge A

One challenge to the program will be implementing artificial intelligence to recognize different types of alcoholic beverages. This technology is frequently subject to mistakes, so its estimations may not be accurate. It may guess the wrong volume of the drink or type of drink, which will completely ruin the alcohol calculation. To resolve this issue, we could add a function for people to manually select and enter the volumes of their drinks, which would help a lot with the accuracy of the AI output. This way, even if the AI guesses wrong, the human can manually change the calculation to be accurate.

### 2.2 – Challenge B

Another problem is implementing the blood alcohol content estimate. As it varies with each person and gender, there is not a perfect way to obtain a decently reliable estimate. This would skew the data and give people widely incorrect data about their blood alcohol content, which would negatively impact their judgment. One possible solution to this is to add a profile section where the user of the app can manually enter in their weight and gender, so the calculator can make a more accurate prediction to their blood alcohol content. To make sure the blood alcohol calculator is accurate, we would implement similar strategies that blood alcohol content calculators from reputable sources use.


### 2.2 – Challenge C

One problem we stumbled upon was creating how the app logged each drink. We did not have a way of showing how much each user drank and on which days, which made the app a bit unclear. A potential solution to this problem was to implement a calendar screen, in which the user could be able to click on specific days and see their alcohol usage. We also could put a graph on the home screen, so that users could see when they had their last drink, and on what days. This way, users are provided with a streamlined visual of their alcohol consumption.


## Section 3 – Method Analysis

### 3.1A – Diagram

![Diagram](https://i.imgur.com/YNyUVHT.png)

### 3.1B – System Overview

The mobile application is developed within the Android Studio framework, leveraging the robust and null-safe features of Flutter for its development. This choice was made due to Flutter's flexibility, simplicity, and adaptability, making it an ideal platform for efficient application creation. It also integrates Firebase as its database solution. This selection is based on Firebase's reputation for reliability and its swift setup process, accommodating a diverse range of applications seamlessly. When the app is run the user logs in to the account which connects to Firebase to fetch their information and drinking history. Users can view their history by going to the history tab. This tab provides a calendar view of all past recorded drinks and their amounts. Users can log a new drink by clicking on the camera tab. This lets users take a picture of their beverage and will determine what type of drink it is by using AI object detection. This AI was trained on many different types of alcoholic drinks using machine learning and 500+ images for each drink. When the AI determines what type of drink the user has, it will prompt the user to enter how many ounces they have drunk or plan to drink. The drink will be logged on the database and the time it was logged will also be recorded. The time is very important for determining and displaying blood alcohol levels to the user as well as giving recommendations on if the user is above or below the legal limit for driving. The machine learning for the application was done using Google’s Teachable Machine to train the data and exporting the results to Tensorflow to be imported to the application.


### 3.2A – Component Analysis A

One central component in the application is the object detection system. Users can capture images of their drink and the AI will identify the alcoholic drink.  Users are then prompted to input the quantity consumed or planned. The AI has been trained to identify drinks by using machine learning techniques and runs locally using Tensorflow Lite.

### 3.2B – UI Screenshot

### 3.2C – Code Sample

### 3.2D – Code Explanation

In order to identify the type of drink the user has taken a picture of, the app uses Tensorflow Lite, a streamlined version of the Tensorflow framework. Tensorflow Lite needs to be fed machine learning data to be set up. The AI also needs the labeled dataset which contain the drinks that the machine learning data is based off of. The last method processes the image taken from the user and calls upon the now set up Tensorflow Lite AI to classify the image. The AI classifies the image based on the machine learning data and it compares the image to the machine learning data. The AI determines the closest match in the dataset, generating a prediction on the classification of the drink. In scenarios where the AI encounters uncertainty or provides multiple predictions, the user is granted the opportunity to manually select the accurate prediction. This user-driven validation mechanism ensures a refined and accurate classification process, enhancing the overall reliability of the application's beverage identification feature.

### 3.3A – Component Analysis B

Another component present is the drink history calendar. Users have the capability to access the history screen, where a calendar view is presented, highlighting specific dates on which a drink was recorded. Furthermore, users have the option to click on a particular day to access a comprehensive summary detailing the drinks logged on that specific date.

### 3.3B – UI Screenshot

### 3.3C – Code Sample

### 3.3D – Code Explanation

The calendar is implemented by taking advantage of a Flutter package called table_calendar. This package allows the use of a prebuilt calendar that can be modified to fit the needs of our application. The calendar has an event loader which is used to gather a list of events for the current day and does this for all days in an active month. This populates the days with events, which in our case, is the drinks that have been logged on that day with their amounts. These events are gathered from Firebase by looking at each time a user has logged a drink, calculating the total amount of ounces, and adding them to a list for each day. The calendar also allows for users to click on different days to view events from the past.  The selected day variable keeps track of what day is selected and loads the events for that day if there are any.


### 3.4A – Component Analysis B

The third component is the blood alcohol level indicator. When a user logs their drink, the alcohol content and the size of the drink is taken into consideration along with the user's gender and weight to produce an accurate blood alcohol level that is personal to the user. This level also updates as time goes by and alcohol is filtered out of the blood.

### 3.4B – UI Screenshot

### 3.4C – Code Sample

### 3.4D – Code Explanation

For the blood alcohol level, we have created a function which will calculate and return the current blood alcohol level. This function first needs to access Firebase to load the drinks that have been logged in the last 24 hours. It loads the drinks, a time stamp for when they were logged, and the amount drunk into a list and calculates the blood alcohol level using the mathematical formula for blood alcohol. This formula uses the user’s gender and weight in order to accurately predict and personalize the alcohol level for each user. The function goes through each drink and is able to determine how much alcohol is in the drink by using an average constant for each specific drink. For example, beers have on average 5% alcohol content and wines have on average 12%. These percentages are used in the formula for calculating the alcohol levels. Lastly, the time difference between now and when the drink was consumed is taken into account when calculating the levels. This is because as time goes on, the levels of alcohol decrease.


## Section 4 – Experiments

### 4.1A – Experiment A

### 4.1B – Design

### 4.1C – Data and Visualization

### 4.1D – Analysis



### 4.2A – Experiment B

### 4.2B – Design

### 4.2C – Data and Visualization

### 4.2D – Analysis



## Section 5 - Methodology Comparison

### 5.1 – Methodology A

### 5.2 – Methodology B

### 5.3 – Methodology C



## Section 6 – Conclusions

### 6.1 – Limitations and Improvements

### 6.2 – Concluding Remarks



## Section 7 – Summaries

### 7.1 – Experiment Recap

### 7.2 – Methodology Comparison

### 7.3 - Abstract


## Section 8 - References

## [1] Hanson, M. (2023, January 1). National Center for & Drug Abuse Statistics. (2023). Alcohol Abuse Statistics [2023]: National+ State Data. https://drugabusestatistics.org/alcohol-abuse-statistics/

## [2] “Data on Excessive Drinking.” Centers for Disease Control and Prevention, Centers for Disease Control and Prevention, 13 Nov. 2023, 
www.cdc.gov/alcohol/data-stats.htm. 

## [3] Vankar, Preeti. “Binge Drinking in the United States.” Statista, 24 Jan. 2024, www.statista.com/statistics/354265/current-binge-heavy-alcohol-use-among-persons-in-the-us-by-age/. 

## [4] el‐Guebaly, N., & El-Guebaly, A. (1981). Alcohol Abuse in Ancient Egypt: The Recorded Evidence. The International Journal of the Addictions, 16(7), 1207–1221. https://doi.org/10.3109/10826088109039174 

## [5] Manthey, Jakob. “Global Alcohol Exposure between 1990 and 2017 and Forecasts Until ...” The Lancet, 7 May 2019, www.thelancet.com/journals/lancet/article/PIIS0140-6736(18)32744-2/fulltext. 

## [6] Tang, Y. L., Xiang, X. J., Wang, X. Y., Cubells, J. F., Babor, T. F., & Hao, W. (2013). Alcohol and alcohol-related harm in China: policy changes needed. Bulletin of the World Health Organization, 91, 270-276. https://www.scielosp.org/article/ssm/content/raw/?resource_ssm_path=/media/assets/bwho/v91n4/09.pdf

## [7] Rehm, J., Kehoe, T., Gmel, G., Stinson, F., Grant, B., & Gmel, G. (2010). Statistical modeling of volume of alcohol exposure for epidemiological studies of population health: the US example. Population Health Metrics, 8, 1-12. https://link.springer.com/article/10.1186/1478-7954-8-3

## [8] Shield, K. D., Rylett, M., & Rehm, J. (2016). Public health successes and missed opportunities: Trends in alcohol consumption and attributable mortality in the WHO European Region, 1990–2014 (No. WHO/EURO: 2016-4119-43878-61787). World Health Organization. Regional Office for Europe.
https://www.camh.ca/-/media/files/pdfs---reports-and-books---research/report-to-who-european-region-trends-alcohol-consumption-mortality-camh-oct-2016-pdf.pdf

## [9] Cheeseman, T., Southerland, K., Park, J. et al. Advanced image recognition: a fully automated, high-accuracy photo-identification matching system for humpback whales. Mamm Biol 102, 915–929 (2022). https://doi.org/10.1007/s42991-021-00180-9

## [10] World Health Organization. (2019). Global status report on alcohol and health 2018. World Health Organization.
https://books.google.com/books?hl=en&lr=&id=qnOyDwAAQBAJ&oi=fnd&pg=PR7&dq=+Global+status+report+on+alcohol+and+health+2018.+World+Health+Organization.&ots=a2ksOHrkan&sig=OaQFz44xMh795d0YmTcFGw6AjxA#v=onepage&q=Global

## [11] Probst, C., Manthey, J., Merey, A., Rylett, M., & Rehm, J. (2018). Unrecorded alcohol use: a global modeling study based on nominal group assessments and survey data. Addiction, 113(7), 1231-1241. https://onlinelibrary.wiley.com/doi/abs/10.1111/add.14173

## [12] Rehm, J., Shield, K. D., Roerecke, M., & Gmel, G. (2016). Modeling the impact of alcohol consumption on cardiovascular disease mortality for comparative risk assessments: an overview. BMC public health, 16, 1-9. https://link.springer.com/article/10.1186/s12889-016-3026-9

## [13] World Health Organization. (2010). Global strategy to reduce the harmful use of alcohol. World Health Organization. https://www.who.int/publications/i/item/9789241599931

## [14] Winek CL, Esposito FM. Blood alcohol concentrations: factors affecting predictions. Legal Medicine. 1985 :34-61. PMID: 3835425. https://pubmed.ncbi.nlm.nih.gov/3835425/

## [15] N. A. PIKAAR, M. WEDEL, R. J. J. HERMUS, INFLUENCE OF SEVERAL FACTORS ON BLOOD ALCOHOL CONCENTRATIONS AFTER DRINKING ALCOHOL, Alcohol and Alcoholism, Volume 23, Issue 4, 1988, Pages 289–297, https://doi.org/10.1093/oxfordjournals.alcalc.a044819

## [16] Steven E Meredith, Sheila M Alessi & Nancy M Petry (2015) Smartphone applications to reduce alcohol consumption and help patients with alcohol use disorder: a state-of-the-art review, Advanced Health Care Technologies, 1:, 47-54, DOI: 10.2147/AHCT.S65791
https://www.ncbi.nlm.nih.gov/pmc/articles/PMC4963021/


