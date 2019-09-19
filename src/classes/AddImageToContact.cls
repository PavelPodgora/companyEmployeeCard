/**
 * Created by Pavel on 16.09.2019.
 */

public with sharing class AddImageToContact {
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
        try{
            if(attachment.Body != null) {
                if(attachment.Name.endsWith('.png') || attachment.Name.endsWith('.jpg') || attachment.Name.endsWith('.jpeg')){
                    attachment.ParentId = recId;
                    insert attachment;
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.CONFIRM, 'File uploaded'));
                    update attachment;
                }
                else{
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Invalid Type!!!'));
                }
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

        attachment = new Attachment();
//        PageReference pageRef = new PageReference('/apex/EmployeeCardImage');
//        pageRef.getParameters().put('id', recId);
//        pageRef.setRedirect(true);
        return null;

    }

    public List<Attachment> getAttachments() {
        List<Attachment> attachedFiles = [  SELECT Id
                                            FROM Attachment
                                            WHERE parentId = :recId
            ];
        if (attachedFiles.isEmpty() || attachedFiles.size() == null) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Error Uploading, file is BAD!!!'));
        }

        return attachedFiles;
    }

}