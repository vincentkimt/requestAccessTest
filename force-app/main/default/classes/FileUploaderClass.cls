public with sharing class FileUploaderClass {
   
    

    @AuraEnabled
    public static string uploadFile(String base64, String filename, String recordId){
       ContentVersion cv=createContentVersion(base64,filename);
       ContentDocumentLink  cdl= createContentLink(cv.Id,recordId);
        if(cv == null || cdl == null){ return null;}
        return cdl.Id;



    }



    private static ContentVersion createContentVersion(String base64, String filename){
        ContentVersion cv = new ContentVersion();
        cv.VersionData = EncodingUtil.base64Decode(base64);
        if(filename=='' || String.isBlank(filename)){
            System.debug('file name is blank');

        }
        System.debug('file name is---'+filename);
        cv.Title= filename;
        cv.PathOnClient = filename;
        try{
            Insert cv;
            return cv;
        }catch(DMLException dml){
            System.debug('issue->'+dml);
            return null;

        }
    }


    private static ContentDocumentLink createContentLink(String ContentVersionId,String recordId){
        if (contentVersionId == null || recordId == null) { return null; }
        ContentDocumentLink cdLink=new ContentDocumentLink();
        cdLink.ContentDocumentId =[Select ContentDocumentId  From ContentVersion Where Id=:contentVersionId].ContentDocumentId ;
        cdLink.linkedEntityId = recordId;
        cdLink.shareType='V';
        try{
            Insert cdLink;
            return cdLink;
        }catch(DMLException dml){
            System.debug('issue->'+dml);
            return null;
        }
    }
}
