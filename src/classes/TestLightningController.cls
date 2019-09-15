/**
 * Created by Pavel on 05.09.2019.
 */

public with sharing class TestLightningController {
    @AuraEnabled
    public static List<Account> getAccList () {
        List<Account> accList = [
                SELECT  Id,
                        Name/*,
											(
												SELECT  Id,
														Name,
														FirstName,
														LastName
												FROM    Contacts
											)*/
                FROM    Account
                LIMIT   15
        ];
        return accList;
    }
}