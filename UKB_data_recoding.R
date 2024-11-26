#UKB data recoding examples, as used in Cataldo-Ramirez et al., "Improving GWAS performance in underrepresented groups by appropriate modeling of genetics, environment, and sociocultural factors"

#### data dictionary ####
# 31.0.0 genetic sex; factor/binary
# 34.0.0 Year of birth; integer
# 129.0.0 Place of birth in UK - north co-ordinate; integer
# 130.0.0 Place of birth in UK - east co-ordinate; integer
# 135.0.0 Number of self-reported non-cancer illnesses; integer
# 189.0.0 Townsend Deprivation Index; numeric
# 864.0.0 Number of days/week walked 10+ minutes; integer
# 874.0.0 Duration of walks; integer
# 884.0.0 Number of days/week of moderate physical activity 10+ minutes; integer
# 894.0.0 Duration of moderate activity; integer
# 904.0.0 Number of days/week of vigorous physical activity 10+ minutes; integer
# 924.0.0 Usual walking pace; ordered factor
# 943.0.0 Frequency of stair climbing in last 4 weeks; ordered factor
# 1011.0.0 Frequency of light DIY in last 4 weeks; ordered factor
# 1021.0.0 Duration of light DIY; ordered factor
# 1050.0.0 Time spend outdoors in summer; integer
# 1060.0.0 Time spend outdoors in winter; integer
# 1160.0.0 Sleep duration per 24hrs; integer
# 1200.0.0 Sleeplessness / insomnia; ordered factor
# 1220.0.0 Daytime dozing / sleeping (narcolepsy); ordered factor
# "How likely are you to doze off or fall asleep during the daytime when you don't mean to?"
# 1249.0.0 Past tobacco smoking; ordered factor
# 1259.0.0 Smoking/smokers in household; ordered factor
# 1269.0.0	Exposure to tobacco smoke at home; integer
# 1279.0.0 	Exposure to tobacco smoke outside home; integer
# 1289.0.0 Cooked vegetable intake (per day); integer
# 1299.0.0 Salad / raw vegetable intake (per day); integer
# 1309.0.0 Fresh fruit intake (per day); integer
# 1329.0.0 Oily fish intake; ordered factor
# 1339.0.0 Non-oily fish intake; ordered factor
# 1349.0.0 Processed meat intake; ordered factor
# 1359.0.0 Poultry intake; ordered factor
# 1369.0.0 Beef intake; ordered factor
# 1379.0.0 Lamb/mutton intake; ordered factor
# 1389.0.0 Pork intake; ordered factor
# 1408.0.0 Cheese intake; ordered factor
# 1418.0.0 Milk type used; factor
# 1438.0.0 Bread intake; integer
# 1458.0.0 Cereal intake; integer
# 1468.0.0 Cereal type; factor
# 1478.0.0 Salt added to food; ordered factor
# 1528.0.0 Water intake; integer
# 1538.0.0 Major dietary changes in last 5 years; factor
# 1548.0.0 Variation in diet; ordered factor
# "Does your diet vary much from week to week?"
# 1558.0.0 Alcohol intake frequency; ordered factor
# 1677.0.0 Breastfed as baby; binary/factor
# 1687.0.0 Comparative body size at age 10; ordered factor
# 1697.0.0 Comparative height size at age 10; ordered factor
# 1980.0.0 Worrier / anxious feelings; factor/binary
# 2090.0.0 Seen doctor (GP) for nerves, anxiety, tension or depression; factor/binary
# 2100.0.0 Seen a psychiatrist for nerves, anxiety, tension or depression; factor/binary
# 2178.0.0 Overall health rating; ordered factor (ACE touchscreen question "In general how would you rate your overall health?")
# 2188.0.0 Long-standing illness, disability or infirmity; factor/binary
# 2463.0.0 Fractured/broken bones in last 5 years; factor/binary
# 2714.0.0 Age at menarche
# 2734.0.0 Number of live births
# 2754.0.0 Age at first live birth
# 2764.0.0 Age at last live birth
# 6138.0.0 Qualifications; factor                          
# 6144.0.0 Never eat eggs, dairy, wheat, sugar; factor
# 6164.0.0 Types of physical activity in last 4 weeks; factor
# 20116.0.0 Smoking status; factor
# 20117.0.0 Alcohol drinker status; factor
# 20127.0.0 Neuroticism score; integer (not numeric)
# 21000.0.0 Self-reported ethnicity; factor
# 21003.0.0 Age at assessment; integer
# 22033.0.0 Summed days activity; integer
#Sum of days performing walking, moderate and vigorous activity.
# 22034.0.0 Summed minutes activity; integer
# 22035.0.0 Above moderate/vigorous recommendation; factor/binary
# 22036.0.0 Above moderate/vigorous/walking recommendation; factor/binary
# 22037.0.0 MET minutes per week for walking; numeric
# 22038.0.0 MET minutes per week for moderate activity; numeric
# 22039.0.0 MET minutes per week for vigorous activity; numeric

