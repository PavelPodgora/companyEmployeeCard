/**
 * Created by Pavel on 17.09.2019.
 */

public with sharing class SaveNewData {
    String recId;

    public SaveNewData(ApexPages.StandardController controller) {
        recId = controller.getId();
    }

    public String getFileId() {
        String fileId = ApexPages.currentPage().getParameters().get('imageId');

        if (fileId == null) {
            List<Attachment> attachedFiles = [  SELECT Id
                                                FROM Attachment
                                                WHERE parentId = :recId
                                                ORDER BY LastModifiedDate DESC
                                                LIMIT 1
            ];
            if (attachedFiles != null && attachedFiles.size() > 0) {
                fileId = attachedFiles[0].Id;
            }
        }
        return fileId;
    }
}