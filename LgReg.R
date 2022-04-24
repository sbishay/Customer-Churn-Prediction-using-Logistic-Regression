rm(list = ls())

setwd("C:\\Users\\subha\\OneDrive\\Desktop\\DA\\R\\Logistic Case Study")

dataAll = read.csv("Proactive Attrition Management-Logistic Regression Case Study.csv", header = TRUE) #FULL DATA
View(dataAll)

str(dataAll)
prop.table(table(dataAll$CHURN))

#dropping unimportant variable according to our business problem

dataAll$CSA=NULL
dataAll$CUSTOMER=NULL


#Descriptive analysis
var_Summ=function(x){
  if(class(x)=="numeric"){
    Var_Type=class(x)
    n=length(x)
    nmiss=sum(is.na(x))
    mean=mean(x,na.rm=T)
    std=sd(x,na.rm=T)
    var=var(x,na.rm=T)
    min=min(x,na.rm=T)
    p1=quantile(x,0.01,na.rm=T)
    p5=quantile(x,0.05,na.rm=T)
    p10=quantile(x,0.1,na.rm=T)
    q1=quantile(x,0.25,na.rm=T)
    q2=quantile(x,0.5,na.rm=T)
    q3=quantile(x,0.75,na.rm=T)
    p90=quantile(x,0.9,na.rm=T)
    p95=quantile(x,0.95,na.rm=T)
    p99=quantile(x,0.99,na.rm=T)
    max=max(x,na.rm=T)
    UC1=mean(x,na.rm=T)+3*sd(x,na.rm=T)
    LC1=mean(x,na.rm=T)-3*sd(x,na.rm=T)
    UC2=quantile(x,0.99,na.rm=T)
    LC2=quantile(x,0.01,na.rm=T)
    iqr=IQR(x,na.rm=T)
    UC3=q3+1.5*iqr
    LC3=q1-1.5*iqr
    ot1=max>UC1 | min<LC1 
    ot2=max>UC2 | min<LC2 
    ot3=max>UC3 | min<LC3
    return(c(Var_Type=Var_Type, n=n,nmiss=nmiss,mean=mean,std=std,var=var,min=min,p1=p1,p5=p5,p10=p10,q1=q1,q2=q2,q3=q3,p90=p90,p95=p95,p99=p99,max=max,ot_m1=ot1,ot_m2=ot2,ot_m2=ot3, IQR=iqr,UC1=UC1,LC1=LC1))
  }
  else{
    Var_Type=class(x)
    n=length(x)
    nmiss=sum(is.na(x))
    fre=table(x)
    prop=prop.table(table(x))
    
    return(c(Var_Type=Var_Type, n=n,nmiss=nmiss,freq=fre,proportion=prop))
  }
}

#numerical variables
num_var = sapply(dataAll, is.numeric)
#View(num_var)


#apply defined function
num_data = t(data.frame(apply(dataAll[num_var], 2, var_Summ)))
View(num_data)
write.csv(num_data,"diag.csv")



#missing values

missrecords =  dataAll[!complete.cases(dataAll),]
missrec= nrow(missrecords)/nrow(dataAll)
missrec   

#Since 45% of data have missing values hence imputing these values with mean as deleting these records is not an option here.


dataAll$REVENUE[is.na(dataAll$REVENUE)]=58.8539614010814
dataAll$MOU[is.na(dataAll$MOU)]=525.728392370572
dataAll$RECCHRGE[is.na(dataAll$RECCHRGE)]=46.8764916491367
dataAll$DIRECTAS[is.na(dataAll$DIRECTAS)]=0.894801146390705
dataAll$OVERAGE[is.na(dataAll$OVERAGE)]=40.0953598000875
dataAll$ROAM[is.na(dataAll$ROAM)]=1.22152616792083
dataAll$CHANGEM[is.na(dataAll$CHANGEM)]=-10.8464614076122
dataAll$CHANGER[is.na(dataAll$CHANGER)]=-1.20592557941739
dataAll$AGE1[is.na(dataAll$AGE1)]=31.3751128175007
dataAll$AGE2[is.na(dataAll$AGE2)]=21.1577152844434
dataAll$PHONES[is.na(dataAll$PHONES)]=1.80861695239704
dataAll$MODELS[is.na(dataAll$MODELS)]=1.56179095234074
dataAll$EQPDAYS[is.na(dataAll$EQPDAYS)]=380.265630718126