##REMOVE COUNTRY SPECIFIC DATA:
# 26410.0.0, 26411.0.0, 26413.0.0, 26418.0.0, 26420.0.0, 26423.0.0, 26424.0.0, 26426.0.0, 26427.0.0, 26428.0.0, 26430.0.0, 26432.0.0


####recoding####

#data loaded as 'DF'

# 31.0.0 genetic sex; factor/binary
DF$X31.0.0 <- factor(DF$X31.0.0, levels= c("0", "1"), labels=c("Female","Male"))
names(DF)[names(DF) == 'X31.0.0'] <- 'Sex'

# DF$X34.0.0 Year of birth; integer
names(DF)[names(DF) == 'X34.0.0'] <- 'YOB'

# height = X50.0.0
names(DF)[names(DF) == 'X50.0.0'] <- 'Height'

# 129.0.0 Place of birth in UK - north co-ordinate; integer
is.na(DF$X129.0.0) <- DF$X129.0.0 == -1

# 130.0.0 Place of birth in UK - east co-ordinate; integer
is.na(DF$X130.0.0) <- DF$X130.0.0 == -1

# 135.0.0 Number of self-reported non-cancer illnesses; integer
DF$X135.0.0 <- as.integer(DF$X135.0.0)

# 189.0.0 Townsend Deprivation Index; numeric
DF$X189.0.0 <- as.numeric(DF$X189.0.0)
names(DF)[names(DF) == 'X189.0.0'] <- 'TDI'

# 864.0.0 Number of days/week walked 10+ minutes; integer
is.na(DF$X864.0.0) <- DF$X864.0.0 == -1 | DF$X864.0.0 == -3
DF$X864.0.0[DF$X864.0.0<0] <- 0

# 874.0.0 Duration of walks; integer
is.na(DF$X874.0.0) <- DF$X874.0.0 == -3 | DF$X874.0.0 == -1

# 884.0.0 Number of days/week of moderate physical activity 10+ minutes; integer
is.na(DF$X884.0.0) <- DF$X884.0.0 == -3 | DF$X884.0.0 == -1
summary(DF$X884.0.0) # integer 0 --> 7

# 884.0.0 FACTOR
DF$ModerateActivity <- factor(DF$X884.0.0,
                      levels = c("0", "1", "2", "3", "4", "5", "6", "7"),
                      labels = c("0", "1-2", "1-2", "3-4", "3-4", "5+", "5+", "5+"),
                      ordered = TRUE)

# 894.0.0 Duration of moderate activity; integer
is.na(DF$X894.0.0) <- DF$X894.0.0 == -3 | DF$X894.0.0 == -1

# 904.0.0 Number of days/week of vigorous physical activity 10+ minutes; integer
is.na(DF$X904.0.0) <- DF$X904.0.0 == -3 | DF$X904.0.0 == -1

# 924.0.0 Usual walking pace; ordered factor
is.na(DF$X924.0.0) <- DF$X924.0.0 == -7 | DF$X924.0.0 == -3
DF$X924.0.0 <- factor(DF$X924.0.0,
                levels= c("1", "2", "3"),
                labels= c("Slow", "Steady average", "Brisk"),
                ordered = TRUE)

