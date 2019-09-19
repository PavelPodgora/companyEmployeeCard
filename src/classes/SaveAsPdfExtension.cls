/**
 * Created by Pavel on 15.09.2019.
 */

public with sharing class SaveAsPdfExtension {
    String recId;
// Required extension constructor (empty, no-op)
    public SaveAsPdfExtension(ApexPages.StandardController controller) {
        recId = controller.getId();
    }

    // Determines what kind of rendering to use for the page request
    public String renderingService { get; private set; }

    // Allow the page to set the PDF file name
    public String renderedFileName {
        get;
        set { renderedFileName = this.sanitizeFileName(value); }
    }

    // Rendered content MIME type, used to affect HTTP response
    public String renderedContentType {
        get {
            String renderedContentType = 'text/html'; // the default

            if( ! this.renderingAsHtml() ) {
                // Provides a MIME type for a PDF document
                renderedContentType = 'application/pdf';

                // Add a file name for the PDF file
                if( this.renderedFileName != null) {
                    // This is supposed to set the file name, but it doesn't work
                    renderedContentType += '#' + this.renderedFileName;

                    // This is a work-around to set the file name
                    ApexPages.currentPage().getHeaders().put(
                            'content-disposition', 'attachment; filename=' +
                                    this.renderedFileName);
                }
            }

            return renderedContentType;
        }
    }

    // Are we rendering to HTML or PDF?
    public Boolean renderingAsHtml() {
        return ( (renderingService == null) ||
                ( ! renderingService.startsWith('PDF')) );
    }

    // Action method to save (or "print") to PDF
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