# Outlier capping with p95 and p5

#outliers - Lower Limit
dataAll$REVENUE[dataAll$REVENUE <15.515]=15.515
dataAll$MOU[dataAll$MOU <20.415]=20.415
dataAll$RECCHRGE[dataAll$RECCHRGE <10]= 10
dataAll$CHANGEM[dataAll$CHANGEM < -376.25]=-376.25
dataAll$CHANGER[dataAll$CHANGER < -47.5]=-47.5
dataAll$MONTHS[dataAll$MONTHS <7]=7
dataAll$ACTVSUBS[dataAll$ACTVSUBS <1]=1
dataAll$EQPDAYS[dataAll$EQPDAYS <42]=42

#outliers - Upper Limit
dataAll$REVENUE[dataAll$REVENUE >135.39]=135.39
dataAll$MOU[dataAll$MOU >1580.25]=1580.25
dataAll$RECCHRGE[dataAll$RECCHRGE > 85]= 85
dataAll$DIRECTAS[dataAll$DIRECTAS >4.21]=4.21
dataAll$OVERAGE[dataAll$OVERAGE >190.375]=190.375
dataAll$ROAM[dataAll$ROAM >5.09]=5.09
dataAll$CHANGEM[dataAll$CHANGEM > 345.25]=345.25
dataAll$CHANGER[dataAll$CHANGER > 46.218]=46.218
dataAll$AGE1[dataAll$AGE1 >62]=62
dataAll$AGE2[dataAll$AGE2 >62]=62
dataAll$DROPVCE[dataAll$DROPVCE >22]=22
dataAll$BLCKVCE[dataAll$BLCKVCE >17.33]=17.33
dataAll$UNANSVCE[dataAll$UNANSVCE >97.67]=97.67
dataAll$CUSTCARE[dataAll$CUSTCARE >9.33]=9.33
dataAll$THREEWAY[dataAll$THREEWAY >1.33]=1.33
dataAll$MOUREC[dataAll$MOUREC >440.938]=440.938
dataAll$OUTCALLS[dataAll$OUTCALLS >90.33]=90.33
dataAll$INCALLS[dataAll$INCALLS >35.67]=35.67
dataAll$PEAKVCE[dataAll$PEAKVCE >279.67]=279.67
dataAll$OPEAKVCE[dataAll$OPEAKVCE >242]=242
dataAll$DROPBLK[dataAll$DROPBLK >35.33]=35.33
dataAll$CALLWAIT[dataAll$CALLWAIT >8.67]=8.67
dataAll$MONTHS[dataAll$MONTHS >37]=37
dataAll$UNIQSUBS[dataAll$UNIQSUBS >3]=3
dataAll$ACTVSUBS[dataAll$ACTVSUBS >2]=2
dataAll$EQPDAYS[dataAll$EQPDAYS >866]=866
dataAll$SETPRC[dataAll$SETPRC >149.99]=149.99
dataAll$PHONES[dataAll$PHONES >4]=4
dataAll$MODELS[dataAll$MODELS >3]=3


## Correlation matrix

corrm= cor(dataAll[,num_var]) 
#View(corrm)
write.csv(corrm, file = "corrm.csv")



# Categorical Variable(Significance Test)