# 943.0.0 Frequency of stair climbing in last 4 weeks; ordered factor
is.na(DF$X943.0.0) <- DF$X943.0.0 == -3 | DF$X943.0.0 == -1
DF$X943.0.0 <- factor(DF$X943.0.0, 
                levels= c("0", "1", "2", "3", "4", "5"),
                labels= c("None", "1-5x/D", "6-10x/D", "11-15x/D", "16-20x/D", ">20x/D"),
                ordered = TRUE)

# 1050.0.0 Time spend outdoors in summer (hrs per day); integer
is.na(DF$X1050.0.0) <- DF$X1050.0.0 == -1 | DF$X1050.0.0 == -3
DF$X1050.0.0[DF$X1050.0.0 < 0] <- 0
summary(DF$X1050.0.0)

# 1060.0.0 Time spend outdoors in winter; integer
is.na(DF$X1060.0.0) <- DF$X1060.0.0 == -1 | DF$X1060.0.0 == -3
DF$X1060.0.0[DF$X1060.0.0 < 0] <- 0

# 1160.0.0 Sleep duration per 24hrs; integer
is.na(DF$X1160.0.0) <- DF$X1160.0.0 == -1 | DF$X1160.0.0 == -3

# 1200.0.0 Sleeplessness / insomnia; ordered factor
is.na(DF$X1200.0.0) <- DF$X1200.0.0 == -3
DF$X1200.0.0 <- factor(DF$X1200.0.0,
                levels= c("1", "2", "3"),
                labels= c("Never/rarely", "Sometimes", "Usually"),
                ordered=TRUE)

# 1220.0.0 Daytime dozing / sleeping (narcolepsy); ordered factor
# "How likely are you to doze off or fall asleep during the daytime when you don't mean to?"
is.na(DF$X1220.0.0) <- DF$X1220.0.0 == -1 | DF$X1220.0.0 == -3
DF$X1220.0.0 <- factor(DF$X1220.0.0,
                levels= c("0", "1", "2", "3"),
                labels= c("Never/rarely", "Sometimes", "Often", "All of the time"),
                ordered=TRUE)

# 1249.0.0 Past tobacco smoking; ordered factor
is.na(DF$X1249.0.0) <- DF$X1249.0.0 == -3
DF$X1249.0.0 <- factor(DF$X1249.0.0,
                levels= c("4", "3", "2", "1"),
                labels= c("Never smoked", "Tried 1x or 2x","Smoked occasionally", "Smoked most/all days"),
                ordered = TRUE)
#or
DF$PastSmoking <- factor(DF$X1249.0.0,
                  levels= c("Never smoked", "Tried 1x or 2x","Smoked occasionally", "Smoked most/all days"),
                  labels= c("Never smoked / tried 1x or 2x", "Never smoked / tried 1x or 2x","Smoked", "Smoked"))

# 1259.0.0 Smoking/smokers in household; ordered factor
is.na(DF$X1259.0.0) <- DF$X1259.0.0 == -3
DF$X1259.0.0 <- factor(DF$X1259.0.0,
              levels= c("0", "1", "2"),
              labels= c("No", "Yes, 1 household member smokes", "Yes, more than one household member smokes"),
              ordered = TRUE)

# 1269.0.0	Exposure to tobacco smoke at home; integer
is.na(DF$X1269.0.0) <- DF$X1269.0.0 == -3 | DF$X1269.0.0 == -1

# 1279.0.0 	Exposure to tobacco smoke outside home; integer
is.na(DF$X1279.0.0) <- DF$X1279.0.0 == -3 | DF$X1279.0.0 == -1


# 1289.0.0 Cooked vegetable intake (per day); integer
is.na(DF$X1289.0.0) <- DF$X1289.0.0 == -1 | DF$X1289.0.0 == -3
DF$X1289.0.0[DF$X1289.0.0<0] <- 0

# 1299.0.0 Salad / raw vegetable intake (per day); integer
is.na(DF$X1299.0.0) <- DF$X1299.0.0 == -1 | DF$X1299.0.0 == -3
DF$X1299.0.0[DF$X1299.0.0<0] <- 0

