global class ScheduleFromOrders implements Schedulable
{
     public static String sched = '0 0 0 * *?';
    
    global static String scheduleOrder(){
        ScheduleFromOrders sc = new ScheduleFromOrders();
        return System.schedule('DeletedHourly', sched, sc);
    }
    global void execute(SchedulableContext sc)
    {
        ScheduleremoveallOrders orders = new ScheduleremoveallOrders();
        database.executeBatch(orders);
     
    }
}