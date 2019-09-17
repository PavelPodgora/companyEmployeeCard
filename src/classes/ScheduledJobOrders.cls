global class ScheduledJobOrders implements Schedulable {
    
    public static String sched = '0 0 * * * ?';
    global static String scheduleMe()
    {
        ScheduledJobOrders sc = new ScheduledJobOrders();
        return System.schedule('Hourly', sched, sc);
    }
    global void execute(SchedulableContext sc)
    {
     OrdersForContacts order = new OrdersForContacts();
        database.executebatch(order);

    }
    
}