tab = xtabs(~CHILDREN + CHURN, data = dataAll)         # not significant         
chisq.test(tab)
tab = xtabs(~CREDITA + CHURN, data = dataAll)                  
chisq.test(tab)
tab = xtabs(~CREDITAA + CHURN, data = dataAll)                  
chisq.test(tab)
tab = xtabs(~CREDITB + CHURN, data = dataAll)                  
chisq.test(tab)
tab = xtabs(~CREDITC + CHURN, data = dataAll)                  
chisq.test(tab)
tab = xtabs(~CREDITDE + CHURN, data = dataAll)                  
chisq.test(tab)
tab = xtabs(~CREDITGY + CHURN, data = dataAll)         # not significant         
chisq.test(tab)
tab = xtabs(~CREDITZ + CHURN, data = dataAll)         # not significant         
chisq.test(tab)
tab = xtabs(~PRIZMRUR + CHURN, data = dataAll)                  
chisq.test(tab)
tab = xtabs(~PRIZMUB + CHURN, data = dataAll)                 
chisq.test(tab)
tab = xtabs(~PRIZMTWN + CHURN, data = dataAll)                 
chisq.test(tab)
tab = xtabs(~REFURB + CHURN, data = dataAll)                 
chisq.test(tab)
tab = xtabs(~WEBCAP + CHURN, data = dataAll)                 
chisq.test(tab)
tab = xtabs(~TRUCK + CHURN, data = dataAll)            # not significant     
chisq.test(tab)
tab = xtabs(~RV + CHURN, data = dataAll)                 # not significant
chisq.test(tab)
tab = xtabs(~OCCPROF + CHURN, data = dataAll)            # not significant     
chisq.test(tab)
tab = xtabs(~OCCCLER + CHURN, data = dataAll)            # not significant      
chisq.test(tab)
tab = xtabs(~OCCCRFT + CHURN, data = dataAll)            # not significant     
chisq.test(tab)
tab = xtabs(~OCCSTUD + CHURN, data = dataAll)             # not significant    
chisq.test(tab)
tab = xtabs(~OCCHMKR + CHURN, data = dataAll)             # not significant     
chisq.test(tab)
tab = xtabs(~OCCRET + CHURN, data = dataAll)                 
chisq.test(tab)
tab = xtabs(~OCCSELF + CHURN, data = dataAll)              # Not Significant   
chisq.test(tab)
tab = xtabs(~OWNRENT + CHURN, data = dataAll)                 
chisq.test(tab)
tab = xtabs(~MARRYUN + CHURN, data = dataAll)                 
chisq.test(tab)
tab = xtabs(~MARRYYES + CHURN, data = dataAll)             # Not Significant    
chisq.test(tab)
tab = xtabs(~MARRYNO + CHURN, data = dataAll)                 
chisq.test(tab)
tab = xtabs(~MAILORD + CHURN, data = dataAll)                 
chisq.test(tab)
tab = xtabs(~MAILRES + CHURN, data = dataAll)                 
chisq.test(tab)
tab = xtabs(~MAILFLAG + CHURN, data = dataAll)               #Not Significant  
chisq.test(tab)
tab = xtabs(~TRAVEL + CHURN, data = dataAll)                 # Not Significant
chisq.test(tab)
tab = xtabs(~PCOWN + CHURN, data = dataAll)                 # Not Significant
chisq.test(tab)
tab = xtabs(~CREDITCD + CHURN, data = dataAll)                 
chisq.test(tab)
tab = xtabs(~NEWCELLY + CHURN, data = dataAll)                 
chisq.test(tab)
tab = xtabs(~NEWCELLN + CHURN, data = dataAll)               # Not Significant  
chisq.test(tab)
tab = xtabs(~INCMISS + CHURN, data = dataAll)                 
chisq.test(tab)
tab = xtabs(~INCOME + CHURN, data = dataAll)                 
chisq.test(tab)
tab = xtabs(~MCYCLE + CHURN, data = dataAll)                 # Not Significant
chisq.test(tab)
tab = xtabs(~SETPRCM + CHURN, data = dataAll)                
chisq.test(tab)