# 1309.0.0 Fresh fruit intake (per day); integer
is.na(DF$X1309.0.0) <- DF$X1309.0.0 == -1 | DF$X1309.0.0 == -3
DF$X1309.0.0[DF$X1309.0.0 == -10] <- 0


# 1329.0.0 Oily fish intake; ordered factor
is.na(DF$X1329.0.0) <- DF$X1329.0.0 == -3 | DF$X1329.0.0 == -1
DF$X1329.0.0 <- factor(DF$X1329.0.0, 
                levels= c("0", "1", "2", "3", "4", "5"),
                labels= c("Never", "<1x/W", "1x/W", "2-4x/W", "5-6x/W", "1x or more/D"),
                ordered = TRUE)

# 1339.0.0 Non-oily fish intake; ordered factor
is.na(DF$X1339.0.0) <- DF$X1339.0.0 == -3 | DF$X1339.0.0 == -1
DF$X1339.0.0 <- factor(DF$X1339.0.0, 
                levels= c("0", "1", "2", "3", "4", "5"),
                labels= c("Never", "<1x/W", "1x/W", "2-4x/W", "5-6x/W", "1x or more/D"),
                ordered = TRUE)

# 1349.0.0 Processed meat intake; ordered factor
is.na(DF$X1349.0.0) <- DF$X1349.0.0 == -3 | DF$X1349.0.0 == -1
DF$X1349.0.0 <- factor(DF$X1349.0.0, 
                levels= c("0", "1", "2", "3", "4", "5"),
                labels= c("Never", "<1x/W", "1x/W", "2-4x/W", "5-6x/W", "1x or more/D"),
                ordered = TRUE)

# 1359.0.0 Poultry intake; ordered factor
is.na(DF$X1359.0.0) <- DF$X1359.0.0 == -3 | DF$X1359.0.0 == -1
DF$X1359.0.0 <- factor(DF$X1359.0.0, 
                levels= c("0", "1", "2", "3", "4", "5"),
                labels= c("Never", "<1x/W", "1x/W", "2-4x/W", "5-6x/W", "1x or more/D"),
                ordered = TRUE)
#or
DF$EatsPoultry <- factor(DF$X1359.0.0, 
                  levels= c("Never", "<1x/W", "1x/W", "2-4x/W", "5-6x/W", "1x or more/D"),
                  labels= c("No", "Yes", "Yes", "Yes", "Yes", "Yes"))

# 1369.0.0 Beef intake; ordered factor
is.na(DF$X1369.0.0) <- DF$X1369.0.0 == -3 | DF$X1369.0.0 == -1
DF$X1369.0.0 <- factor(DF$X1369.0.0, 
                        levels= c("0", "1", "2", "3", "4", "5"),
                        labels= c("Never", "<1x/W", "1x/W", "2-4x/W", "5-6x/W", "1x or more/D"),
                        ordered = TRUE)
DF$EatsBeef <- factor(DF$X1369.0.0, 
                       levels= c("Never", "<1x/W", "1x/W", "2-4x/W", "5-6x/W", "1x or more/D"),
                       labels= c("No", "Yes", "Yes", "Yes", "Yes", "Yes"))

# 1379.0.0 Lamb/mutton intake; ordered factor
is.na(DF$X1379.0.0) <- DF$X1379.0.0 == -3 | DF$X1379.0.0 == -1
DF$X1379.0.0 <- factor(DF$X1379.0.0, 
                        levels= c("0", "1", "2", "3", "4", "5"),
                        labels= c("Never", "<1x/W", "1x/W", "2-4x/W", "5-6x/W", "1x or more/D"),
                        ordered = TRUE)

# 1389.0.0 Pork intake; ordered factor
is.na(DF$X1389.0.0) <- DF$X1389.0.0 == -3 | DF$X1389.0.0 == -1
DF$X1389.0.0 <- factor(DF$X1389.0.0, 
                        levels= c("0", "1", "2", "3", "4", "5"),
                        labels= c("Never", "<1x/W", "1x/W", "2-4x/W", "5-6x/W", "1x or more/D"),
                        ordered = TRUE)
