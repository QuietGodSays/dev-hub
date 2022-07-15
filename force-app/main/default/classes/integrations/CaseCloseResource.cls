@RestResource(UrlMapping='/case/*/close')
global with sharing class CaseCloseResource {
    @HttpPost
    global static void closeCase(String reason) {
        List<String> uriParts = RestContext.request.requestURI.split('/');
        Set<Id> caseIds = new Set<Id>{ uriParts.get(2) };
        CaseService.closeCases(caseIds, reason);
    }
}
