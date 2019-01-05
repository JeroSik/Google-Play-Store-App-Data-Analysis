# Google-Play-Store-App-Data-Analysis
A statistical analysis of the data scraped from the Google Play app store. During the semester of Fall 2018, the honors project for STAT 35000 decided to find trends and patterns related to the market to help developers. See also the [presentation](https://docs.google.com/presentation/d/1jG0tJ_Y5ShYqnmcQZq_5GC8qks4EzhJ0qKsI7dPtMaU/edit?usp=sharing) for this project.

## Analysis Questions
1. Which Google Play store app category has the greatest ratings?

2. Is there a significant difference in ratings between a Google Play store app that has either a restricted or non-restricted content rating?

3. Is there a significant difference in ratings between a Google Play store app that is either paid or free?

## Dataset
The dataset for this project was found on [Kaggle](https://www.kaggle.com/lava18/google-play-store-apps), and the information was collected through web scraping around 10,000 Play Store apps. Since Google Play uses modern-day techniques like dynamic page load using JQuery, this made scraping more challenging. Each app has values for category, rating, size, installs, and other app specifications. Although Google Play acts as a digital media store as well, the data covers only mobile applications. The program R was used in the analysis. To address the first question, an ANOVA test was used to observe whether there was a statistically significant difference between the ratings of each of categories. To address the second and third question, two Welch two-sample t-test were used to observe whether there was a statistically significant difference between the two different content ratings and the cost of the app. The assumptions made for all tests were met by the datasets.

## Results
The ANOVA test indicated that there was significant statistical evidence to conclude that the true mean ratings among the all categories were not equal to each other. Instead,  “UTILITY” and “EDUCATION” were not statistically different, and “LIFESTYLE” and “BUSINESS” were not statistically different. This was determined by whether the confidence intervals between the categories contained a zero value for the difference between the true means. The Welch two-sample t-tests indicated the p-value of the null hypothesis, the true mean rating. For the content rating, the p-value was less than 2.2e-16 which shows that the true mean rating between content ratings are not equal to each other. For the cost, the p-value was 0.1251 which shows that the true mean rating between paid or free are equal to each other.

## License
This project is lincensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details.

## Acknowledgments
* [Findsen, Leondre](http://www.stat.purdue.edu/~lfindsen/) for allowing me to honors contract STAT 35000