require(MASS)
step = stepAIC(glm(CHURN ~SETPRCM+
                   INCOME+
                   INCMISS+
                   NEWCELLY+
                   CREDITCD+
                   MAILRES+
                   MAILORD+
                   MARRYNO+
                   MARRYUN+
                   OWNRENT+
                   OCCRET+
                   WEBCAP+
                   REFURB+
                 PRIZMTWN+
                   PRIZMUB+
                   PRIZMRUR+
                   CREDITDE+
                   CREDITC+
                   CREDITB+
                   CREDITAA+
                   CREDITA+
                   REVENUE+
                   MOU+
                   RECCHRGE+
                   DIRECTAS+
                   OVERAGE+
                   ROAM+
                   CHANGEM+
                   CHANGER+
                   DROPVCE+
                   BLCKVCE+
                   UNANSVCE+
                   CUSTCARE+
                   THREEWAY+
                   MOUREC+
                   OUTCALLS+
                   INCALLS+
                   PEAKVCE+
                   OPEAKVCE+
                   CALLFWDV+
                   DROPBLK+
                   CALLWAIT+
                   MONTHS+
                   UNIQSUBS+
                   ACTVSUBS+
                   PHONES+
                   MODELS+
                   EQPDAYS+
                   AGE1+
                   AGE2+
                   SETPRC,
                 data =dataAll),
               direction = "both")




#Transform numeric variables

dataAll$REVENUE1 = log(dataAll$REVENUE)
hist(dataAll$REVENUE1)

dataAll$MOU1 = log(dataAll$MOU)
hist(dataAll$MOU1)

dataAll$RECCHRGE1 = log(dataAll$RECCHRGE)
hist(dataAll$RECCHRGE1)

dataAll$MONTHS1 = sqrt(dataAll$MONTHS)
hist(dataAll$MONTHS1)

dataAll$UNIQSUBS1 = log(dataAll$UNIQSUBS)
hist(dataAll$UNIQSUBS1)

dataAll$ACTVSUBS1 = log(dataAll$ACTVSUBS)
hist(dataAll$ACTVSUBS1)

dataAll$PHONES1 = sqrt(dataAll$PHONES)
hist(dataAll$PHONES1)

dataAll$EQPDAYS1 = log(dataAll$EQPDAYS)
hist(dataAll$EQPDAYS1)

dataAll$SETPRC1 = sqrt(dataAll$SETPRC)
hist(dataAll$SETPRC1)

dataAll$CALLWAIT1 = sqrt(dataAll$CALLWAIT)
hist(dataAll$CALLWAIT1)

dataAll$OPEAKVCE1 = sqrt(dataAll$OPEAKVCE)
hist(dataAll$OPEAKVCE1)

dataAll$PEAKVCE1 = sqrt(dataAll$PEAKVCE)
hist(dataAll$PEAKVCE1)

dataAll$INCALLS1 = sqrt(dataAll$INCALLS)
hist(dataAll$INCALLS1)

dataAll$THREEWAY1 = sqrt(dataAll$THREEWAY)
hist(dataAll$THREEWAY1)

dataAll$CUSTCARE1 = sqrt(dataAll$CUSTCARE)
hist(dataAll$CUSTCARE1)

dataAll$BLCKVCE1 = sqrt(dataAll$BLCKVCE)
hist(dataAll$BLCKVCE1)

dataAll$DROPVCE1 = sqrt(dataAll$DROPVCE)
hist(dataAll$BLCKVCE1)

dataAll$CHANGER1 = exp(dataAll$CHANGER)
hist(dataAll$CHANGER1)

dataAll$CHANGEM1 = exp(dataAll$CHANGEM)
hist(dataAll$CHANGER1)

dataAll$ROAM1 = exp(dataAll$ROAM)
hist(dataAll$ROAM1)

dataAll$AGE11 = sqrt(dataAll$AGE1)
hist(dataAll$AGE11)

dataAll$OVERAGE1 = sqrt(dataAll$OVERAGE)
hist(dataAll$OVERAGE1)


####################################

# splitting data
dev =  dataAll[ dataAll$CALIBRAT == 1,]
#View(dev)

