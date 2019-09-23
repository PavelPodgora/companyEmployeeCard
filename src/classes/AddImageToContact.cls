/**
 * Created by Pavel on 16.09.2019.
 */

public with sharing class AddImageToContact {
    String recId;

    public AddImageToContact(ApexPages.StandardController controller) {
        recId = controller.getId();
    }

    public Attachment attachment {
        get {
            if (attachment == null)
                attachment = new Attachment();
            return attachment;
        }
        set;
    }

    public PageReference upload() {
        if (attachment.Body != null) {
            if (attachment.Name.endsWith('.png') || attachment.Name.endsWith('.jpg') || attachment.Name.endsWith('.jpeg')) {
                attachment.ParentId = recId;
                insert attachment;
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.CONFIRM, 'File uploaded'));

            } else {
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Invalid Type!!!'));
            }
        } else {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Invalid image type, add another file!'));
        }

        attachment = new Attachment();
//        PageReference pageRef = new PageReference('/apex/EmployeeCardImage');
//        pageRef.getParameters().put('id', recId);
//        pageRef.setRedirect(true);
        return null;

    }

    public List<Attachment> getAttachments() {
        List<Attachment> attachedFiles = [
                SELECT Id
                FROM Attachment
                WHERE parentId = :recId
        ];

        return attachedFiles;
    }

    public Id AttachmentId { get; set; }

    public String getImageId() {
        AttachmentId = ApexPages.currentPage().getParameters().get('imageId');

        if (AttachmentId == null) {
            List<Attachment> attachedFiles = [
                    SELECT Id
                    FROM Attachment
                    WHERE parentId = :recId
                    ORDER BY LastModifiedDate
                            DESC
                    LIMIT 1
            ];
            if (attachedFiles != null && attachedFiles.size() > 0) {
                AttachmentId = attachedFiles[0].Id;
            }
        }

        return AttachmentId;
    }

    public void updateAttachments() {
        AttachmentId = ApexPages.currentPage().getParameters().get('imageId');
        if (AttachmentId != null) {
            Attachment attached = [
                    SELECT Id,Name
                    FROM Attachment
                    WHERE Id = :AttachmentId
            ];
            update attached;
        }
    }
}