DF$EatsPork <- factor(DF$X1389.0.0, 
                       levels= c("Never", "<1x/W", "1x/W", "2-4x/W", "5-6x/W", "1x or more/D"),
                       labels= c("No", "Yes", "Yes", "Yes", "Yes", "Yes"))

# 1408.0.0 Cheese intake; ordered factor
is.na(DF$X1408.0.0) <- DF$X1408.0.0 == -3 | DF$X1408.0.0 == -1
DF$X1408.0.0 <- factor(DF$X1408.0.0, 
                        levels= c("0", "1", "2", "3", "4", "5"),
                        labels= c("Never", "<1x/W", "1x/W", "2-4x/W", "5-6x/W", "1x or more/D"),
                        ordered = TRUE)
DF$EatsCheese <- factor(DF$X1408.0.0, 
                         levels= c("Never", "<1x/W", "1x/W", "2-4x/W", "5-6x/W", "1x or more/D"),
                         labels= c("No", "Yes", "Yes", "Yes", "Yes", "Yes"),
                         ordered = FALSE)

# 1418.0.0 Milk type used; factor
## may want to collapse some of these categories and make ordinal...
is.na(DF$X1418.0.0) <- DF$X1418.0.0 == -3 | DF$X1418.0.0 == -1
DF$X1418.0.0 <- factor(DF$X1418.0.0,
                        levels= c("1", "2", "3", "4", "5", "6"),
                        labels= c("Full cream", "Semi-skimmed", "Skimmed", "Soya", "Other type of milk", "Never/rarely have milk"))
#collapse full cream, semi-skimmed, skimmed = milk drinker; soya, other type = non-dairy milk drinker; never/rarely = no milk
DF$dairyMilk <- factor(DF$X1418.0.0,
                        levels = c("Full cream", "Semi-skimmed", "Skimmed", "Soya", "Other type of milk", "Never/rarely have milk"),
                        labels = c("Yes", "Yes", "Yes", "No", "No", "No"))

# 1438.0.0 Bread intake; integer
is.na(DF$X1438.0.0) <- DF$X1438.0.0 == -3 | DF$X1438.0.0 == -1
DF$X1438.0.0[DF$X1438.0.0 == -10] <- 0

# 1458.0.0 Cereal intake; integer
is.na(DF$X1458.0.0) <- DF$X1458.0.0 == -1 | DF$X1458.0.0 == -3
DF$X1458.0.0[DF$X1458.0.0 == -10] <- 0

# 1468.0.0 Cereal type; factor
is.na(DF$X1468.0.0) <- DF$X1468.0.0 == -1 | DF$X1468.0.0 == -3
DF$X1468.0.0 <- factor(DF$X1468.0.0, 
                        levels= c("1", "2", "3", "4", "5"),
                        labels= c("Bran cereal", "Biscuit cereal", "Oat cereal", "Muesli", "Other"))

# 1478.0.0 Salt added to food; ordered factor
is.na(DF$X1478.0.0) <- DF$X1478.0.0 == -3
DF$X1478.0.0 <- factor(DF$X1478.0.0,
                        levels= c("1", "2", "3", "4"),
                        labels= c("Never/rarely", "Sometimes", "Usually", "Always"),
                        ordered = TRUE)


# 1528.0.0 Water intake; integer
is.na(DF$X1528.0.0) <- DF$X1528.0.0 == -1 | DF$X1528.0.0 == -3
DF$X1528.0.0[DF$X1528.0.0 == -10] <- 0

# 1538.0.0 Major dietary changes in last 5 years; factor
is.na(DF$X1538.0.0) <- DF$X1538.0.0 == -3
DF$X1538.0.0 <- factor(DF$X1538.0.0, 
                        levels=c("0", "1", "2"),
                        labels=c("No", "Yes, because of illness", "Yes, because of other reasons"))

# 1548.0.0 Variation in diet; ordered factor
# "Does your diet vary much from week to week?"
is.na(DF$X1548.0.0) <- DF$X1548.0.0 == -3 | DF$X1548.0.0 == -1 
DF$X1548.0.0 <- factor(DF$X1548.0.0,
                        levels= c("1", "2", "3"),
                        labels= c("Never/rarely", "Sometimes", "Often"),
                        ordered = TRUE)