val =  dataAll[ dataAll$CALIBRAT == 0,]
#View(val)
val$CHURNDEP = NULL

fit_model = glm(CHURN ~ INCOME + INCMISS + NEWCELLY + CREDITCD + MAILRES + MARRYNO + 
                   WEBCAP + REFURB + PRIZMTWN + PRIZMUB + PRIZMRUR + CREDITDE + 
                   CREDITC + CREDITB + CREDITAA + REVENUE1 + MOU1 + RECCHRGE1 + 
                   OVERAGE1 + ROAM1 + CHANGEM1 + CHANGER1 + DROPVCE1 + BLCKVCE1 + 
                   CUSTCARE1 + THREEWAY1 + INCALLS1 + PEAKVCE1 + OPEAKVCE1 + CALLWAIT1 + 
                   MONTHS1 + UNIQSUBS1 + ACTVSUBS1 + PHONES1 + EQPDAYS1 + AGE11 + 
                   SETPRC1,data=dev,family = binomial(logit))

summary(fit_model)

source("Concordance.R")
Concordance(fit_model)

final_model = glm(CHURN ~ INCOME + INCMISS + NEWCELLY + MAILRES + MARRYNO + 
                     WEBCAP + REFURB + CREDITDE + 
                     CREDITC + CREDITB + CREDITAA + REVENUE1 + MOU1 + RECCHRGE1 + 
                     OVERAGE1 + ROAM1 +  DROPVCE1 + BLCKVCE1 + 
                     THREEWAY1 + INCALLS1 + PEAKVCE1 + CALLWAIT1 + 
                     MONTHS1 + UNIQSUBS1 + ACTVSUBS1 + EQPDAYS1 + AGE11 + 
                     SETPRC1,data=dev,family = binomial(logit))

summary(final_model)

Concordance(final_model)                    # 0.6181 concordance

####################################### Development Dataset ###########################################

dev1= cbind(dev, Prob=predict(final_model, type="response")) 
#View(dev1)

#create deciles

decLocations = quantile(dev1$Prob, probs = seq(0.1,0.9,by=0.1))
dev1$decile = findInterval(dev1$Prob,c(-Inf,decLocations, Inf))
#View(dev1)

require(dplyr)
dev1$decile=factor(dev1$decile)
str(dev1)

decile_grp = group_by(dev1,decile)
decile_summ_dev = summarize(decile_grp, total_cnt=n(), min_prob=min(p=Prob), max_prob=max(Prob), default_cnt = sum(CHURN), non_default_cnt=total_cnt -default_cnt)
decile_summ_dev = arrange(decile_summ_dev, desc(decile))

View(decile_summ_dev)

write.csv(decile_summ_dev,"dev1.csv")

#Decile Analysis

require(sqldf)
fit_dev_DA = sqldf("select decile, min(Prob) as Min_prob,
                      max(Prob) as max_prob,
                      sum(CHURNDEP) as default_cnt
                      from dev1
                      group by decile
                      order by decile desc")
View(fit_dev_DA)

############################################### Validation Dataset ###################################################

val1 = cbind(val,prob=predict(final_model,val,type = "response"))
View(val1)

#deciles
delocations1 = quantile(val1$prob, probs = seq(0.1,0.9,by=0.1), na.rm = TRUE)
val1$decile = findInterval(val1$prob, c(-Inf,delocations1,Inf))

View(val1)

val1$decile = factor(val1$decile)
str(val1)

decile_grp = group_by(val1,decile)
decile_summ1 = summarize(decile_grp, total_cnt = n(), min_prob = min(prob), max_prob = max(prob), default_cnt=sum(CHURN), non_default_cnt=total_cnt - default_cnt)
View(decile_summ1)
write.csv(decile_summ1, "val2.csv")

fit_test = sqldf("select decile, min(prob) as min_prob,count(prob) as total,
                   max(prob) as max_prob,
                   sum(CHURN) as default_cnt
                   from val1
                   group by decile
                   order by decile desc")
View(fit_test)

########################################################################################################################