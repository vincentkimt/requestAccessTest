public class Assignment3Apex {
    
    public void dateDiff(Date startDate,Date endDate){
        Datetime dt1 = Date.newInstance(startDate.year(),startDate.month(),startDate.day());
        Datetime dt2 = Date.newInstance(endDate.year(),endDate.month(),endDate.day());
        Integer noOfDayBetween = startDate.daysBetween(endDate);
        if(noOfDayBetween > 6){
            Map<String,Integer> countOfDays = new Map<String,Integer>();
            countOfDays.put('Mon',0);countOfDays.put('Tue',0);countOfDays.put('Wed',0);countOfDays.put('Thu',0);
            countOfDays.put('Fri',0);countOfDays.put('Sat',0);countOfDays.put('Sun',0);     
            
            if(dt2.format('E') != 'Mon'){
                while(dt2.format('E') != 'Mon') {
                    countOfDays.put(dt2.format('E'),countOfDays.get(dt2.format('E'))+1);
                    
                    dt2 = dt2-1;
                }
            }
            if(dt1.format('E') != 'Mon'){
                While(dt1.format('E')!='Mon'){
                    
                    countOfDays.put(dt1.format('E'),countOfDays.get(dt1.format('E'))+1);
                    dt1 = dt1+1;
                    
                }
            }
            Date dt_1=dt1.date();
            Date dt_2=dt2.date();
            Integer daysBetween= (dt_1.daysBetween(dt_2) - (Integer)((dt_1.daysBetween(dt_2)/7)*2));//14-4
            
            Set<String> keyOfMap = countOfDays.keySet();
            Integer daysToAdd = 0;
            keyOfMap.remove('Sat');
            keyOfMap.remove('Sun');
            for(String key : keyOfMap){
                
                daysToAdd = daysToAdd + countOfDays.get(key);
                
            }
            
            System.debug('No Of Working Days :'+ (daysBetween+daysToAdd+1));
            
            
        }
        else if(noOfDayBetween == 6){
            
            Integer daysBetween= noOfDayBetween-1;
            System.debug('No Of Working Days : '+daysBetween);
            
        }
        else if(noOfDayBetween < 6){
            Integer countOfDays = 0;
            while (dt1 < dt2) {
                if (dt1.format('E') != 'Sat' && dt1.format('E') != 'Sun') {
                    countOfDays++;
                }
                dt1 = dt1.addDays(1);
            }
            
            System.debug('No Of Working Days : '+ countOfDays);
        }
    }
}