# 1558.0.0 Alcohol intake frequency; ordered factor
is.na(DF$X1558.0.0) <- DF$X1558.0.0 == -3
DF$X1558.0.0 <- factor(DF$X1558.0.0,
                        levels= c("6", "5", "4", "3", "2", "1"),
                        labels= c("Never", "Special occasions only", "1-3x/month", "1-2x/week", "3-4x/week", "Daily or almost daily"),
                        ordered=TRUE)

# 1568.0.0 Average weekly red wine intake
is.na(DF$X1568.0.0) <- DF$X1568.0.0 == -3 | DF$X1568.0.0 == -1 

# 1598.0.0 Average weekly spirits intake
is.na(DF$X1598.0.0) <- DF$X1598.0.0 == -3 | DF$X1598.0.0 == -1 

# 1677.0.0 Breastfed as baby; binary/factor
is.na(DF$X1677.0.0) <- DF$X1677.0.0 == -1 | DF$X1677.0.0 == -3
DF$X1677.0.0 <- factor(DF$X1677.0.0,
                        levels= c("1", "0"),
                        labels= c("Yes", "No"))

# 1687.0.0 Comparative body size at age 10; ordered factor
is.na(DF$X1687.0.0) <- DF$X1687.0.0 == -3 | DF$X1687.0.0 == -1
DF$X1687.0.0 <- factor(DF$X1687.0.0, 
                        levels= c("1","3","2"),
                        labels= c("Thinner", "About average", "Plumper"),
                        ordered=TRUE)

# 1697.0.0 Comparative height size at age 10; ordered factor
is.na(DF$X1697.0.0) <- DF$X1697.0.0 == -3 | DF$X1697.0.0 == -1
DF$X1697.0.0 <- factor(DF$X1697.0.0, 
                        levels= c("1", "3","2"),
                        labels= c("Shorter", "About average", "Taller"))

# 1980.0.0 Worrier / anxious feelings; factor/binary
is.na(DF$X1980.0.0) <- DF$X1980.0.0 == -1 | DF$X1980.0.0 == -3
DF$X1980.0.0 <- factor(DF$X1980.0.0,
                        levels= c("1", "0"),
                        labels= c("Yes", "No"))

# 2090.0.0 Seen doctor (GP) for nerves, anxiety, tension or depression; factor/binary
is.na(DF$X2090.0.0) <- DF$X2090.0.0 == -1 | DF$X2090.0.0 == -3
DF$X2090.0.0 <- factor(DF$X2090.0.0,
                        levels= c("1", "0"),
                        labels= c("Yes", "No"))

# 2100.0.0 Seen a psychiatrist for nerves, anxiety, tension or depression; factor/binary
is.na(DF$X2100.0.0) <- DF$X2100.0.0 == -1 | DF$X2100.0.0 == -3
DF$X2100.0.0 <- factor(DF$X2100.0.0,
                        levels= c("1", "0"),
                        labels= c("Yes", "No"))

# 2178.0.0 Overall health rating; ordered factor
is.na(DF$X2178.0.0) <- DF$X2178.0.0 == -3 | DF$X2178.0.0 == -1
DF$X2178.0.0 <- factor(DF$X2178.0.0, 
                        levels= c("4", "3", "2", "1"),
                        labels= c("Poor", "Fair", "Good", "Excellent"),
                        ordered=TRUE)

# BINARIZED 2178.0.0 Overall health rating; factor
is.na(DF$X2178.0.0) <- DF$X2178.0.0 == -3 | DF$X2178.0.0 == -1
DF$health <- factor(DF$X2178.0.0, 
                     levels= c("Poor", "Fair", "Good", "Excellent"),
                     labels= c("Poor", "Fair-Excellent", "Fair-Excellent", "Fair-Excellent"))


