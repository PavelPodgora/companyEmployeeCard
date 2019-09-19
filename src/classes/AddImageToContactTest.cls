/**
 * Created by Pavel on 19.09.2019.
 */
@isTest(SeeAllData=false)
public with sharing class AddImageToContactTest {
    @isTest static void testPositiv() {
        Contact testCon = new Contact(LastName = 'Test1');
        insert testCon;

        Attachment testAtt = new Attachment();
        testAtt.Name = 'Tess.png';
        testAtt.ParentId = testCon.Id;
        testAtt.body = Blob.valueOf('AttachmentBody.png');


        //AddImageToContact.attachment = testAtt;

        ApexPages.StandardController sc = new ApexPages.StandardController(testCon);
        AddImageToContact testExtension = new AddImageToContact(sc);
        testExtension.attachment = testAtt;

        PageReference testRef = new PageReference('/apex/EmployeeCardImage');
        testRef.getParameters().put('id', sc.getId());
        testRef.setRedirect(true);
        PageReference result = testExtension.upload();

        System.assert(result.getUrl() == null);
    }
    @isTest static void testNewAttachment() {
        Contact testCon = new Contact(LastName = 'Test1');
        insert testCon;

        //AddImageToContact.attachment = testAtt;

        ApexPages.StandardController sc = new ApexPages.StandardController(testCon);
        AddImageToContact testExtension = new AddImageToContact(sc);

        PageReference testRef = new PageReference('/apex/EmployeeCardImage');
        testRef.getParameters().put('id', sc.getId());
        testRef.setRedirect(true);
        PageReference result = testExtension.upload();

        System.assertEquals(result.getUrl(), testRef.getUrl());
    }
    @isTest static void testDmlAttachment() {
        Contact testCon = new Contact(LastName = 'Test1');
        insert testCon;

        Attachment testAtt = new Attachment();
        testAtt.Name = 'Test Attachment';
        testAtt.ParentId = testCon.Id;
        testAtt.body = Blob.valueOf('Attachment Body');
        testAtt.OwnerId = '12345678';

        //AddImageToContact.attachment = testAtt;

        ApexPages.StandardController sc = new ApexPages.StandardController(testCon);
        AddImageToContact testExtension = new AddImageToContact(sc);
        testExtension.attachment = testAtt;

        PageReference testRef = new PageReference('/apex/EmployeeCardImage');
        testRef.getParameters().put('id', sc.getId());
        testRef.setRedirect(true);
        PageReference result = testExtension.upload();

        System.assertEquals(result.getUrl(), testRef.getUrl());
    }
    @isTest static void testAttachment() {
        Contact testCon = new Contact(LastName = 'Test1');
        insert testCon;

        Attachment testAtt = new Attachment();
        testAtt.Name = 'Test Attachment';
        testAtt.ParentId = testCon.Id;
        testAtt.body = Blob.valueOf('Attachment Body');

        //AddImageToContact.attachment = testAtt;

        ApexPages.StandardController sc = new ApexPages.StandardController(testCon);
        AddImageToContact testExtension = new AddImageToContact(sc);
        testExtension.attachment = testAtt;

        PageReference testRef = new PageReference('/apex/EmployeeCardImage');
        testRef.getParameters().put('id', sc.getId());
        testRef.setRedirect(true);
        PageReference result = testExtension.upload();

        System.assertEquals(result.getUrl(), testRef.getUrl());
    }

    @isTest static void testAttachmentGet() {
        Contact testCon = new Contact(LastName = 'Test1');
        insert testCon;

        Attachment testAtt = new Attachment();
        testAtt.Name = 'Test Attachment';
        testAtt.ParentId = testCon.Id;
        testAtt.body = Blob.valueOf('Attachment Body');


        ApexPages.StandardController sc = new ApexPages.StandardController(testCon);
        AddImageToContact testExtension = new AddImageToContact(sc);
        testExtension.attachment = testAtt;
        system.debug('Att' + testExtension.getAttachments());
        System.assertEquals(testExtension.getAttachments(), null);
    }

    @isTest static void testAttachmentGetNull() {
        Contact testCon = new Contact(LastName = 'Test1');
        insert testCon;
        ApexPages.StandardController sc = new ApexPages.StandardController(testCon);
        AddImageToContact testExtension = new AddImageToContact(sc);
        testExtension.attachment = null;
        System.assert(testExtension.getAttachments().isEmpty());
    }
}