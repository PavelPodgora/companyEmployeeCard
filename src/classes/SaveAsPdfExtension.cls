/**
 * Created by Pavel on 15.09.2019.
 */

public with sharing class SaveAsPdfExtension {
    String recId;

    public SaveAsPdfExtension(ApexPages.StandardController controller) {
        recId = controller.getId();
    }

    public String renderingService { get; private set; }

    public String renderedFileName {
        get;
        set { renderedFileName = this.sanitizeFileName(value); }
    }
    public String renderedContentType {
        get {
            String renderedContentType = 'text/html';

            if( ! this.renderingAsHtml() ) {
                renderedContentType = 'application/pdf';
                if( this.renderedFileName != null) {
                    ApexPages.currentPage().getHeaders().put(
                            'content-disposition', 'attachment; filename=' +
                                    this.renderedFileName);
                }
            }

            return renderedContentType;
        }
    }

    public Boolean renderingAsHtml() {
        return ( (renderingService == null) ||
                ( ! renderingService.startsWith('PDF')) );
    }

    public PageReference saveToPdf() {
        renderingService = 'PDF';
        return null;
    }

    private String sanitizeFileName(String unsafeName) {
        String allowedCharacters = '0-9a-zA-Z-_.';
        String sanitizedName =
                unsafeName.replaceAll('[^' + allowedCharacters + ']', '');
        return(sanitizedName);
    }

    public Id getImageId() {
        Id fileId = null;

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