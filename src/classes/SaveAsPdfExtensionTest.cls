/**
 * Created by Pavel on 20.09.2019.
 */
@isTest(SeeAllData=false)
public with sharing class SaveAsPdfExtensionTest {
    @IsTest
    static void testRenderedContentTypeNeg() {
        Contact testCnt = new Contact(LastName = 'TestContact');
        insert testCnt;

        ApexPages.StandardController sc = new ApexPages.StandardController(testCnt);
        SaveAsPdfExtension testExtension = new SaveAsPdfExtension(sc);

        String testRenderedContentType = 'text/html';
        String result = testExtension.renderedContentType;
        System.assertEquals(result, testRenderedContentType);
    }

    @IsTest
    static void testRenderedContentTypePos() {
        Contact testCnt = new Contact(LastName = 'TestContact');
        insert testCnt;

        ApexPages.StandardController sc = new ApexPages.StandardController(testCnt);
        SaveAsPdfExtension testExtension = new SaveAsPdfExtension(sc);

        String testRenderedContentType = 'application/pdf';
        testExtension.saveToPdf();
        String result = testExtension.renderedContentType;
        System.assertEquals(result, testRenderedContentType);
    }

    @IsTest
    static void testRenderedContentTypeWithFileName() {
        Contact testCnt = new Contact(LastName = 'TestContact');
        insert testCnt;

        ApexPages.StandardController sc = new ApexPages.StandardController(testCnt);
        SaveAsPdfExtension testExtension = new SaveAsPdfExtension(sc);

        String testRenderedContentType = 'application/pdf';
        testExtension.renderedFileName = 'TestFile';
        testExtension.saveToPdf();
        String result = testExtension.renderedContentType;
        System.assertEquals(result, testRenderedContentType);
    }

    @isTest static void testGetImageId() {
        Contact testCnt = new Contact(LastName = 'TestContact');
        insert testCnt;

        Attachment testAtt = new Attachment();
        testAtt.Name = 'Test Attachment';
        testAtt.ParentId = testCnt.Id;
        Blob bodyBlob = Blob.valueOf('Unit Test Attachment Body');
        testAtt.body = bodyBlob;
        insert testAtt;

        ApexPages.StandardController sc = new ApexPages.StandardController(testCnt);
        SaveAsPdfExtension testExtension = new SaveAsPdfExtension(sc);
        String result = testExtension.getImageId();
        System.assertEquals(result, testAtt.Id);
    }
}