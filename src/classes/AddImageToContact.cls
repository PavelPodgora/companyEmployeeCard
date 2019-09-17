/**
 * Created by Pavel on 16.09.2019.
 */

public with sharing class AddImageToContact {

//    public Attachment att{get;set;}
//    private Id parentId{get;set;}
//
//    public AddImageToContact(ApexPages.StandardController controller){
//        att = new Attachment();
//        parentId = controller.getId();
//    }
//
//    public void uploadImage(){
//        att.parentId = parentId;
//        att.name = 'image';
//        insert att;
//        att = new Attachment();
//    }
//

    String recId;

    public AddImageToContact(ApexPages.StandardController controller) {
        recId = controller.getId();
    }

    public Attachment attachment{
        get{
            if(attachment == null)
                attachment = new Attachment();
            return attachment;
        }
        set;
    }

    public PageReference upload(){
        attachment.ParentId = recId;

        try{
            if(attachment.Name.endsWith('.png')||attachment.Name.endsWith('.jpg')||attachment.Name.endsWith('.jpeg')) {
                insert attachment;
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.CONFIRM, 'File uploaded'));
            }
            else {
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Invalid image type, add another file!'));
            }
        }
        catch(DmlException e){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Error Uploading, file is BAD!!!'));
            return null;
        }
        finally{
            attachment.Body = null;
        }

        return null;
    }
}