# 2188.0.0 Long-standing illness, disability or infirmity; factor/binary
is.na(DF$X2188.0.0) <- DF$X2188.0.0 == -1 | DF$X2188.0.0 == -3
DF$X2188.0.0 <- factor(DF$X2188.0.0,
                        levels= c("1", "0"),
                        labels= c("Yes", "No"))

# 2463.0.0 Fractured/broken bones in last 5 years; factor/binary
is.na(DF$X2463.0.0) <- DF$X2463.0.0 == -3 | DF$X2463.0.0 == -1
DF$X2463.0.0 <- factor(DF$X2463.0.0, 
                        levels=c("0", "1"),
                        labels=c("No", "Yes"))

# 6138.0.0 Qualifications; factor                          
is.na(DF$X6138.0.0) <- DF$X6138.0.0 == -3
DF$X6138.0.0 <- factor(DF$X6138.0.0,
                        levels=c("1", "2", "3", "4", "5", "6", "-7"),
                        labels= c("College or University degree", "A levels", "O levels", "CSEs", "NVQ/HND/HNC", "Other professional", "None listed"))

# 6144.0.0 Never eat eggs, dairy, wheat, sugar; factor
is.na(DF$X6144.0.0) <- DF$X6144.0.0 == -3
DF$X6144.0.0 <- factor(DF$X6144.0.0,
                        levels=c("1", "2", "3", "4", "5"),
                        labels=c("Eggs/containing eggs", "Dairy products", "Wheat products", "Sugar/containing sugar", "I eat all of the above"))

DF$ExcludesDairy <- factor(DF$X6144.0.0,
                            levels=c("Eggs/containing eggs", "Dairy products", "Wheat products", "Sugar/containing sugar", "I eat all of the above"),
                            labels=c("No", "Yes", "No", "No", "No"))


# 6164.0.0 Types of physical activity in last 4 weeks; factor
is.na(DF$X6164.0.0) <- DF$X6164.0.0 == -7 | DF$X6164.0.0 == -3
DF$X6164.0.0 <- factor(DF$X6164.0.0, 
                        levels=c("1", "2", "3", "4", "5"),
                        labels=c("Walking for pleasure", "Other exercises", "Strenuous sports", "Light DIY", "Heavy DIY"))

# 20116.0.0 Smoking status; factor
is.na(DF$X20116.0.0) <- DF$X20116.0.0 == -3
DF$X20116.0.0 <- factor(DF$X20116.0.0,
                         levels= c("0","1","2"),
                         labels =c("Never", "Previous", "Current"))

# 20117.0.0 Alcohol drinker status; factor
is.na(DF$X20117.0.0) <- DF$X20117.0.0 == -3
DF$X20117.0.0 <- factor(DF$X20117.0.0,
                         levels= c("0","1","2"),
                         labels =c("Never", "Previous", "Current"))

# 20127.0.0 Neuroticism score; integer (not numeric)
DF$X20127.0.0 <- as.integer(DF$X20127.0.0)


# 21000.0.0 Self-reported ethnicity; factor
DF$X21000.0.0 <- factor(DF$X21000.0.0,
                         levels=c("3001", "3002", "3003", "2003", "3004"),
                         labels=c("Indian", "Pakistani", "Bangladeshi", "White and Asian", "Any Other Asian"))
names(DF)[names(DF) == 'X21000.0.0'] <- 'Ethnicity'

# 21003.0.0 Age at assessment; integer
DF$X21003.0.0 <- as.integer(DF$X21003.0.0)

# 22033.0.0 Summed days activity; integer
#Sum of days performing walking, moderate and vigorous activity.
DF$X22033.0.0 <- as.integer(DF$X22033.0.0)

# 22034.0.0 Summed minutes activity; integer
DF$X22034.0.0 <- as.integer(DF$X22034.0.0)

# 22035.0.0 Above moderate/vigorous recommendation; factor/binary
DF$X22035.0.0 <- factor(DF$X22035.0.0, 
                         levels=c("0", "1"),
                         labels=c("No", "Yes"))

# 22036.0.0 Above moderate/vigorous/walking recommendation; factor/binary
DF$X22036.0.0 <- factor(DF$X22036.0.0, 
                         levels=c("0", "1"),
                         labels=c("No", "Yes"))

