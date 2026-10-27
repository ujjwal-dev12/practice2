//future

@future
public static void doWork(Set<Id> ids){
    //custom 
}


//queuable

public class  MyQueueable implements Queueable {
    public void execute (Queueable context context){
        //custom
    }
}

System.enqueueJob(new MyQueueable());


//batch
global class MyBatch implements Database.Batchable<SObject>{

    global Database.QueryLocator start(Database.BatchableContext bc){
        return Database.getQueryLocator([
            //
        ])
    }

    global void execute (Database.BatchableContext bc, .. ){
        //chunk
    }

    global void finish (Database.BatchableContext bc){

    }
}

Database.executeBatch(new MyBatch(),200);


//schedule 


global class MyScheduler implements Schedulable{
    global void execute(SchedulableContext sc){
        //logic
    }
}

String cron =  '0 0 9 * * ?';

System.schedule('Daily Job',cron,new MyScheduler());












































