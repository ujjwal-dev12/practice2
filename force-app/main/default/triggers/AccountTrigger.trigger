trigger AccountTrigger on Account (before insert, before update) {

    for (Account acc : Trigger.new){
      if(acc.AnnualRevenue !=null && acc.AnnualRevenue>1000000){
        acc.High_Value__c = true;
      } else {
        acc.High_Value__c = false;
      }
    }
}