# 22037.0.0 MET minutes per week for walking; numeric
DF$X22037.0.0 <- as.numeric(DF$X22037.0.0)

# 22038.0.0 MET minutes per week for moderate activity; numeric
DF$X22038.0.0 <- as.numeric(DF$X22038.0.0)

# 22039.0.0 MET minutes per week for vigorous activity; numeric
DF$X22039.0.0 <- as.numeric(DF$X22039.0.0)

# 1647.0.0 Country of birth (UK/elsewhere); categorical
is.na(DF$X1647.0.0) <- DF$X1647.0.0 == -3
is.na(DF$X1647.0.0) <- DF$X1647.0.0 == -1
DF$X1647.0.0 <- factor(DF$X1647.0.0,
                        levels=c("1", "2", "3", "4", "5", "6"),
                        labels=c("England", "Wales", "Scotland", "Northern Ireland", "Republic of Ireland", "Elsewhere"))

# 1647 BINARIZED
DF$Born.UK.Elsewhere <- factor(DF$X1647.0.0,
                                levels = c("England", "Wales", "Scotland", "Northern Ireland", "Republic of Ireland", "Elsewhere"),
                                labels = c("UK", "UK", "UK", "UK", "UK", "Elsewhere"))
# UK Elsewhere 
# 977      6986 

# 1787.0.0 maternal smoking around birth; categorical
is.na(DF$X1787.0.0) <- DF$X1787.0.0 == -3
is.na(DF$X1787.0.0) <- DF$X1787.0.0 == -1
DF$X1787.0.0 <- factor(DF$X1787.0.0,
                        levels = c("1","2"),
                        labels = c("Yes", "No"))

# 20115.0.0 	Country of Birth (non-UK origin); categorical
table(DF$X20115.0.0)
DF$X20115.0.0 <- factor(DF$X20115.0.0,
                         levels = c("109", "110", "112", "113", "114", "115", "118", "124", "127", "128", "129", "131", "133", "136", "137", "141", "142", "143", "144", "146", "149", "151", "152", "201", "202", "203", "205", "206", "207", "211", "212", "213", "214", "215", "219", "221", "222", "226", "229", "232", "234", "235", "236", "238", "239", "241", "242", "247", "251", "312", "318", "320", "321", "326", "333", "336", "343", "354", "403", "501", "503", "506", "603", "609", "613"),
                         labels = c("Caribbean", "Central African Republic", "Congo", "Djibouti", "East Africa", "Egypt", "Ethiopia", "Kenya", "Libya", "Madagascar", "Malawi", "Mauritius", "Mozambique", "Nigeria", "Rwanda", "Sierra Leone", "Somalia", "South Africa", "Sudan", "Tanzania", "Uganda", "Zambia", "Zimbabwe", "Afghanistan", "Bahrain", "Bangladesh", "British Indian Ocean Territory", "Brunei", "Myanmar (Burma)", "Hong Kong", "India", "Indonesia", "Iran", "Iraq", "Kashmir", "Kuwait", "Kyrgyzstan", "Malaysia", "Nepal", "Pakistan", "Pattaya", "Phillipines", "Qatar", "Saudi Arabia", "Singapore", "Sri Lanka", "Syria", "Turkmenistan", "Yemen", "Cyprus", "France", "Germany", "Gibraltar", "Italy", "Malta", "Netherlands", "Russia", "United Kingdom", "Aruba", "Samoa", "Fiji", "Pacific Islands", "Brazil", "The Guianas", "South Georgia & the South Sandwich Islands"))

#female specific:
# Number of live births DF$X2734.0.0
#-3	Prefer not to answer

# Age at first live birth DF$X2754.0.0
#-4	Do not remember
#-3	Prefer not to answer
is.na(DF$X2754.0.0) <- DF$X2754.0.0 == -4 | DF$X2754.0.0 == -3

#2734.0.0 Number of live births
is.na(DF$X2734.0.0) <- DF$X2734.0.0 == -3
DF$X2734.0.0[is.na(DF$X2734.0.0)] <- 0