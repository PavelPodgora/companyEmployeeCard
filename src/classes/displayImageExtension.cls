/**
 * Created by Pavel on 17.09.2019.
 */

public with sharing class displayImageExtension {
    String recId;

    public displayImageExtension(ApexPages.StandardController controller) {
        recId = controller.getId();
    }

    public String getFileId() {
        String fileId = '';
        List<Attachment> attachedFiles = [  SELECT      Id
                                            FROM        Attachment
                                            WHERE       ParentId =:recId
                                            ORDER BY    LastModifiedDate DESC
                                            LIMIT       1
        ];

        if( attachedFiles != null && attachedFiles.size() > 0 ) {
            fileId = attachedFiles[0].Id;
        }
        return fileId;
    }
}